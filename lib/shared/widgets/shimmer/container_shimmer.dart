import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';


class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer({
    Key? key,
    this.width = 100,
    this.height = 20,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: AppColor.bgCardColor),
    );
  }
}
