import 'package:flutter/material.dart';

class BaseDropdownValue {
  final String? id;
  final String? valueStr;
  final String? prefixImageUrl;
  final Widget? prefixWidget;

  const BaseDropdownValue({
    this.id,
    this.valueStr,
    this.prefixImageUrl,
    this.prefixWidget,
  });
}
