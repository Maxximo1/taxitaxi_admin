// import 'package:flutter/material.dart';
// import 'package:taxitaxi_admin/models/location_model.dart';
// import '../services/location_service.dart';

// import '../widgets/pa_header.dart';
// import '../widgets/cab_text.dart';
// import '../widgets/tiles/location_tile.dart';

// class LocationScreen extends StatefulWidget {
//   static const routeName = "/LocationScreen";
//   const LocationScreen({Key? key}) : super(key: key);

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   bool addMode = false;
//   List<Location> locations = [];
//   ScrollController controller = ScrollController();
//   @override
//   void initState() {
//     LocationService().fetchLocation().then((value) => setState(() {
//           locations = value;
//         }));
//     super.initState();
//   }

//   void alterMode(Location? newLocation, int index, String type) {
//     if (type == "add") {
//       locations[locations.length - 1] = newLocation!;
//     } else if (type == "edit") {
//       locations[index] = newLocation!;
//     } else {
//       locations[index] = Location(id: null, name: "");
//       locations.removeAt(index);
//       setState(() {});
//     }
//     addMode = false;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         resizeToAvoidBottomInset: true,
//         body: ListView(controller: controller, children: [
//           const CabHeader(title: "Dashboard"),
//           // const Center(
//           //   child: Padding(
//           //       padding: EdgeInsets.only(top: 40, bottom: 20),
//           //       child: CabText("Main Categories", size: 30)),
//           // ),
//           // ListView.builder(
//           //   shrinkWrap: true,
//           //   padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
//           //   itemCount: rideFare.length,
//           //   itemBuilder: (ctx, i) {
//           //     return RideFareTile(rideFare: rideFare[i]);
//           //   },
//           // ),
//           Center(
//             child: Padding(
//                 padding: const EdgeInsets.only(top: 40, bottom: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(width: 230),
//                     const CabText("Locations", size: 30),
//                     const SizedBox(width: 30),
//                     InkWell(
//                       onTap: () {
//                         if (!addMode) {
//                           addMode = true;
//                           locations.add(Location(id: null, name: ""));
//                         }
//                         controller.animateTo(
//                           controller.position.maxScrollExtent,
//                           duration: const Duration(seconds: 1),
//                           curve: Curves.fastOutSlowIn,
//                         );
//                         setState(() {});
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 200,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             border: Border.all(),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: const CabText("+ Add Locations"),
//                       ),
//                     )
//                   ],
//                 )),
//           ),
//           ListView.builder(
//             shrinkWrap: true,
//             padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
//             itemCount: locations.length,
//             itemBuilder: (ctx, i) {
//               return LocationTile(
//                   location: locations[i], index: i, func: alterMode);
//             },
//           ),
//         ]));
//   }
// }
