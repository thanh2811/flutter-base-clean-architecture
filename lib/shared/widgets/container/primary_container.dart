import 'package:flutter/material.dart';

import '../../../data/resources/resources.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  const PrimaryContainer(
      {Key? key,
      this.child,
      this.backgroundColor = AppColor.white,
      this.borderColor,
      this.borderRadius = 2,
      this.padding,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius!),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: child,
    );
  }
}
