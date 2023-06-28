import '../../../config/config.dart';
import '../../utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/constant/enum.dart';
import '../../../data/resources/resources.dart';
import '../dropdown/base_dropdown_value.dart';
import '../dropdown/primary_drop_down_form_field.dart';
import '../switch/primary_switch.dart';

class PrimaryTextField extends StatefulWidget {
  const PrimaryTextField({
    Key? key,
    this.prefixIcon,
    this.labelIcon,
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
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputAction = TextInputAction.next,
    this.onTap,
    this.onSubmitted,
    this.isDense = false,
    this.fillColor,
    this.borderColor = AppColor.transparent,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 20,
    this.counterText = '',
    this.obscureText = false,
    this.label,
    this.isRequired = false,
    this.isShowSwitch = false,
    this.isSwitchChecked = true,
    this.onSwitchChanged,
    this.labelStyle,
    this.onChanged,
    this.onDropdownValueChanged,
    this.initialValue,
    this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.focusNode,
  }) : super(key: key);

  // final String? label;
  final String? hintText;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final dynamic labelIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextInputType? keyboardType;
  final AppInputType? inputType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final List<BaseDropdownValue>? data;
  final BaseDropdownValue? initialValue;

  /// context must be provided if used to show dialog
  final BuildContext? context;
  final Function()? onTap;
  final Function(String value)? onSubmitted;
  final bool isDense;
  final bool obscureText;
  final Color? fillColor;
  final Color borderColor;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? counterText;
  final String? label;
  final TextStyle? labelStyle;
  final bool isRequired;
  final Function(String? value)? onChanged;
  final Function(DateTime value)? onDateSelected;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final FocusNode? focusNode;
  final Function(BaseDropdownValue? value)? onDropdownValueChanged;

  ///  define switch should be shown or not
  final bool isShowSwitch;

  ///  initializes the switch state. This required [isShowSwitch] = true
  final bool isSwitchChecked;

  ///  callback the value of switch changes. This required [isShowSwitch] = true
  final Function(bool value)? onSwitchChanged;
  final GlobalKey<FormState>? formKey;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  // final GlobalKey<FormState>? formKey2 = GlobalKey();
  String dropDownText = "";
  late bool isSwitchChecked;

