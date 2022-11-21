import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/network_injection.dart';
import '../../constants.dart';

class SharePrefHelper {
  final sharedPref = getIt.get<SharedPreferences>();

  void clearAccessToken() {
    sharedPref.remove(SharedPreferenceKey.idToken);
  }

  String getAccessToken() {
    return sharedPref.getString(SharedPreferenceKey.idToken) ?? '';
  }

  void clearData() {
    sharedPref.remove(SharedPreferenceKey.idToken);
    sharedPref.remove(SharedPreferenceKey.username);
    sharedPref.remove(SharedPreferenceKey.password);
    sharedPref.remove(SharedPreferenceKey.rememberMe);
  }
}
