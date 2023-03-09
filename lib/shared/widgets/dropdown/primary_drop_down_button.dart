import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../something/bouncing.dart';
import 'menu_item.dart';

class PrimaryDropdownButton extends StatelessWidget {
  final List<MenuItem> items;
  final dynamic object;
  final IconData iconData;
  final Widget? child;

  const PrimaryDropdownButton(
      {Key? key,
      required this.items,
      this.object,
      required this.iconData,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Bouncing(
          child: child == null
              ? Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    // elevation: 5,
                    border: Border.all(color: AppColor.primaryColor),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    iconData,
                    color: AppColor.black,
                    size: 16,
                  ),
                )
              : child!,
        ),
        dropdownWidth: 220,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        dropdownElevation: 6,
        offset: const Offset(0, -4),
        items: [
          ...MenuItems(items: items).items.map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              )
        ],
        onChanged: (value) =>
            MenuItems.onChanged(context, value as MenuItem, object: object),
      ),
    );
  }
}
