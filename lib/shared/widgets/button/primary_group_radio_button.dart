import 'package:flutter/material.dart';

import '../../../data/resources/resources.dart';

class PrimaryGroupRadioButton extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final Function(String) onChanged;

  const PrimaryGroupRadioButton(
      {Key? key,
      required this.items,
      this.initialValue,
      required this.onChanged})
      : super(key: key);

  @override
  State<PrimaryGroupRadioButton> createState() =>
      _PrimaryGroupRadioButtonState();
}

class _PrimaryGroupRadioButtonState extends State<PrimaryGroupRadioButton> {
  String? groupValue;

  @override
  void initState() {
    groupValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.items
          .asMap()
          .entries
          .map(
            (e) => Expanded(
              child: RadioListTile(
                dense: true,
                contentPadding: const EdgeInsets.all(0),
                value: widget.items[e.key],
                groupValue: groupValue,
                title: Text(
                  widget.items[e.key],
                  style: AppTextTheme.textPrimary,
                ),
                activeColor: AppColor.primaryColor,
                onChanged: (value) {
                  setState(() {
                    groupValue = value;
                    widget.onChanged.call(value!);
                  });
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
