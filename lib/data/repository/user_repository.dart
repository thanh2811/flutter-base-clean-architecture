import 'package:dio/dio.dart';
import '../../services/user_service.dart';

class UserRepository {
  final UserApi api;

  UserRepository({required this.api});

  Future<Response<dynamic>> loginRequest({
    required String username,
    required String password,
    required bool rememberMe,
  }) =>
      api.login(username, password, rememberMe);

  Future<Response> getForgotPasswordMethod({required String username}) =>
      api.getForgotPasswordMethod(username: username);

  Future<Response> sendOTP(
          {required String username,
          required String type,
          required String value}) =>
      api.sendOTP(username: username, type: type, value: value);

  Future<Response> checkOTP({required String username, required String key}) =>
      api.checkOTP(username: username, key: key);

  Future<Response> forgotPasswordComplete(
          {required String newPassword,
          required String username,
          required String key}) =>
      api.forgotPasswordComplete(
          newPassword: newPassword, username: username, key: key);

  Future<Response> verifiedEmailOtp(
          {required String username, required String value}) =>
      api.verifiedEmailOtp(username: username, value: value);

  Future<Response> verifiedEmailComplete(
          {required String username, required String key}) =>
      api.verifiedEmailComplete(username: username, key: key);

  Future<Response> getInformation() => api.getInformation();

  Future<Response> getAccountInfo() => api.getAccountInfo();

  Future<Response> getEmployeeInfo() => api.getEmployeeInfo();

  Future<Response> getAllGroupByType({required type}) =>
      api.getAllGroupByType(type: type);

  Future<Response> getAllGroupByEmployeeId({required String id}) =>
      api.getAllGroupByEmployeeId(id: id);

  Future<Response> changePassword(
          {required String currentPassword, required String newPassword}) =>
      api.changePassword(
          currentPassword: currentPassword, newPassword: newPassword);
}
