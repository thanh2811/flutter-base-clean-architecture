
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/constants.dart';
import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';
import '../../services/utils.dart';

class SecondaryTextField extends StatefulWidget {
  const SecondaryTextField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.hintText,
    this.validator,
    this.formKey,
    this.readOnly = false,
    this.keyboardType,
    this.inputType,
    this.data,
    this.context,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.search,
    this.onTap,
    this.isDense = false,
  }) : super(key: key);

  // final String? label;
  final String? hintText;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextInputType? keyboardType;
  final AppInputType? inputType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final List<String>? data;
  final BuildContext? context;
  final Function()? onTap;
  final bool isDense;

  final GlobalKey<FormState>? formKey;

  @override
  State<SecondaryTextField> createState() => _SecondaryTextFieldState();
}

class _SecondaryTextFieldState extends State<SecondaryTextField> {
  final GlobalKey<FormState>? formKey2 = GlobalKey();
  String dropDownText = "";

  @override
  void initState() {
    if (widget.inputType == AppInputType.dropDown) {
      dropDownText = widget.data?[0].toString() ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.inputType == null)
        ? Form(
            key: widget.formKey,
            child: TextFormField(
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              style: AppTextTheme.textPrimary,
              controller: widget.controller,
              minLines: 1,
              maxLines: 100,
              validator: widget.validator,
              onChanged: (value) {
                widget.formKey?.currentState!.validate();
              },
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                isDense: widget.isDense,
                contentPadding: EdgeInsets.zero,
                hintText: widget.hintText,
                hintStyle: AppTextTheme.textLowPriority,
                labelStyle: AppTextTheme.textPrimary,
                errorMaxLines: 2,
                filled: true,
                fillColor: AppColor.white,
                prefixIcon: widget.prefixIcon == null
                    ? null
                    : (widget.prefixIcon is String)
                        ? SvgPicture.asset(
                            widget.prefixIcon ?? '',
                            height: 20,
                            width: 16,
                            fit: BoxFit.scaleDown,
                          )
                        : widget.prefixIcon,
                suffixIcon: widget.suffixIcon == null
                    ? null
                    : (widget.suffixIcon is String)
                        ? SvgPicture.asset(
                            widget.suffixIcon ?? '',
                            height: 20,
                            width: 16,
                            fit: BoxFit.scaleDown,
                          )
                        : widget.suffixIcon,
              ),
            ),
          )
        : (widget.inputType == AppInputType.dropDown)
            ? DropdownButton<String>(
                items:
                    widget.data?.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  dropDownText = value.toString();
                  widget.controller.text = value.toString();
                }),
                dropdownColor: AppColor.white,
                value: dropDownText,
              )

            // type date picker
            : (widget.inputType == AppInputType.datePicker)
                ? Form(
                    key: widget.formKey,
                    child: TextFormField(
                      onTap: () async {
                        // final selectedDate =
                        //     await Utils.getDatePicker(widget.context!);
                        final DateTime? selectedDate = await showDatePicker(
                            context: widget.context!,
                            locale: const Locale("vi"),
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        if (selectedDate != null) {
                          setState(() {
                            widget.controller.text =
                                Utils.formatDate(selectedDate.toString());
                          });
                        }
                      },
                      validator: widget.validator,
                      readOnly: widget.readOnly,
                      style: AppTextTheme.textPrimary,
                      controller: widget.controller,
                      keyboardType: widget.keyboardType,
                      decoration: InputDecoration(
                        isDense: widget.isDense,
                        contentPadding: EdgeInsets.zero,
                        hintText: widget.hintText,
                        labelStyle: AppTextTheme.textPrimary,
                        filled: true,
                        fillColor: AppColor.white,
                        errorMaxLines: 2,
                        prefixIcon: widget.prefixIcon == null
                            ? null
                            : (widget.prefixIcon is String)
                                ? SvgPicture.asset(
                                    widget.prefixIcon ?? '',
                                    height: 20,
                                    width: 16,
                                    fit: BoxFit.scaleDown,
                                  )
                                : widget.prefixIcon,
                        suffixIcon: widget.suffixIcon != null
                            ? SvgPicture.asset(widget.suffixIcon!)
                            : null,
                      ),
                    ),
                  )
                :
                // (inputType == AppInputType.popUpShow) ? :
                Container();
  }
}
