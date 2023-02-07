import 'package:flutter/material.dart';

import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';

class PrimaryDropDownList extends StatefulWidget {
  final List<String> items;
  final Function(String?)? onChanged;
  final String? value;
  final BoxDecoration? decoration;
  const PrimaryDropDownList({
    Key? key,
    required this.items,
    this.decoration,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  State<PrimaryDropDownList> createState() => _PrimaryDropDownListState();
}

class _PrimaryDropDownListState extends State<PrimaryDropDownList> {
  String? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration ??
          BoxDecoration(
            border: Border.all(color: AppColor.divColor),
            borderRadius: BorderRadius.circular(5),
          ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          items: widget.items.map(dropdownMenuItem).toList(),
          onChanged: (value) {
            setState(() => this.value = value);
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          dropdownColor: AppColor.bgColor,
        ),
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
