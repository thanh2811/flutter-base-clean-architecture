import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constants.dart';
import 'local_data_access.dart';

class SharePrefHelper implements LocalDataAccess {
  final SharedPreferences sharedPref;
  late final secureStorage = const FlutterSecureStorage();

  SharePrefHelper({required this.sharedPref});

  @override
  void clearAccessToken() {
    sharedPref.remove(SharedPreferenceKey.idToken);
  }

  @override
  void clearRefreshToken() {
    sharedPref.remove(SharedPreferenceKey.refreshToken);
  }

  @override
  Future<String> getIdToken() async {
    return await secureStorage.read(key: SharedPreferenceKey.idToken) ?? '';
  }

  @override
  Future<String> getAccessToken() async {
    return await secureStorage.read(key: SharedPreferenceKey.accessToken) ?? '';
  }

  @override
  String getUserId() {
    return sharedPref.getString(SharedPreferenceKey.userId).toString();
  }

  @override
  Future<void> clearData() async {
    await secureStorage.delete(key: SharedPreferenceKey.idToken);
    await secureStorage.delete(key: SharedPreferenceKey.refreshToken);
    sharedPref.remove(SharedPreferenceKey.username);
    sharedPref.remove(SharedPreferenceKey.password);
    sharedPref.remove(SharedPreferenceKey.rememberMe);
  }

  @override
  bool getAccountRemember() {
    return sharedPref.getBool(SharedPreferenceKey.rememberMe) ?? false;
  }

  @override
  String getPassword() =>
      sharedPref.getString(SharedPreferenceKey.password) ?? '';

  @override
  String getUserName() =>
      sharedPref.getString(SharedPreferenceKey.username) ?? '';

  @override
  Future setAccessToken(String accessToken) async {
    await secureStorage.write(
        key: SharedPreferenceKey.accessToken, value: accessToken);
  }

  @override
  Future setIdToken(String idToken) async {
    await secureStorage.write(key: SharedPreferenceKey.idToken, value: idToken);
  }

  @override
  void setAccountRemember(bool accountRemember) {
    sharedPref.setBool(SharedPreferenceKey.rememberMe, accountRemember);
  }

  @override
  void setPassword(String password) {
    sharedPref.setString(SharedPreferenceKey.password, password);
  }

  @override
  void setUserId(String userId) {
    sharedPref.setString(SharedPreferenceKey.userId, userId);
  }

  @override
  void setUsername(String username) {
    sharedPref.setString(SharedPreferenceKey.username, username);
  }

  @override
  Future<String> getRefreshToken() async =>
      await secureStorage.read(key: SharedPreferenceKey.refreshToken) ?? '';

  @override
  Future setRefreshToken(String refreshToken) async => await secureStorage
      .write(key: SharedPreferenceKey.refreshToken, value: refreshToken);
}
