import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../../di/di.dart';
import '../../exceptions/handle_exception.dart';
import '../../model/api/base_response.dart';
import '../../model/login/login_response.dart';
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

    // dio.interceptors.add(AppInterceptor().queueInterceptor(dio: dio));
    dio.options = DioBaseOptions(baseUrl: SSOConfig.issuer).baseOption;
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
          "username": username,
          "password": password,
          "client_id": SSOConfig.clientId,
          "client_secret": SSOConfig.clientSecret,
          "platformOS": "mobile"
        },
      );
      if (loginResponse.statusCode == 200) {
        final defaultResponse = DefaultResponse<LoginResponse>.fromJson(
            loginResponse.data,
            (json) => LoginResponse.fromJson(json as Map<String, dynamic>));
        if (defaultResponse.success) {
          return ResponseWrapper.success(
              data: LoginResponse.fromJson(loginResponse.data));
        } else {
          switch (defaultResponse.statusCode) {
            case 2000:
              return ResponseWrapper.error(
                  message: 'Tài khoản hoặc mật khẩu không chính xác');
            case 2001:
              return ResponseWrapper.error(
                  message:
                      'Tài khoản của bạn đã tạm thời bị khoá. Liên hệ với đội ngũ CSKH để được tư vấn thêm.');
            default:
          }
        }
      } else if (loginResponse.statusCode == 400 ||
          loginResponse.statusCode == 401) {
        return ResponseWrapper.error(
            message: 'Tài khoản hoặc mật khẩu không chính xác',
            statusCode: loginResponse.statusCode);
      }
      return ResponseWrapper.error(
          message: 'Đăng nhập thất bại', statusCode: loginResponse.statusCode);
    } on Exception catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: 'message');
    }
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
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: '${SSOConfig.issuer}/connect/authorize',
            tokenEndpoint: '${SSOConfig.issuer}/connect/token',
            endSessionEndpoint: '${SSOConfig.issuer}/connect/endsession',
          ),
        ),
      );

      return ResponseWrapper.success(data: authorizationTokenResponse!);
    } catch (e) {
      return ResponseWrapper.error(message: e.toString());
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
      refreshToken: await localDataAccess.getRefreshToken(),
      serviceConfiguration: AuthorizationServiceConfiguration(
        authorizationEndpoint: '${SSOConfig.issuer}/connect/authorize',
        tokenEndpoint: '${SSOConfig.issuer}/connect/token',
        endSessionEndpoint: '${SSOConfig.issuer}/connect/endsession',
      ),
    );
    try {
      final TokenResponse? tokenResponse = await appAuth.token(tokenRequest);
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
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> endSession() async {
    try {
      await appAuth.endSession(
        EndSessionRequest(
          idTokenHint: await localDataAccess.getIdToken(),
          issuer: SSOConfig.issuer,
          postLogoutRedirectUrl: SSOConfig.redirectUrl,
          allowInsecureConnections: true,
          serviceConfiguration: AuthorizationServiceConfiguration(
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
      return ResponseWrapper.error(data: false, message: '');
    }
  }
}
