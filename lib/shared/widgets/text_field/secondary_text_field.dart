import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';

class SecondaryTextField extends StatelessWidget {
  const SecondaryTextField({
    Key? key,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
  }) : super(key: key);

  final String label;
  final dynamic prefixIcon;
  final String? suffixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextTheme.textPrimary,
      controller: controller,
      minLines: 1,
      maxLines: 100,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: AppTextTheme.textPrimary,
        filled: true,
        fillColor: AppColor.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 0.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 1),
        ),
        prefixIcon: prefixIcon == null
            ? null
            : (prefixIcon is String)
                ? SvgPicture.asset(
                    prefixIcon ?? '',
                    height: 20,
                    width: 16,
                    fit: BoxFit.scaleDown,
                  )
                : prefixIcon,
        suffixIcon: suffixIcon != null ? SvgPicture.asset(suffixIcon!) : null,
      ),
    );
  }
}
