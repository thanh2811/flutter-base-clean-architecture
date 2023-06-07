import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../../di/di.dart';
import '../../exceptions/handle_exception.dart';
import '../../model/api/base_response.dart';
import '../../model/sso/user_sso.dart';
import '../interceptor/dio_base_options.dart';
import '../local/local_data_access.dart';
import 'open_id_repository.dart';

class OpenIDRepositoryImpl implements OpenIDRepository {
  final LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();
  // final AppInterceptor appInterceptor = AppInterceptor();

  final FlutterAppAuth appAuth = const FlutterAppAuth();
  final Dio dio;

  OpenIDRepositoryImpl({
    required this.dio,
  }) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));

    // dio.interceptors.add(appInterceptor.queueInterceptor(dio: dio));
    dio.options = DioBaseOptions(baseUrl: SSOConfig.issuer).baseOption;
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
          // promptValues: ['login'],
          issuer: SSOConfig.issuer,
          scopes: SSOConfig.scope,
          serviceConfiguration: const AuthorizationServiceConfiguration(
            authorizationEndpoint: '${SSOConfig.issuer}/connect/authorize',
            tokenEndpoint: '${SSOConfig.issuer}/connect/token',
            endSessionEndpoint: '${SSOConfig.issuer}/connect/endsession',
          ),
        ),
      );
      localDataAccess
          .setAccessToken(authorizationTokenResponse?.accessToken ?? '');
      await localDataAccess
          .setIdToken(authorizationTokenResponse?.idToken ?? '');
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
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> refreshToken() async {
    log(' refresh token response ???');
    final TokenRequest tokenRequest = TokenRequest(
      SSOConfig.clientId,
      SSOConfig.redirectUrl,
      clientSecret: SSOConfig.clientSecret,
      issuer: SSOConfig.issuer,
      scopes: SSOConfig.scope,
      refreshToken: await localDataAccess.getRefreshToken(),
      serviceConfiguration: const AuthorizationServiceConfiguration(
        authorizationEndpoint: '${SSOConfig.issuer}/connect/authorize',
        tokenEndpoint: '${SSOConfig.issuer}/connect/token',
        endSessionEndpoint: '${SSOConfig.issuer}/connect/endsession',
      ),
    );
    try {
      final TokenResponse? tokenResponse = await appAuth.token(tokenRequest);
      log(' refresh token response: ${tokenResponse?.accessToken}');
      log(' refresh token response: ${tokenResponse?.refreshToken}');
      if (tokenResponse?.accessToken == null) {
        return ResponseWrapper.error(message: '');
      }
      await localDataAccess.setIdToken(tokenResponse?.idToken ?? '');
      await localDataAccess.setAccessToken(tokenResponse?.accessToken ?? '');
      await localDataAccess.setRefreshToken(tokenResponse?.refreshToken ?? '');
      return ResponseWrapper.success(data: true);
    } catch (e) {
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<UserSSO>> getUserInfo() async {
    try {
      final String accessToken = await localDataAccess.getAccessToken();
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

  @override
  Future<ResponseWrapper<bool>> endSession() async {
    try {
      final response = await appAuth.endSession(
        EndSessionRequest(
          idTokenHint: await localDataAccess.getIdToken(),
          issuer: SSOConfig.issuer,
          postLogoutRedirectUrl: SSOConfig.redirectUrl,
          allowInsecureConnections: true,
          serviceConfiguration: const AuthorizationServiceConfiguration(
            authorizationEndpoint: '${SSOConfig.issuer}/connect/authorize',
            tokenEndpoint: '${SSOConfig.issuer}/connect/token',
            endSessionEndpoint: '${SSOConfig.issuer}/connect/endsession',
          ),
        ),
      );
      return ResponseWrapper.success(data: true);
    } catch (err) {
      return ResponseWrapper.success(data: true);
    }
  }

  @override
  Future<ResponseWrapper<bool>> requestDeactive(
      {required bool isDeactive}) async {
    try {
      final response = await dio.get(EndPoints.deactiveUser, queryParameters: {
        'username': localDataAccess.getUserName(),
      });
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(data: false, message: '');
    } catch (err) {
      log('$err 🍍');
      return ResponseWrapper.error(data: false, message: '');
    }
  }
}
