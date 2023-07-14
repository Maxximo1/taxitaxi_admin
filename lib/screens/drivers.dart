import 'package:flutter/material.dart';
import 'package:taxitaxi_admin/models/driver_model.dart';
import 'package:taxitaxi_admin/models/ride_fare_model.dart';

import '../helpers/style.dart';
import '../services/driver_service.dart';
import '../services/ride_fare_service.dart';
import '../widgets/cab_header.dart';
import '../widgets/cab_text.dart';
import '../widgets/search_field.dart';
import '../widgets/tiles/driver_tile.dart';

class DriversScreen extends StatefulWidget {
  static const routeName = "/Drivers";
  const DriversScreen({Key? key}) : super(key: key);

  @override
  State<DriversScreen> createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {
  List<Driver> drivers = [];
  List<RideFare> rideFares = [];
  List<Driver>? filteredResult;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  @override
  void initState() {
    DriverService().fetchDrivers().then((value) => setState(() {
          drivers = value;
          filteredResult = value;
        }));
    RideFareService().fetchRideFare().then((value) => setState(() {
          rideFares = value;
        }));
    super.initState();
  }

  void filterData() {
    List<Driver> dummy = [];
    for (var element in drivers) {
      if (nameController.text.trim().isEmpty &&
          idController.text.trim().isEmpty &&
          emailController.text.trim().isEmpty) {
        dummy.add(element);
      } else if ((nameController.text.trim().isEmpty ||
              element.name
                  .toLowerCase()
                  .contains(nameController.text.toLowerCase().trim())) &&
          (emailController.text.trim().isEmpty ||
              element.email
                  .toLowerCase()
                  .contains(emailController.text.toLowerCase().trim())) &&
          (idController.text.trim().isEmpty ||
              element.id.contains(idController.text.trim()))) {
        dummy.add(element);
      }
    }
    filteredResult = dummy;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: ListView(children: [
          const CabHeader(title: "Dashboard"),
          const Center(
            child: Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: CabText("Drivers", size: 30)),
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
                        child: SearchField(
                            controller: nameController,
                            hintText: "Search By Name")),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: SearchField(
                            controller: emailController,
                            hintText: "Search By Email"))
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
                        nameController.clear();
                        emailController.clear();
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
                      child: Column(children: [
                        const Icon(Icons.info_outline,
                            size: 36, color: primaryColor),
                        const SizedBox(height: 12),
                        Text(
                            "No Drivers found ${(nameController.text.trim().isEmpty && idController.text.trim().isEmpty && emailController.text.trim().isEmpty) ? "" : "with search filter."}",
                            style: const TextStyle(
                                fontSize: 25, color: primaryColor)),
                      ]),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 20),
                      itemCount: filteredResult!.length,
                      itemBuilder: (ctx, i) {
                        return DriverTile(
                            driver: filteredResult![i], rideFares: rideFares);
                      },
                    ),
        ]));
  }
}
