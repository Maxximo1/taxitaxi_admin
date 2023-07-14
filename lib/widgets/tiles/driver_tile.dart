import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:taxitaxi_admin/helpers/methods.dart';
import 'package:taxitaxi_admin/models/ride_fare_model.dart';

import '../../helpers/style.dart';
import '../../models/driver_model.dart';

import '../../screens/rides.dart';
import '../../services/history_service.dart';
import '../cab_text.dart';
import 'driver_tile_data.dart';

class DriverTile extends StatefulWidget {
  final Driver driver;
  final List<RideFare> rideFares;
  const DriverTile({Key? key, required this.driver, required this.rideFares})
      : super(key: key);

  @override
  State<DriverTile> createState() => _DriverTileState();
}

class _DriverTileState extends State<DriverTile>
    with SingleTickerProviderStateMixin {
  double scale = 0;
  AnimationController? animationController;
  double walletTotal = 0;
  double avgRating = 0;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    HistoryService.fetchDriverHistory(widget.driver.id)
        .then((value) => setState(() {
              walletTotal =
                  value.map((m) => m['amount']).reduce((a, b) => a + b);
              List dummy =
                  value.where((element) => element['rating'] != null).toList();
              avgRating =
                  dummy.map((m) => m['rating']).reduce((a, b) => (a + b)) /
                      dummy.length;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 4,
        child: ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 26),
          onExpansionChanged: (val) {
            if (val == true) {
              animationController!.forward();
            } else {
              animationController!.reverse();
            }
          },
          trailing: const SizedBox(),
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
                      AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: animationController!),
                      const SizedBox(width: 30),
                      Container(
                          height: 80,
                          width: 80,
                          margin: const EdgeInsets.only(bottom: 6, top: 6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CabText(
                              widget.driver.name.substring(0, 2).toUpperCase(),
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
                          width: 340,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CabText(
                                "${widget.driver.name.capitalize()} ",
                                color: Colors.black,
                                size: 22,
                                weight: FontWeight.w100,
                              ),
                              const SizedBox(height: 2),
                              CabText(
                                "ID: ${widget.driver.id}",
                                color: Colors.black87,
                                size: 15,
                                weight: FontWeight.w100,
                              ),
                              const SizedBox(height: 2),
                              CabText(
                                widget.driver.email,
                                color: Colors.black87,
                                size: 16,
                                weight: FontWeight.w100,
                              ),
                              const SizedBox(height: 2),
                              CabText(
                                "Phone: ${widget.driver.phone}",
                                color: Colors.black87,
                                size: 16,
                                weight: FontWeight.w100,
                              ),
                              const SizedBox(height: 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Container(width: 1, height: 60, color: Colors.grey),
                  Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      width: 1,
                      height: 60,
                      color: Colors.grey),
                  SizedBox(
                    width: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     CabText(
                        //       "Type: ",
                        //       color: Colors.grey[700],
                        //       size: 16,
                        //       weight: FontWeight.w100,
                        //     ),
                        //     Image.asset("assets/${widget.driver.type}.png",
                        //         height: 36)
                        //   ],
                        // ),
                        RatingBar(
                          initialRating: avgRating,
                          minRating: 0,
                          glow: false,
                          ignoreGestures: true,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemSize: 24,
                          unratedColor: const Color(0xFF9FA8B0),
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                              empty: const Icon(
                                Icons.star_border_outlined,
                                color: Colors.amber,
                              ),
                              half: const Icon(
                                Icons.star_half_outlined,
                                color: Colors.amber,
                              ),
                              full: const Icon(
                                Icons.star,
                                color: Colors.amber,
                              )),
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: .0),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CabText(
                              "Wallet: ",
                              color: Colors.grey[700],
                              size: 16,
                              weight: FontWeight.w100,
                            ),
                            CabText(
                              "₹ ${walletTotal.toStringAsFixed(1)}0",
                              color: const Color(0xFF000000),
                              size: 18,
                              weight: FontWeight.w100,
                            ),
                          ],
                        ),
                      ],
                    ),
                    //   ),
                    // ],
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(RidesScreen.routeName,
                          arguments: {
                            "role": "driver",
                            "name": widget.driver.name,
                            "id": widget.driver.id
                          });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: CabText(
                        "View Bookings",
                        color: Colors.black,
                        size: 17,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Container(
                  //   padding: const EdgeInsets.only(left: 20),
                  //   height: 60,
                  //   width: 240,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       const CabText(
                  //         "Inactive",
                  //         color: Colors.black87,
                  //         size: 17,
                  //         weight: FontWeight.w100,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: CupertinoSwitch(
                  //           // This bool value toggles the switch.
                  //           value: isActive,
                  //           thumbColor: isActive
                  //               ? CupertinoColors.systemGreen
                  //               : CupertinoColors.systemRed,
                  //           trackColor:
                  //               CupertinoColors.systemRed.withOpacity(0.34),
                  //           activeColor: CupertinoColors.systemGreen
                  //               .withOpacity(0.34),
                  //           onChanged: (bool? value) async {
                  //             // await UserModel\Service().alterUserStatus(
                  //             //     userId: widget.userModel.uid,
                  //             //     isActive: value!,
                  //             //     context: context);
                  //             // setState(() {
                  //             //   isActive = value;
                  //             // });
                  //           },
                  //         ),
                  //       ),
                  //       const CabText(
                  //         "Active",
                  //         color: Colors.black87,
                  //         size: 17,
                  //         weight: FontWeight.w100,
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              )),
          children: [
            DriverTileData(driver: widget.driver, rideFares: widget.rideFares)
          ],
        ),
      ),
    );
  }
}
