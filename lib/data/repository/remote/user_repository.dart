import 'package:base_project/data/model/login/login_response.dart';
import 'package:dio/dio.dart';

import '../../model/api/base_response.dart';

abstract class UserRepository {
  Future<ResponseWrapper<LoginResponse>> login({
    required String username,
    required String password,
    required bool rememberMe,
  });

  Future<Response> getForgotPasswordMethod({required String username});

  Future<Response> sendOTP(
      {required String username, required String type, required String value});

  Future<Response> checkOTP({required String username, required String key});

  Future<Response> forgotPasswordComplete(
      {required String newPassword,
      required String username,
      required String key});

  Future<Response> verifiedEmailOtp(
      {required String username, required String value});

  Future<Response> verifiedEmailComplete(
      {required String username, required String key});

  Future<Response> getInformation();

  Future<Response> getAccountInfo();

  Future<Response> getEmployeeInfo();

  Future<Response> changePassword(
      {required String currentPassword, required String newPassword});
}
