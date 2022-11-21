import 'package:flutter/material.dart';

import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.context,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.icon,
  });

  final BuildContext context;
  final Function() onPressed;
  final String label;
  final Color? backgroundColor;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColor.primaryColor,
        elevation: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon == null ? Container() : Icon(icon, size: 20),
          icon == null ? Container() : const SizedBox(width: 5),
          Text(
            label,
            style: AppTextTheme.textButtonPrimary,
          ),
        ],
      ),
    );
  }
}
