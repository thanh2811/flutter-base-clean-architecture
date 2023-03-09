import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';

class PrimaryDropDownFormField extends StatefulWidget {
  final List<String> items;
  final Function(String?)? onChanged;
  /// set the initial value when the first build invoked
  final String? initialValue;
  final BoxDecoration? decoration;
  final String? hintText;
  final TextEditingController controller;

  final Widget Function(dynamic value)? child;

  const PrimaryDropDownFormField({
    Key? key,
    required this.items,
    this.decoration,
    this.onChanged,
    this.initialValue,
    this.hintText,
    this.child,
    required this.controller,
  }) : super(key: key);

  @override
  State<PrimaryDropDownFormField> createState() =>
      _PrimaryDropDownFormFieldState();
}

class _PrimaryDropDownFormFieldState extends State<PrimaryDropDownFormField> {
  String? value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      dropdownDecoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(2),
      ),
      value: value,
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: widget.child == null
              ? Text(value, style: AppTextTheme.textPrimary)
              : widget.child!.call(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          this.value = value.toString();
          widget.controller.text = value.toString();
        });
        widget.onChanged?.call(value);
      },
      isExpanded: true,
      iconSize: 24,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.only(top: 8, bottom: 8, right: 12, left: 12),
        hintText: widget.hintText,
        hintStyle: AppTextTheme.textHintPrimary,
        labelStyle: AppTextTheme.textPrimary,
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.gray04),
          borderRadius: BorderRadius.circular(2),
        ),
        filled: true,
      ),
    );
  }

  DropdownMenuItem<String> dropdownMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item,
          style: AppTextTheme.textPrimary,
        ),
      ),
    );
  }
}
