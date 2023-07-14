import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxitaxi_admin/helpers/methods.dart';
import 'package:taxitaxi_admin/models/ride_model.dart';

import '../helpers/style.dart';
import '../models/ride_fare_model.dart';
import '../services/ride_fare_service.dart';
import '../services/ride_service.dart';

import '../widgets/cab_header.dart';
import '../widgets/cab_text.dart';
import '../widgets/search_field.dart';
import '../widgets/tiles/ride_tile.dart';

class RidesScreen extends StatefulWidget {
  final Map args;
  static const routeName = "/rides";
  const RidesScreen({super.key, required this.args});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  List<RideModel> rides = [];
  List<RideFare> rideFares = [];
  List<RideModel>? filteredResult;
  TextEditingController idController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  List statusList = [
    "All Status",
    "Accepted",
    "Rejected",
    "Cancelled",
    "Pending",
    "Expired",
    "Arrived",
    "Started",
    "Completed",
  ];
  String selectedStatus = "All Status";
  @override
  void initState() {
    RideService()
        .fetchRides(widget.args["role"], widget.args["id"])
        .then((value) => setState(() {
              rides = value;
              filteredResult = value;
            }));
    RideFareService().fetchRideFare().then((value) => setState(() {
          rideFares = value;
        }));
    super.initState();
  }

  pickFilterDateRange() async {
    final picked = await showDateRangePicker(
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400.0,
                maxHeight: 500.0,
              ),
              child: child,
            )
          ],
        );
      },
      context: context,
      lastDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime(2022),
    );
    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  void filterData() {
    List<RideModel> dummy = [];
    for (var element in rides) {
      if (idController.text.trim().isEmpty &&
          selectedStatus == "All Status" &&
          startDate == null &&
          endDate == null) {
        dummy.add(element);
      } else if ((idController.text.trim().isEmpty ||
              element.id.contains(idController.text.trim())) &&
          (endDate == null ||
              (element.createdAt
                      .isBefore(endDate!.add(const Duration(days: 1))) &&
                  element.createdAt.isAfter(startDate!))) &&
          (selectedStatus == "All Status" ||
              selectedStatus.toLowerCase() == element.status.toLowerCase())) {
        dummy.add(element);
      }
    }
    // for (var e in filteredResult) {
    //   print(e.id);
    // }
    setState(() {
      filteredResult = dummy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: ListView(children: [
          CabHeader(
              title: widget.args["name"].isEmpty
                  ? "Dashboard"
                  : "${widget.args["role"].toString().capitalize()} Details"),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: CabText(
                    "${widget.args["name"].isEmpty ? "" : widget.args["name"] + "'s"} Rides",
                    size: 30)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 108),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: SearchField(
                            controller: idController,
                            hintText: "Search By ID")),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              customButton: Container(
                                height: 48,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    // border: Border.all(),
                                    borderRadius: BorderRadius.circular(2)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedStatus,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          height: 1,
                                          letterSpacing: 1.5,
                                          color: Color(0xFF000000)),
                                    ),
                                    const Icon(
                                        CupertinoIcons.arrow_up_arrow_down,
                                        color: Color(0xFF000000),
                                        size: 20)
                                  ],
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedStatus = value!;
                                });
                              },
                              items: statusList
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList()),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: InkWell(
                          onTap: () {
                            pickFilterDateRange();
                          },
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                // border: Border.all(),
                                borderRadius: BorderRadius.circular(2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  startDate == null && endDate == null
                                      ? "Pick Date Range"
                                      : "${DateFormat.MMMd().format(startDate!)} - ${DateFormat.MMMd().format(endDate!)}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      height: 1,
                                      letterSpacing: 1.5,
                                      color: Color(0xFF000000)),
                                ),
                                const Icon(CupertinoIcons.arrow_up_arrow_down,
                                    color: Color(0xFF000000), size: 20)
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(primaryColor)),
                      onPressed: () {
                        filterData();
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: CabText(
                          "Search",
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
                              MaterialStatePropertyAll(Colors.red)),
                      onPressed: () {
                        startDate = null;
                        endDate = null;
                        selectedStatus = "All Status";
                        idController.clear();
                        filterData();
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: CabText(
                          "Clear",
                          color: Colors.white,
                          size: 17,
                          weight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          filteredResult == null
              ? const Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : filteredResult!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(children: const [
                        Icon(Icons.info_outline, size: 36, color: primaryColor),
                        SizedBox(height: 12),
                        Text("No rides found",
                            style:
                                TextStyle(fontSize: 25, color: primaryColor)),
                      ]),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 20),
                      itemCount: filteredResult!.length,
                      itemBuilder: (ctx, i) {
                        return RideTile(
                            ride: filteredResult![i], rideFares: rideFares);
                      },
                    ),
        ]));
  }
}
