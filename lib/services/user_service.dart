import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../data/constants.dart';

class UserApi {
  final Dio dio;

  UserApi(
    Dio? dio,
  ) : dio = dio ?? Dio() {
    this.dio.interceptors.add(PrettyDioLogger(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
        ));
    final BaseOptions options = BaseOptions(
      baseUrl: EndPoints.idBaseUrl,
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
    this.dio.options = options;
  }

  Future<Response<dynamic>> login(
      String username, String password, bool rememberMe) async {
    var body = jsonEncode(
        {'username': username, 'password': password, 'rememberMe': rememberMe});
    final loginResponse = await dio.post(EndPoints.login, data: body);
    return loginResponse;
  }

  Future<Response> getForgotPasswordMethod({required String username}) async {
    final response = await dio.get('/api/account/forgot-password-method',
        queryParameters: {"Login": username});
    return response;
  }

  Future<Response> sendOTP(
      {required String username,
      required String type,
      required String value}) async {
    final body = jsonEncode({"login": username, "type": type, "value": value});
    final response =
        await dio.post('/api/account/forgot-password-Getotp', data: body);
    return response;
  }

  Future<Response> checkOTP(
      {required String username, required String key}) async {
    final body = jsonEncode({"login": username, "key": key});
    final response =
        await dio.post('/api/account/forgot-password-CheckOtp', data: body);
    return response;
  }

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

  Future<Response> verifiedEmailOtp(
      {required String username, required String value}) async {
    final body = jsonEncode({"login": username, "value": value});
    final response =
        await dio.post('/api/account/verified-email-otp', data: body);
    return response;
  }

  Future<Response> verifiedEmailComplete(
      {required String username, required String key}) async {
    final body = jsonEncode({"login": username, "key": key});
    final response =
        await dio.post('/api/account/verified-email-complete', data: body);
    return response;
  }

  Future<Response> getInformation() async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get('/api/getInformation',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  Future<Response> changePassword(
      {required String currentPassword, required String newPassword}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
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

  Future<Response> getAccountInfo() async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get(EndPoints.getAccountInfo,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  Future<Response> getEmployeeInfo() async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get(EndPoints.getEmployeeByIdForUser,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  Future<Response> getAllGroupByType({required type}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get(EndPoints.getAllGroupByType,
        queryParameters: {
          'type': type,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  Future<Response> getAllGroupByEmployeeId({required id}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get(
      EndPoints.getAllGroupByEmployeeId,
      queryParameters: {
        "employeeId": id,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );

    return response;
  }
}
