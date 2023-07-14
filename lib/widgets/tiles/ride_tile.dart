import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:taxitaxi_admin/helpers/methods.dart';
import 'package:taxitaxi_admin/models/ride_model.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:taxitaxi_admin/services/ride_service.dart';
import 'package:taxitaxi_admin/widgets/cab_text.dart';
import 'package:taxitaxi_admin/widgets/tiles/ride_tile_data.dart';

import '../../helpers/style.dart';
import '../../models/ride_fare_model.dart';

class RideTile extends StatefulWidget {
  final RideModel ride;
  final List<RideFare> rideFares;
  const RideTile({Key? key, required this.ride, required this.rideFares})
      : super(key: key);

  @override
  State<RideTile> createState() => _RideTileState();
}

class _RideTileState extends State<RideTile>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  List sortItems = [
    "Accepted",
    "Rejected",
    "Cancelled",
    "Pending",
    "Expired",
    "Arrived",
    "Started",
    "Completed"
  ];
  String? selectedSortItem;

  @override
  void initState() {
    selectedSortItem = widget.ride.status.toString().capitalize();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RideTile oldWidget) {
    selectedSortItem = widget.ride.status.toString().capitalize();
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  Container dropwdownContainer() {
    return Container(
      height: 40,
      width: 200,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: selectedSortItem == "Rejected" ||
                  selectedSortItem == "Cancelled" ||
                  selectedSortItem == "Expired"
              ? Colors.red
              : selectedSortItem == "Completed"
                  ? Colors.green[700]
                  : selectedSortItem == "Created"
                      ? primary
                      : const Color(0xFF000000),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CabText("Status: ${selectedSortItem!}",
              size: 14, color: Colors.white),
          selectedSortItem == "Rejected" ||
                  selectedSortItem == "Cancelled" ||
                  selectedSortItem == "Expired" ||
                  selectedSortItem == "Completed"
              ? const SizedBox()
              : const Icon(CupertinoIcons.arrow_up_arrow_down,
                  color: Colors.white, size: 18)
        ],
      ),
    );
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
              padding: const EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: animationController!),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SizedBox(
                          width: 380,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 125,
                                      child: CabText(
                                        "Ride Date: ",
                                        color: Colors.grey[700],
                                        size: 16,
                                        weight: FontWeight.w100,
                                      )),
                                  CabText(
                                    DateFormat("MMM dd, y - hh:mm a")
                                        .format(widget.ride.createdAt),
                                    color: const Color(0xFF000000),
                                    size: 16,
                                    weight: FontWeight.w100,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 125,
                                    child: CabText(
                                      "Ride Id: ",
                                      color: Colors.grey[700],
                                      size: 16,
                                      weight: FontWeight.w100,
                                    ),
                                  ),
                                  CabText(
                                    widget.ride.id,
                                    color: primaryColor,
                                    size: 17,
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CabText(
                                  "Total: ",
                                  color: Colors.grey[700],
                                  size: 16,
                                  weight: FontWeight.w100,
                                ),
                                CabText(
                                  "₹ ${widget.ride.price.toStringAsFixed(1)}0",
                                  color: const Color(0xFF000000),
                                  size: 18,
                                  weight: FontWeight.w100,
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CabText(
                                  "Distance: ",
                                  color: Colors.grey[700],
                                  size: 16,
                                  weight: FontWeight.w100,
                                ),
                                CabText(
                                  widget.ride.distance.text,
                                  color: const Color(0xFF000000),
                                  size: 18,
                                  weight: FontWeight.w100,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  selectedSortItem == "Rejected" ||
                          selectedSortItem == "Cancelled" ||
                          selectedSortItem == "Expired" ||
                          selectedSortItem == "Completed"
                      ? dropwdownContainer()
                      : DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              customButton: dropwdownContainer(),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                              ),
                              value: selectedSortItem,
                              onChanged: (value) async {
                                await RideService().editBooingStatus(
                                    widget.ride.id,
                                    value.toString().toLowerCase(),
                                    context);
                                selectedSortItem = value as String;
                                setState(() {});
                              },
                              items: sortItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: CabText(
                                          item,
                                          size: 14,
                                        ),
                                      ))
                                  .toList()),
                        ),
                ],
              )),
          children: [
            RideTileData(
              ride: widget.ride,
              rideFares: widget.rideFares,
            )
          ],
        ),
      ),
    );
  }
}
