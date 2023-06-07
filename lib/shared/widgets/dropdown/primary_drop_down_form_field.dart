import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import 'base_dropdown_value.dart';

// ignore: must_be_immutable
class PrimaryDropDownFormField extends StatefulWidget {
  List<BaseDropdownValue>? items;
  final Function(BaseDropdownValue)? onChanged;

  /// set the initial value when the first build invoked
  final BaseDropdownValue? initialValue;
  final BoxDecoration? decoration;
  final String? hintText;
  final TextEditingController controller;
  final Color? fillColor;
  final Color? borderColor;

  final Widget Function(dynamic value)? child;

  PrimaryDropDownFormField({
    Key? key,
    this.items,
    this.decoration,
    this.onChanged,
    this.initialValue,
    this.hintText,
    this.fillColor,
    this.child,
    required this.controller,
    this.borderColor,
  }) : super(key: key);

  @override
  State<PrimaryDropDownFormField> createState() =>
      _PrimaryDropDownFormFieldState();
}

class _PrimaryDropDownFormFieldState extends State<PrimaryDropDownFormField> {
  BaseDropdownValue? value;

  @override
  void initState() {
    widget.items ??= [];
    value = widget.initialValue ?? widget.items?.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      value: value,
      items: widget.items!.map<DropdownMenuItem>((value) {
        return DropdownMenuItem(
          value: value,
          child: widget.child == null
              ? Row(
                  children: [
                    if (value.prefixImageUrl != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage(value.prefixImageUrl!),
                      ),
                    if (value.prefixImageUrl != null) const SizedBox(width: 8),
                    if (value.prefixWidget != null) value.prefixWidget!,
                    if (value.prefixWidget != null) const SizedBox(width: 8),
                    Text(value.valueStr ?? 'not_defined',
                        style: AppTextTheme.textPrimaryColor),
                  ],
                )
              : widget.child!.call(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          this.value = value as BaseDropdownValue?;
          widget.controller.text = value.toString();
        });
        widget.onChanged?.call(value);
      },
      isExpanded: true,
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: AppColor.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: widget.borderColor ?? AppColor.primaryColor, width: 2),
        ),
        offset: const Offset(-12, -12),
      ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 8, bottom: 12, right: 12, left: 12),
        hintText: widget.hintText,
        hintStyle: AppTextTheme.textLowPriority,
        labelStyle: AppTextTheme.textPrimaryBold,
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.gray04),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        filled: true,
        fillColor: widget.fillColor ?? AppColor.secondaryColor,
      ),
    );
  }
}
