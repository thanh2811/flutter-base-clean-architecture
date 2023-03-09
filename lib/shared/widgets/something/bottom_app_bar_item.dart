// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';

class BottomAppBarItem extends StatelessWidget {
  bool? isDisable;
  IconData icon;
  String label;
  Function onPress;

  BottomAppBarItem(
      {Key? key,
      this.isDisable,
      required this.icon,
      required this.label,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDisable == true ? AppColor.gray : AppColor.black,
              size: 24,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isDisable == true ? AppColor.gray : AppColor.black,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
