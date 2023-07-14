import 'package:flutter/material.dart';

import '../helpers/style.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const SearchField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: const Color(0xFF000000),
      cursorWidth: 1.5,
      cursorHeight: 16,
      style: const TextStyle(
          fontSize: 14,
          height: 1,
          letterSpacing: 1.5,
          color: Color(0xFF000000)),
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.hintText,
          labelStyle: const TextStyle(
              fontSize: 14, height: 1, color: Color(0xFF000000)),
          errorBorder: errorBorder,
          focusedBorder: border,
          enabledBorder: border,
          focusedErrorBorder: errorBorder,
          border: border),
    );
  }
}
