import 'package:flutter/material.dart';
import 'package:taxitaxi_admin/helpers/style.dart';

import 'cab_text.dart';

class CabHeader extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const CabHeader({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      // padding: const EdgeInsets.only(bottom: 20, top: 30),
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  //  width: 250,
                  child: InkWell(
                onTap: onTap ?? () => Navigator.of(context).pop(),
                child: Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(right: 14),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.black)),
                    CabText("Back to $title", color: Colors.black),
                  ],
                ),
              )),
              Hero(
                  tag: "logo-shift",
                  child: Image.asset(
                    "assets/logo-tb.png",
                    height: 120,
                    width: 160,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(width: 220),
            ],
          )),
    );
  }
}