  @override
  void initState() {
    if (widget.inputType == AppInputType.dropDown) {
      dropDownText = widget.data?[0].toString() ?? '';
    }
    if (widget.isShowSwitch) isSwitchChecked = widget.isSwitchChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.label != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.labelIcon != null
                          ? widget.labelIcon is String
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: SvgPicture.asset(
                                    widget.labelIcon,
                                    height: 20,
                                    width: 20,
                                  ),
                                )
                              : widget.labelIcon
                          : const SizedBox(),
                      Text(widget.label!, style: widget.labelStyle),
                      widget.isRequired
                          ? Text(
                              ' *',
                              style: AppTextTheme.textPrimary
                                  .copyWith(color: AppColor.errorColor),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  widget.isShowSwitch
                      ? PrimarySwitch(
                          initialValue: isSwitchChecked,
                          onToggle: (value) =>
                              widget.onSwitchChanged?.call(value),
                        )
                      : const SizedBox(),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 8),
        (widget.inputType == null)
            ? Form(
                key: widget.formKey,
                child: TextFormField(
                  focusNode: widget.focusNode,
                  onTap: widget.onTap,
                  readOnly: widget.readOnly,
                  style: AppTextTheme.textPrimary,
                  controller: widget.controller,
                  validator: widget.validator,
                  obscureText: widget.obscureText,
                  onChanged: (value) {
                    widget.formKey?.currentState!.validate();
                    widget.onChanged?.call(value);
                  },
                  onFieldSubmitted: widget.onSubmitted,
                  maxLength: widget.maxLength,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  textCapitalization: widget.textCapitalization,
                  textInputAction: widget.textInputAction,
                  keyboardType: widget.keyboardType,
                  textAlignVertical:
                      (widget.suffixIcon == null && widget.prefixIcon == null)
                          ? null
                          : TextAlignVertical.center,
                  decoration: InputDecoration(
                    counterText: widget.counterText,
                    isDense: widget.isDense,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    hintText: widget.hintText,
                    hintStyle: AppTextTheme.textHintPrimary,
                    labelStyle: AppTextTheme.textPrimary,
                    errorMaxLines: 2,
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.transparent, width: 0),
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppConfig.defaultRadius))),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: widget.borderColor, width: 0),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppConfig.defaultRadius))),
                    filled: true,
                    fillColor: widget.fillColor ?? AppColor.third11Color,
                    alignLabelWithHint: true,
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
                ? PrimaryDropDownFormField(
                    items: widget.data,
                    controller: widget.controller,
                    fillColor: widget.fillColor,
                    onChanged: (value) {
                      widget.onDropdownValueChanged?.call(value);
                    },
                    initialValue: widget.initialValue,
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
                                initialDate:
                                    widget.initialDate ?? DateTime.now(),
                                firstDate: widget.firstDate ?? DateTime(1900),
                                lastDate: widget.lastDate ?? DateTime(3000));
                            if (selectedDate != null) {
                              setState(() {
                                widget.controller.text =
                                    DateTimeUtils.formatDate(
                                        selectedDate.toString());
                              });
                              widget.onDateSelected?.call(selectedDate);
                            }
                          },
                          validator: widget.validator,
                          readOnly: true,
                          style: AppTextTheme.textPrimary,
                          controller: widget.controller,
                          keyboardType: widget.keyboardType,
                          decoration: InputDecoration(
                            isDense: widget.isDense,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            hintText: widget.hintText,
                            labelStyle: AppTextTheme.textPrimary,
                            filled: true,
                            fillColor: widget.fillColor,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.transparent, width: 0),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppConfig.defaultRadius))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: widget.borderColor, width: 0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(AppConfig.defaultRadius))),
                            errorMaxLines: 2,
                            prefixIcon: widget.prefixIcon == null
                                ? null
                                : (widget.prefixIcon is String)
                                    ? SvgPicture.asset(
                                        widget.prefixIcon!,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : widget.prefixIcon,
                            suffixIcon: widget.suffixIcon != null
                                ? widget.suffixIcon is String
                                    ? SvgPicture.asset(
                                        widget.suffixIcon!,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : Icon(
                                        widget.suffixIcon,
                                        color: AppColor.black.withOpacity(0.25),
                                      )
                                : null,
                          ),
                        ),
                      )
                    : (widget.inputType == AppInputType.timePicker)
                        ? Form(
                            key: widget.formKey,
                            child: TextFormField(
                              onTap: () async {
                                // final selectedDate =
                                //     await Utils.getDatePicker(widget.context!);
                                final TimeOfDay? selectedTime =
                                    await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: widget.context!,
                                );
                                if (selectedTime != null) {
                                  setState(() {
                                    widget.controller.text =
                                        DateTimeUtils.formatTime(selectedTime);
                                  });
                                }
                              },
                              validator: widget.validator,
                              readOnly: true,
                              style: AppTextTheme.textPrimary,
                              controller: widget.controller,
                              keyboardType: widget.keyboardType,
                              decoration: InputDecoration(
                                isDense: widget.isDense,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                                hintText: widget.hintText,
                                labelStyle: AppTextTheme.textPrimary,
                                filled: true,
                                fillColor: widget.fillColor,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.transparent, width: 0),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            AppConfig.defaultRadius))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: widget.borderColor, width: 0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            AppConfig.defaultRadius))),
                                errorMaxLines: 2,
                                prefixIcon: widget.prefixIcon == null
                                    ? null
                                    : (widget.prefixIcon is String)
                                        ? SvgPicture.asset(
                                            widget.prefixIcon!,
                                            height: 20,
                                            width: 16,
                                            fit: BoxFit.scaleDown,
                                          )
                                        : widget.prefixIcon,
                                suffixIcon: widget.suffixIcon != null
                                    ? widget.suffixIcon is String
                                        ? SvgPicture.asset(
                                            widget.suffixIcon!,
                                            height: 20,
                                            width: 16,
                                            fit: BoxFit.scaleDown,
                                          )
                                        : Icon(
                                            widget.suffixIcon,
                                            color: AppColor.black
                                                .withOpacity(0.25),
                                          )
                                    : null,
                              ),
                            ),
                          )
                        : Container(),
      ],
    );
  }
}
