import 'package:flutter/material.dart';

import '../cab_text.dart';

class SubHeadingItem extends StatelessWidget {
  final String title;
  final String value;
  const SubHeadingItem({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CabText(title, size: 15, spacing: 1.3),
          CabText(value, size: 15)
        ],
      ),
    );
  }
}
