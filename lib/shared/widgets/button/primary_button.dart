import '../../../config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../something/bouncing.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.context,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.iconColor = Colors.black,
    this.borderColor,
    this.textStyle = AppTextTheme.textButtonPrimary,
    this.icon,
    this.isLoading = false,
    this.isClickable = true,
    this.isCircle = false,
    this.contentPadding = 14,
  });

  final BuildContext context;
  final Function() onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final TextStyle textStyle;
  final dynamic icon;
  final bool isLoading;
  final bool isClickable;
  final bool isCircle;
  final double contentPadding;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPressed: () {},
      child: ElevatedButton(
        onPressed: () async {
          Future.delayed(const Duration(milliseconds: 100), () {
            onPressed.call();
          });
        },
        // color: backgroundColor ?? AppColor.primaryColor,
        // splashColor: (backgroundColor ?? AppColor.primaryColor).withOpacity(0.9),
        // elevation: 4,
        // // highlightElevation: 26,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        style: ButtonStyle(
          fixedSize:
              isCircle ? MaterialStateProperty.all(const Size(0, 0)) : null,
          backgroundColor: MaterialStateProperty.all(
            backgroundColor ?? AppColor.primaryColor,
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(contentPadding)),
          elevation: MaterialStateProperty.all(4),
          shape: MaterialStateProperty.all(
            isCircle
                ? CircleBorder(
                    side: borderColor != null
                        ? BorderSide(color: borderColor!)
                        : BorderSide.none,
                  )
                : RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppConfig.defaultRadius)),
                    side: borderColor != null
                        ? BorderSide(color: borderColor!)
                        : BorderSide.none,
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? Container()
                : icon is String
                    ? SvgPicture.asset(icon,
                        height: 20, width: 20, color: iconColor)
                    : Icon(
                        icon,
                        size: 20,
                        color: iconColor,
                      ),
            (icon == null)
                ? Container()
                : (!isCircle)
                    ? const SizedBox(width: 5)
                    : Container(),
            isLoading
                ? const CircularProgressIndicator()
                : Text(
                    label,
                    style: textStyle,
                  ),
          ],
        ),
      ),
    );
  }
}
