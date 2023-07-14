import 'package:flutter/material.dart';
import 'package:taxitaxi_admin/helpers/methods.dart';

import '../../models/address_model.dart';

import '../cab_text.dart';

class AddressTile extends StatelessWidget {
  final Address address;
  final double? leftMargin;
  const AddressTile({Key? key, required this.address, this.leftMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin: EdgeInsets.only(bottom: 20, left: leftMargin ?? 10, right: 10),
        child: Padding(
          padding: EdgeInsets.all(leftMargin == 0 ? 10 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    if (address.id != null &&
                        (address.id == "billing" || address.id == "delivery"))
                      CabText(
                        "${address.id.toString().capitalize()} - ",
                        weight: FontWeight.w600,
                      ),
                    CabText(address.name),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  child: CabText(
                      '${address.line1}, ${address.line2}, ${address.area}',
                      size: 15)),
            ],
          ),
        ));
  }
}
