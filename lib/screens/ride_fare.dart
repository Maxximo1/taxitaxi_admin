import 'package:flutter/material.dart';

import '../models/ride_fare_model.dart';

import '../services/ride_fare_service.dart';
import '../widgets/cab_header.dart';
import '../widgets/cab_text.dart';
import '../widgets/tiles/ride_fare_tile.dart';

class RideFareScreen extends StatefulWidget {
  static const routeName = "/RideFareScreen";
  const RideFareScreen({Key? key}) : super(key: key);

  @override
  State<RideFareScreen> createState() => _RideFareScreenState();
}

class _RideFareScreenState extends State<RideFareScreen> {
  List<RideFare> rideFare = [];
  bool addMode = false;

  ScrollController controller = ScrollController();
  @override
  void initState() {
    RideFareService().fetchRideFare().then((value) => setState(() {
          rideFare = value;
        }));

    super.initState();
  }

  void alterMode(RideFare? newRideFare, int index, String type) {
    if (type == "add") {
      rideFare[rideFare.length - 1] = newRideFare!;
    } else if (type == "edit") {
      rideFare[index] = newRideFare!;
    } else {
      rideFare[index] = RideFare(
          id: null,
          name: "",
          image: null,
          farePerKm: 0,
          isActive: true,
          desc: '',
          fixedRate: 0);
      rideFare.removeAt(index);
      setState(() {});
    }
    addMode = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: ListView(controller: controller, children: [
          const CabHeader(title: "Dashboard"),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 230),
                    const CabText("Rides & Fares", size: 30),
                    const SizedBox(width: 30),
                    InkWell(
                      onTap: () {
                        if (!addMode) {
                          addMode = true;
                          rideFare.add(RideFare(
                              desc: '',
                              fixedRate: 0,
                              id: null,
                              name: "",
                              image: null,
                              farePerKm: 0,
                              isActive: true));
                        }
                        controller.animateTo(
                          controller.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: const CabText("+ Add Ride & Fare"),
                      ),
                    )
                  ],
                )),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            itemCount: rideFare.length,
            itemBuilder: (ctx, i) {
              return RideFareTile(
                rideFare: rideFare[i],
                func: alterMode,
                index: i,
              );
            },
          ),
        ]));
  }
}
