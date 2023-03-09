import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';

class PrimaryTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<Widget> children;

  const PrimaryTabBar({super.key, required this.tabs, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              backgroundColor: AppColor.white,
              appBar: TabBar(
                isScrollable: true,
                unselectedLabelColor: AppColor.black,
                labelPadding: const EdgeInsets.all(3),
                labelColor: AppColor.primaryColor,
                labelStyle: AppTextTheme.textPrimaryBold,
                indicatorColor: AppColor.orange,
                tabs: tabs
                    .map((tabTitle) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(tabTitle)))
                    .toList(),
              ),
              body: TabBarView(children: children),
            )));
  }
}
