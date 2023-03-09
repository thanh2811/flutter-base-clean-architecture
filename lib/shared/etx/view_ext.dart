import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  double screenHeight() => MediaQuery.of(this).size.height;
  double screenWidth() => MediaQuery.of(this).size.width;
}
