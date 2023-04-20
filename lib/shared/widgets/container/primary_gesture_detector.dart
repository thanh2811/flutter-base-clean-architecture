import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../something/bouncing.dart';

class PrimaryGestureDetector extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  final Color? splashColor;
  final Color? highlightColor;
  const PrimaryGestureDetector(
      {Key? key,
      this.onTap,
      required this.child,
      this.splashColor = Colors.transparent,
      this.highlightColor = AppColor.gray09})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      child: InkWell(
        splashColor: splashColor,
        highlightColor: highlightColor,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
