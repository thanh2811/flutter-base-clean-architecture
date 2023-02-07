import 'package:flutter/material.dart';

import '../data/resources/colors.dart';

class EndPoints {
  static const String baseDomain = "https://fitolabs.eztek.net";
  static const String resourcesBaseUrl = "https://fitolabs-id.eztek.net";
  static const String ssoBaseUrl = "https://id-test.trueconnect.vn";
  static const String appBaseUrl = "https://fitolabs-m.eztek.net";
  static const String cdnBaseUrl = "https://cdn-fitolabs.eztek.net";


  // sso related
  static const String getUserInfoSSO = '/user/updateinfo';

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
  static const String clientId = "localhost_identity";
  // static const String clientId = "eztek_resource_planning";
  static const String redirectUrl = "com.eztek.trueconnect://login-callback";
  // static const String redirectUrl = "https:google.com";
  static const String issuer = 'https://id-test.trueconnect.vn';
  // static const String issuer = 'https://id.eztek.net';
  static const String clientSecret = 'no_important';
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
}
