import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:base_project/data/model/api/base_response.dart';
import 'package:base_project/data/model/login/login_response.dart';
import 'package:base_project/data/repository/local/local_data_access.dart';
import 'package:base_project/data/repository/remote/user_repository.dart';
import 'package:base_project/services/exceptions/handle_exception.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio dio;
  final LocalDataAccess localDataAccess;

  UserRepositoryImpl({
    required this.dio,
    required this.localDataAccess,
  }) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    final BaseOptions options = BaseOptions(
      baseUrl: EndPoints.resourcesBaseUrl,
      sendTimeout: 30000,
      receiveTimeout: 30000,
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 500;
      },
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    dio.options = options;
  }

  @override
  Future<ResponseWrapper<LoginResponse>> login(
      {required String username,
      required String password,
      required bool rememberMe}) async {
    try {
      final loginResponse = await dio.post(
        EndPoints.login,
        data: {
          'username': username,
          'password': password,
          'rememberMe': rememberMe
        },
      );
      if(loginResponse.statusCode == 200) {
        return ResponseWrapper.success(data: LoginResponse.fromJson(loginResponse.data)) ;
      }else if(loginResponse.statusCode == 400 || loginResponse.statusCode == 401){
        return ResponseWrapper.error(message: 'Tài khoản hoặc mật khẩu không chính xác', statusCode: loginResponse.statusCode);
      }
      else{
        return ResponseWrapper.error(message: 'Đăng nhập thất bại', statusCode: loginResponse.statusCode);
      }
    } on Exception catch (e) {
      log('exception: $e');
      handleException(e);
      return ResponseWrapper.error(message: 'message');
    }
  }

  @override
  Future<Response> getForgotPasswordMethod({required String username}) async {
    final response = await dio.get('/api/account/forgot-password-method',
        queryParameters: {"Login": username});
    return response;
  }

  @override
  Future<Response> sendOTP(
      {required String username,
      required String type,
      required String value}) async {
    final response = await dio.post(
      '/api/account/forgot-password-Getotp',
      data: {
        "login": username,
        "type": type,
        "value": value,
      },
    );
    return response;
  }

  @override
  Future<Response> checkOTP(
      {required String username, required String key}) async {
    final response = await dio.post(
      '/api/account/forgot-password-CheckOtp',
      data: {
        "login": username,
        "key": key,
      },
    );
    return response;
  }

  @override
  Future<Response> forgotPasswordComplete(
      {required String newPassword,
      required String username,
      required String key}) async {
    final body =
        jsonEncode({"newPassword": newPassword, "login": username, "key": key});
    final response =
        await dio.post('/api/account/forgot-password-complete', data: body);
    return response;
  }

  @override
  Future<Response> verifiedEmailOtp(
      {required String username, required String value}) async {
    final body = jsonEncode({"login": username, "value": value});
    final response =
        await dio.post('/api/account/verified-email-otp', data: body);
    return response;
  }

  @override
  Future<Response> verifiedEmailComplete(
      {required String username, required String key}) async {
    final body = jsonEncode({"login": username, "key": key});
    final response =
        await dio.post('/api/account/verified-email-complete', data: body);
    return response;
  }

  @override
  Future<Response> getInformation() async {
    final String accessToken = localDataAccess.getAccessToken();
    final response = await dio.get('/api/getInformation',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  @override
  Future<Response> changePassword(
      {required String currentPassword, required String newPassword}) async {
    final String accessToken = localDataAccess.getAccessToken();
    final response = await dio.post(EndPoints.changePassword,
        data: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  @override
  Future<Response> getAccountInfo() async {
    final String accessToken = localDataAccess.getAccessToken();
    final response = await dio.get(EndPoints.getAccountInfo,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  @override
  Future<Response> getEmployeeInfo() async {
    final String accessToken = localDataAccess.getAccessToken();
    final response = await dio.get(EndPoints.getEmployeeByIdForUser,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }
}
