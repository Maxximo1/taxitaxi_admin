import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_network/image_network.dart';
import 'package:taxitaxi_admin/models/ride_model.dart';
import 'package:taxitaxi_admin/widgets/utils/subheading_item.dart';

import '../../helpers/methods.dart';

import '../../models/ride_fare_model.dart';
import '../cab_text.dart';

class RideTileData extends StatefulWidget {
  final RideModel ride;
  final List<RideFare> rideFares;
  const RideTileData({Key? key, required this.ride, required this.rideFares})
      : super(key: key);

  @override
  State<RideTileData> createState() => _RideTileDataState();
}

class _RideTileDataState extends State<RideTileData> {
  int rating = 0;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("history")
        .where("rideId", isEqualTo: widget.ride.id)
        .get()
        .then((value) => setState(() {
              rating =
                  value.size == 0 ? 0 : value.docs[0].data()["rating"] ?? 0;
            }));
    // ProductService().fetchProductsFromId(ids).then((value) {
    //   products = value;
    //   setState(() {;
    // });

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
                        child: Icon(CupertinoIcons.doc_plaintext, size: 24),
                      ),
                      CabText(
                        "Payment Details",
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
                      child: Icon(CupertinoIcons.person, size: 24),
                    ),
                    CabText(
                      "Ride Summary",
                      size: 18,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubHeadingItem(
                              title: "Driver's Cut",
                              value:
                                  " ₹${(widget.ride.price * .8).toStringAsFixed(2)}"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: SubHeadingItem(
                                title: "App's Commission",
                                value:
                                    " + ₹${(widget.ride.price * .2).toStringAsFixed(2)}"),
                          ),
                          SubHeadingItem(
                              title: "Ride Total",
                              value:
                                  " ₹${(widget.ride.price).toStringAsFixed(2)}"),
                        ]),
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 4, right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CabText("Type", size: 15, spacing: 1.3),
                              ImageNetwork(
                                image: widget
                                    .rideFares[widget.rideFares.indexWhere(
                                        (element) =>
                                            element.name
                                                .trim()
                                                .toLowerCase()
                                                .replaceAll(" ", "-") ==
                                            widget.ride.type)]
                                    .image,
                                height: 36,
                                width: 60,
                              )
                            ],
                          ),
                        ),
                        SubHeadingItem(
                            title: "User's Name",
                            value: "${widget.ride.username} ".capitalize()),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CabText("Ratings", size: 15, spacing: 1.3),
                              rating == 0
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 4, left: 10),
                                      child: RatingBar(
                                        initialRating: rating.toDouble(),
                                        minRating: 0,
                                        glow: false,
                                        ignoreGestures: true,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemSize: 20,
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
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: .0),
                                        onRatingUpdate: (rating) {},
                                      )),
                            ],
                          ),
                        ),
                      ])),
            ],
          ),
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
                        child: Icon(CupertinoIcons.location, size: 24),
                      ),
                      CabText(
                        "Pickup Details",
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
                      child: Icon(CupertinoIcons.location_solid, size: 24),
                    ),
                    CabText(
                      "Destination Details",
                      size: 18,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: CabText(widget.ride.pickupAddress)),
                      SizedBox(
                        height: 180,
                        child: GoogleMap(
                            markers: {
                              Marker(
                                  markerId: MarkerId(widget.ride.id),
                                  position: LatLng(widget.ride.uLatitude,
                                      widget.ride.uLongitude))
                            },
                            initialCameraPosition: CameraPosition(
                                target: LatLng(widget.ride.uLatitude,
                                    widget.ride.uLongitude),
                                zoom: 16)),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: CabText(widget.ride.destination)),
                        SizedBox(
                          height: 180,
                          child: GoogleMap(
                              mapType: MapType.normal,
                              markers: {
                                Marker(
                                    markerId: MarkerId("${widget.ride.id}1"),
                                    position: LatLng(widget.ride.dLatitude,
                                        widget.ride.dLongitude))
                              },
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(widget.ride.dLatitude,
                                      widget.ride.dLongitude),
                                  zoom: 16)),
                        )
                      ],
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
