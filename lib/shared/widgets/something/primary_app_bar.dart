import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../button/back_button.dart';

// ignore: must_be_immutable
class PrimaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool canPop;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final double? elevation;
  final Function(String)? onChangeText;
  _PrimaryAppBarState? _primaryAppBarState;

  PrimaryAppBar(
      {super.key,
      this.title,
      this.actions,
      this.leading,
      this.canPop = false,
      this.onBackPressed,
      this.onChangeText,
      this.centerTitle = false,
      this.backgroundColor,
      this.elevation}) {
    _primaryAppBarState = _PrimaryAppBarState(title: title);
  }

  @override
  // ignore: no_logic_in_create_state
  State<PrimaryAppBar> createState() => _primaryAppBarState!;

  void changeText(String text) {
    _primaryAppBarState?.onChangeText(text);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PrimaryAppBarState extends State<PrimaryAppBar> {
  String? title;

  _PrimaryAppBarState({this.title});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor ?? AppColor.primaryColor,
      title: Text(title ?? '', style: AppTextTheme.textAppBarPrimary),
      elevation: widget.elevation ?? 2,
      leading: widget.leading ??
          (widget.canPop
              ? BackButtonCustom(
                  onPressed: widget.onBackPressed,
                )
              : null),
      actions: widget.actions,
      centerTitle: widget.centerTitle,
    );
  }

  void onChangeText(String text) {
    if (mounted) {
      setState(() {
        title = text;
      });
    }
  }
}
