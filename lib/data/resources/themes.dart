import '../../config/config.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextTheme {
  static const TextStyle textPageTitle = TextStyle(
    color: AppColor.black,
    // overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const TextStyle textGreeting = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 36,
  );

  static const TextStyle textPrimary = TextStyle(
    color: AppColor.black,
    fontWeight: AppConfig.defaultFontWeight,
    fontSize: AppConfig.primaryFontSize,
  );

  static const TextStyle textPrimaryColor = TextStyle(
    color: AppColor.primaryColor,
    fontWeight: AppConfig.defaultFontWeight,
    fontSize: AppConfig.primaryFontSize,
  );

  static const TextStyle textPrimaryBlue = TextStyle(
    color: AppColor.blue,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  static const TextStyle textPrimaryMedium = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const TextStyle textPrimaryBoldMedium = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle textTableLabel = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    // overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textPrimaryBold = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 15,
  );

  static const TextStyle textStyle16600 = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textStyleSubTitle = TextStyle(
    color: AppColor.divColor,
    fontSize: 16,
    // overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textStyle14400Grey = TextStyle(
    color: AppColor.gray,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    // overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textPrimaryLarge = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static TextStyle textPrimarySmall = const TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static TextStyle textPrimarySmallGreen = const TextStyle(
    color: AppColor.green,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static const TextStyle textPrimaryWhite = TextStyle(
    color: AppColor.white,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  static const TextStyle textPrimaryGreen = TextStyle(
    color: AppColor.green,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const TextStyle textPrimaryGreenItalic = TextStyle(
    color: AppColor.green,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle textAppBarPrimary = TextStyle(
    color: AppColor.white,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );

  static const TextStyle textLowPriority = TextStyle(
    color: Color.fromARGB(255, 184, 182, 182),
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const TextStyle textHintPrimary = TextStyle(
    color: Color.fromARGB(255, 97, 97, 97),
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static const TextStyle textButtonPrimary = TextStyle(
    color: AppColor.btPrimary,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    // overflow: TextOverflow.ellipsis,
  );
  static const TextStyle textRed = TextStyle(
    color: AppColor.errorColor,
    // overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
}
