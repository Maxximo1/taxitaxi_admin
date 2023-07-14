import 'package:flutter/material.dart';
import 'package:taxitaxi_admin/helpers/methods.dart';

import '../helpers/style.dart';
import '../widgets/cab_header.dart';
import '../widgets/cab_text.dart';
import '../widgets/tiles/address_tile.dart';

class UserAddressScreen extends StatelessWidget {
  static const routeName = "/usersAddress";
  final Map args;
  const UserAddressScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        //    drawer: HomeDrawer(),
        body: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CabHeader(title: "All Users"),
              Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: CabText(
                        "${args["name"].toString().capitalize()}'s Addresses",
                        size: 30)),
              ),
              args["address"].isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(children: const [
                        Icon(Icons.info_outline, size: 36, color: primaryColor),
                        SizedBox(height: 12),
                        Text("No Address found",
                            style:
                                TextStyle(fontSize: 25, color: primaryColor)),
                      ]),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 140, crossAxisCount: 2),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 20),
                      itemCount: args["address"].length,
                      itemBuilder: (ctx, i) {
                        return AddressTile(address: args["address"][i]);
                      },
                    ),
            ]));
  }
}
