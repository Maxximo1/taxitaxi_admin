import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_network/image_network.dart';
import 'package:taxitaxi_admin/models/driver_model.dart';
import 'package:taxitaxi_admin/services/driver_service.dart';
import 'package:taxitaxi_admin/widgets/utils/heading_item.dart';

import '../../helpers/style.dart';
import '../../models/ride_fare_model.dart';
import '../cab_text.dart';

class DriverTileData extends StatefulWidget {
  final Driver driver;
  final List<RideFare> rideFares;
  const DriverTileData(
      {Key? key, required this.driver, required this.rideFares})
      : super(key: key);

  @override
  State<DriverTileData> createState() => _DriverTileDataState();
}

class _DriverTileDataState extends State<DriverTileData> {
  bool isActive = true;
  @override
  void initState() {
    isActive = widget.driver.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 14),
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(CupertinoIcons.doc_checkmark, size: 24),
                      ),
                      CabText(
                        "Vehicle Summary",
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(CupertinoIcons.location, size: 24),
                    ),
                    CabText(
                      "Last Location",
                      size: 18,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 14),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(CupertinoIcons.profile_circled,
                                  size: 24),
                            ),
                            const SizedBox(
                              width: 80,
                              child: CabText("Active: ",
                                  size: 17,
                                  weight: FontWeight.w600,
                                  color: active),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 2),
                              child: CupertinoSwitch(
                                // This bool value toggles the switch.
                                value: isActive,
                                thumbColor: isActive
                                    ? CupertinoColors.systemGreen
                                    : CupertinoColors.systemRed,
                                trackColor:
                                    CupertinoColors.systemRed.withOpacity(0.34),
                                activeColor: CupertinoColors.systemGreen
                                    .withOpacity(0.34),
                                onChanged: (bool? value) async {
                                  setState(() {
                                    isActive = value!;
                                  });
                                  await DriverService().editDriverStatus(
                                    driverId: widget.driver.id,
                                    isActive: isActive,
                                    context: context,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(CupertinoIcons.info, size: 24),
                            ),
                            const SizedBox(
                              width: 80,
                              child: CabText(
                                "Type: ",
                                size: 17,
                                weight: FontWeight.w600,
                                color: active,
                              ),
                            ),
                            ImageNetwork(
                              image: widget
                                  .rideFares[widget.rideFares.indexWhere(
                                      (element) =>
                                          element.name
                                              .trim()
                                              .toLowerCase()
                                              .replaceAll(" ", "-") ==
                                          widget.driver.type)]
                                  .image,
                              height: 36,
                              width: 60,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 16),
                        child: HeadingItem(
                            icon: CupertinoIcons.settings,
                            title: "Name: ",
                            value: widget.driver.car),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: HeadingItem(
                          icon: CupertinoIcons.square_grid_2x2,
                          title: "Plate: ",
                          value: widget.driver.plate,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width / 2.8,
                  child: GoogleMap(
                      markers: {
                        Marker(
                            markerId: MarkerId(widget.driver.id),
                            position: LatLng(widget.driver.position.lat,
                                widget.driver.position.lng))
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(widget.driver.position.lat,
                              widget.driver.position.lng),
                          zoom: 16)),
                )
              ],
            ),
          ),
          widget.driver.vehicleIdProof == null || widget.driver.idProof == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 14),
                  child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(CupertinoIcons.doc_append, size: 24),
                            ),
                            CabText(
                              "Vehicle Registration Document",
                              size: 18,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(CupertinoIcons.doc_append, size: 24),
                          ),
                          CabText(
                            "Driver Identity Proof",
                            size: 18,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          widget.driver.vehicleIdProof == null || widget.driver.idProof == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageNetwork(
                          height: 180,
                          width: MediaQuery.of(context).size.width / 2.8,
                          image: widget.driver.vehicleIdProof!),
                      ImageNetwork(
                          height: 180,
                          width: MediaQuery.of(context).size.width / 2.8,
                          image: widget.driver.idProof!)
                    ],
                  )),
        ],
      ),
    );
  }
}
