import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/resources/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.backgroundColor, this.size = 50})
      : super(key: key);

  final Color? backgroundColor;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor ?? AppColor.bgColor,
        child: SpinKitFadingCircle(
          duration: const Duration(milliseconds: 600),
          color: (backgroundColor == Colors.transparent)
              ? AppColor.primaryColor
              : AppColor.primaryColor,
          size: size,
        ),
      ),
    );
  }
}
