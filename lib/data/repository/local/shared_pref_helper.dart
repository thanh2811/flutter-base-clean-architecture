import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'local_data_access.dart';

class SharePrefHelper implements LocalDataAccess {
  final SharedPreferences sharedPref;

  SharePrefHelper({required this.sharedPref});

  @override
  void clearAccessToken() {
    sharedPref.remove(SharedPreferenceKey.idToken);
  }

  @override
  String getAccessToken() {
    return sharedPref.getString(SharedPreferenceKey.idToken) ?? '';
  }

  @override
  String getUserId() {
    return sharedPref.getString(SharedPreferenceKey.userId).toString();
  }

  @override
  void clearData() {
    sharedPref.remove(SharedPreferenceKey.idToken);
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
  void setAccessToken(String accessToken) {
    sharedPref.setString(SharedPreferenceKey.idToken, accessToken);
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
  String getRefreshToken() =>
      sharedPref.getString(SharedPreferenceKey.refreshToken) ?? '';

  @override
  void setRefreshToken(String refreshToken) =>
      sharedPref.setString(SharedPreferenceKey.refreshToken, refreshToken);
}
