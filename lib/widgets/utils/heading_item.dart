import 'package:flutter/material.dart';

import '../../helpers/style.dart';
import '../cab_text.dart';

class HeadingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const HeadingItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(icon, size: 24),
          ),
          SizedBox(
            width: 80,
            child: CabText(
              title,
              size: 17,
              weight: FontWeight.w600,
              color: active,
            ),
          ),
          Flexible(
            child: CabText(
              value,
              size: 17,
              weight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
