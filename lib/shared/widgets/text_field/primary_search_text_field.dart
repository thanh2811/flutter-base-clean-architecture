import 'dart:async';

import 'package:flutter/material.dart';

class PrimarySearchTextField extends StatefulWidget {
  const PrimarySearchTextField({
    Key? key,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.debounce = 1000,
    required this.controller,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final dynamic prefixIcon;
  final String? suffixIcon;
  final TextEditingController controller;
  final Function(String?) onChanged;
  final int debounce;

  @override
  State<PrimarySearchTextField> createState() => _PrimarySearchTextFieldState();
}

class _PrimarySearchTextFieldState extends State<PrimarySearchTextField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )),
    );
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
        Duration(milliseconds: widget.debounce), () => widget.onChanged(value));
  }
}
