import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../../services/exceptions/handle_exception.dart';
import '../../model/api/base_response.dart';
import '../../model/sso/user_sso.dart';
import '../local/local_data_access.dart';
import 'repository.dart';

class OpenIDRepositoryImpl implements OpenIDRepository {
  final LocalDataAccess localDataAccess;
  final FlutterAppAuth appAuth = const FlutterAppAuth();
  final Dio dio;

  OpenIDRepositoryImpl({required this.dio, required this.localDataAccess}) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    final BaseOptions options = BaseOptions(
      baseUrl: EndPoints.ssoBaseUrl,
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
  Future<ResponseWrapper<AuthorizationTokenResponse>>
      loginBySSORequest() async {
    try {
      final AuthorizationTokenResponse? authorizationTokenResponse =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          SSOConfig.clientId,
          SSOConfig.redirectUrl,
          clientSecret: SSOConfig.clientSecret,
          issuer: SSOConfig.issuer,
          scopes: SSOConfig.scope,
        ),
      );
      localDataAccess
          .setAccessToken(authorizationTokenResponse?.accessToken ?? '');
      localDataAccess
          .setRefreshToken(authorizationTokenResponse?.refreshToken ?? '');

      log('auth response idToken: ${authorizationTokenResponse?.idToken}');
      log('auth response access: ${authorizationTokenResponse?.accessToken}');
      log('auth response exp: ${authorizationTokenResponse?.accessTokenExpirationDateTime}');
      log('auth response refresh: ${authorizationTokenResponse?.refreshToken}');
      log('auth response token type: ${authorizationTokenResponse?.tokenType}');
      log('auth response scopes: ${authorizationTokenResponse?.scopes.toString()}');
      log('auth response token additional params: ${authorizationTokenResponse?.tokenAdditionalParameters.toString()}');

      return ResponseWrapper.success(data: authorizationTokenResponse!);
    } catch (e) {
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<bool>> refreshToken() async {
    final TokenRequest tokenRequest = TokenRequest(
      SSOConfig.clientId,
      SSOConfig.redirectUrl,
      clientSecret: SSOConfig.clientSecret,
      issuer: SSOConfig.issuer,
      scopes: SSOConfig.scope,
      refreshToken: localDataAccess.getRefreshToken(),
    );
    try {
      final TokenResponse? tokenResponse = await appAuth.token(tokenRequest);
      if (tokenResponse?.accessToken == null) {
        return ResponseWrapper.error(message: '');
      }
      localDataAccess.setAccessToken(tokenResponse?.accessToken ?? '');
      localDataAccess.setRefreshToken(tokenResponse?.refreshToken ?? '');
      return ResponseWrapper.success(data: true);
    } catch (e) {
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<UserSSO>> getUserInfo() async {
    try {
      final String accessToken = localDataAccess.getAccessToken();
      final response = await dio.get(EndPoints.getUserInfoSSO,
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      return ResponseWrapper.success(data: UserSSO.fromJson(response.data));
      // if(response.statusCode == 200){
      // }
      // return ResponseWrapper.error(message: "Đã xảy ra lỗi");
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }
}
