import 'package:flutter/material.dart';

import '../../data/resources/themes.dart';

class TextInfo extends StatelessWidget {
  const TextInfo({super.key, required this.text, required this.icon});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: SelectableText(text, style: AppTextTheme.textPrimarySmall),
        ),
      ],
    );
  }
}
