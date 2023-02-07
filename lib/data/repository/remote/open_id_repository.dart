import 'package:flutter_appauth/flutter_appauth.dart';

import '../../model/api/base_response.dart';
import '../../model/sso/user_sso.dart';

abstract class OpenIDRepository {
  Future<ResponseWrapper<AuthorizationTokenResponse>> loginBySSORequest();

  Future<ResponseWrapper<bool>> refreshToken();

  Future<ResponseWrapper<UserSSO>> getUserInfo();
}
