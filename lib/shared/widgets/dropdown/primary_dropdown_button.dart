import '../../../config/config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../shared/etx/app_ext.dart';
import '../../../data/resources/resources.dart';
import 'base_dropdown_value.dart';

class PrimaryDropdownButton extends StatefulWidget {
  final List<BaseDropdownValue>? items;
  final String? label;
  final BoxDecoration? decorationButton;
  final Function(BaseDropdownValue value, int index)? onChanged;
  final BaseDropdownValue? initialValue;
  final BoxDecoration? decoration;
  final String? hintText;
  final Color? fillColor;
  final Color? borderColor;

  const PrimaryDropdownButton(
      {Key? key,
      this.items = const [],
      this.label,
      this.decorationButton,
      this.onChanged,
      this.initialValue,
      this.decoration,
      this.hintText,
      this.fillColor,
      this.borderColor})
      : super(key: key);

  @override
  State<PrimaryDropdownButton> createState() => _PrimaryDropdownButtonState();
}

class _PrimaryDropdownButtonState extends State<PrimaryDropdownButton> {
  BaseDropdownValue? value;

  @override
  void initState() {
    value = widget.initialValue ?? widget.items?.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        isDense: true,
        customButton: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          width: double.infinity,
          decoration: widget.decorationButton,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (value?.prefixImageUrl != null)
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(value?.prefixImageUrl ?? ''),
                      ),
                    if (value?.prefixImageUrl != null) const SizedBox(width: 8),
                    if (value?.prefixWidget != null) value!.prefixWidget!,
                    if (value?.prefixWidget != null) const SizedBox(width: 8),
                    Text(value?.valueStr ?? widget.hintText ?? '',
                        style: widget.items!.indexOf(value!) > 0
                            ? AppTextTheme.textPrimaryBoldMedium
                            : AppTextTheme.textPrimaryMedium),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: AppColor.primaryColor,
              )
            ],
          ),
        ),
        hint: Text(
          widget.hintText ?? '',
          style: AppTextTheme.textPrimary,
        ),
        items: widget.items!.map<DropdownMenuItem>(
          (value) {
            return DropdownMenuItem(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      if (value.prefixImageUrl != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(value.prefixImageUrl!),
                        ),
                      if (value.prefixImageUrl != null)
                        const SizedBox(width: 8),
                      if (value.prefixWidget != null) value.prefixWidget!,
                      if (value.prefixWidget != null) const SizedBox(width: 8),
                      Text(value.valueStr ?? 'not_defined',
                          style: AppTextTheme.textPrimaryMedium),
                    ],
                  ),
                ));
          },
        ).toList(),
        value: value,
        onChanged: (value) {
          setState(() {
            this.value = value as BaseDropdownValue?;
            // widget.controller.text = value.toString();
          });
          widget.onChanged?.call(value, widget.items?.indexOf(value) ?? -1);
        },
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppConfig.defaultRadius),
          ),
          maxHeight: context.screenHeight * 2 / 3,
        ),
      ),
    );
  }
}
