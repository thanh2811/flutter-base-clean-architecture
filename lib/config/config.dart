import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/resources/colors.dart';

class Environment {
  static String fileName =
      kDebugMode ? 'app_config_test.env' : 'app_config_product.env';
  static String domain = dotenv.env['DOMAIN'] ?? '';
  static String resourcesBaseUrl = dotenv.env['BASE_RESOURCE_URL'] ?? '';
  static String ssoBaseUrl = dotenv.env['SSO_BASE_URL'] ?? '';
  static String cdnBaseUrl = dotenv.env['CDN_BASE_URL'] ?? '';
}

class EndPoints {
  // sso related
  static const String getUserInfoSSO = '/user/updateinfo';
  static const String deactiveUser = '/user/de-active';

  // static const String baseDomain = "https://dms.fitolabs.vn";
  // static const String idBaseUrl = "https://id.fitolabs.vn";
  // static const String appBaseUrl = "https://dms-m.fitolabs.vn";
  static const String publicAddressBaseUrl =
      "https://provinces.open-api.vn/api/p";

  // user related
  static const String login = '/api/authenticate';
  static const String getAccountInfo = '/api/account';
  static const String changePassword = '/api/account/change-password';

  // employee related
  static const String getEmployeeByIdForUser =
      '/gw/Employee/GetEmployeeByIdForUser';
  static const String getMemberDetailInfo =
      '/gateway/Member/memberViewMemberInformation';
  static const String getMemberBasicInfo = '/api/getInformation';

  // storage repository
  static const String uploadImage = "/gateway/Image/Upload";
}

class SSOConfig {
  static String fileName =
      kDebugMode ? 'app_config_test.env' : 'app_config_product.env';

  static String issuer = dotenv.env['SSO_ISSUER'] ?? '';
  static String clientId = dotenv.env['SSO_CLIENT_ID'] ?? '';
  static String clientSecret = dotenv.env['SSO_CLIENT_SECRET'] ?? '';
  static String ssoApiUrl = dotenv.env['SSO_API_URL'] ?? '';
  static String redirectUrl = dotenv.env['SSO_REDIRECT_URL'] ?? '';
  static const String postLogoutRedirectUrl =
      "com.eztek.trueconnect://logout-callback";

  // static const String clientSecret = 'M)rVENCz5GFT@yPR';
  static const List<String> scope = [
    "openid",
    "profile",
    "email",
    "roles",
    "offline_access"
  ];
}

class AppConfig {
  static const String appName = "Project name";
  static const String fontFamily = "Lato";
  static const Color primaryColor = AppColor.primaryColor;
  static const MaterialColor primarySwatch = AppColor.primarySwatch;
  static const double primaryFontSize = 14;
  static const FontWeight defaultFontWeight = FontWeight.w400;
  static const double defaultPadding = 16;
  static const double defaultRadius = 8;
}
