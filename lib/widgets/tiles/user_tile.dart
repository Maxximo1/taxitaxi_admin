import 'package:flutter/material.dart';
import 'package:taxitaxi_admin/helpers/methods.dart';
import 'package:taxitaxi_admin/screens/rides.dart';
import '../../helpers/style.dart';
import '../../models/user_model.dart';
import '../../screens/user_address.dart';
import '../cab_text.dart';

class UserTile extends StatefulWidget {
  final UserModel userModel;
  const UserTile({Key? key, required this.userModel}) : super(key: key);

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 4,
        child: ListTile(
          onTap: () {},
          mouseCursor: SystemMouseCursors.click,
          minVerticalPadding: 0,
          tileColor: Colors.white,
          title: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 80,
                          width: 80,
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CabText(
                              widget.userModel.name
                                  .substring(0, 2)
                                  .toUpperCase(),
                              color: Colors.white,
                              size: 26)
                          // : ImageNetwork(
                          //     image: widget.userModel.image,
                          //     height: 120,
                          //     width: 120,
                          //   ),
                          ),
                      const SizedBox(width: 30),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: SizedBox(
                          width: 360,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CabText(
                                widget.userModel.name.capitalize(),
                                color: Colors.black,
                                size: 22,
                                weight: FontWeight.w100,
                              ),
                              const SizedBox(height: 4),
                              CabText(
                                "ID: ${widget.userModel.id}",
                                color: Colors.black87,
                                size: 15,
                                weight: FontWeight.w100,
                              ),
                              const SizedBox(height: 2),
                              CabText(
                                widget.userModel.email,
                                color: Colors.black87,
                                size: 17,
                                weight: FontWeight.w100,
                              ),
                              const SizedBox(height: 2),
                              CabText(
                                "Phone: ${widget.userModel.phone}",
                                color: Colors.black87,
                                size: 17,
                                weight: FontWeight.w100,
                              ),
                              const SizedBox(height: 3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              UserAddressScreen.routeName,
                              arguments: {
                                "name": widget.userModel.name,
                                "address": widget.userModel.addressList
                              });
                        },
                        style: const ButtonStyle(
                          side: MaterialStatePropertyAll(
                              BorderSide(color: primaryColor)),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: CabText(
                            "View Address",
                            color: Colors.black,
                            size: 17,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(primaryColor)),
                        onPressed: () {
                          Navigator.of(context).pushNamed(RidesScreen.routeName,
                              arguments: {
                                "role": "user",
                                "name": widget.userModel.name,
                                "id": widget.userModel.id
                              });
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: CabText(
                            "View Bookings",
                            color: Colors.black,
                            size: 17,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
