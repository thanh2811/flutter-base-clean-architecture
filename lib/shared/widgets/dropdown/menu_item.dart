import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  final List<MenuItem> items;

  const MenuItems({required this.items});

  static const qrcode = MenuItem(text: 'Mã QR', icon: Icons.qr_code_2_outlined);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: AppColor.primaryColor, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: AppTextTheme.textPrimary,
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item,
      {dynamic object}) async {
    switch (item) {

    }
  }
}
