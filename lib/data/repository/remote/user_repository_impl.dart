import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../../domain/entity/user/user.dart';
import '../../exceptions/handle_exception.dart';
import '../../model/api/base_response.dart';
import '../../model/login/login_response.dart';
import '../interceptor/dio_base_options.dart';
import '../local/local_data_access.dart';
import 'repository.dart';

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
    dio.options =
        DioBaseOptions(baseUrl: Environment.resourcesBaseUrl).baseOption;
  }

  @override
  Future<ResponseWrapper<LoginResponse>> loginRequest({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final loginResponse = await dio.post(
        EndPoints.login,
        data: {
          'username': username,
          'password': password,
          'rememberMe': rememberMe
        },
      );
      if (loginResponse.statusCode == 200) {
        return ResponseWrapper.success(
            data: LoginResponse.fromJson(loginResponse.data));
      } else if (loginResponse.statusCode == 400 ||
          loginResponse.statusCode == 401) {
        return ResponseWrapper.error(
            message: 'Tài khoản hoặc mật khẩu không chính xác',
            statusCode: loginResponse.statusCode);
      } else {
        return ResponseWrapper.error(
            message: 'Đăng nhập thất bại',
            statusCode: loginResponse.statusCode);
      }
    } on Exception catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
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
    final String accessToken = await localDataAccess.getAccessToken();
    final response = await dio.get('/api/getInformation',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  @override
  Future<Response> changePassword(
      {required String currentPassword, required String newPassword}) async {
    final String accessToken = await localDataAccess.getAccessToken();
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
  Future<Response> vcfFile(
      {required String username, required Object body}) async {
    final mBody = jsonEncode(body);
    final response = await dio.post('/gateway/Member/vcfFile',
        data: mBody, queryParameters: {"Username": username});
    return response;
  }

  @override
  Future<Response> getDetailMedia(
      {required String memberId, required String type}) async {
    final response = await dio.get(
        '${Environment.resourcesBaseUrl}/gateway/Member/memberViewMemberDetailMedia',
        queryParameters: {"memberId": memberId, "type": type});
    return response;
  }

  @override
  Future<ResponseWrapper<UserEntity>> getUser({String? userId}) async {
    // accessToken = await localDataAccess.getAccessToken();

    // final response = await dio.get(
    //   EndPoints.getUser,
    //   queryParameters: {
    //     'user-id': userId,
    //   }..removeWhere((key, value) => value == null),
    //   options: Options(
    //     headers: {'Authorization': 'Bearer $accessToken'},
    //   ),
    // );
    // try {
    //   if (response.statusCode == 200) {
    //     return ResponseWrapper.success(
    //         data: _userDataMapper
    //             .mapToEntity(UserResponse.fromJson(response.data)));
    //   }
    //   return ResponseWrapper.error(message: "");
    // } catch (e) {
    //   handleException(e);
    //   return ResponseWrapper.error(message: "");
    // }

    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<UserEntity>> updateUser(
      {required UserEntity user}) async {
    return ResponseWrapper.success(data: user);
  }
}
