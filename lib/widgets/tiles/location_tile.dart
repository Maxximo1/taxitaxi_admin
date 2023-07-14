// import 'package:flutter/material.dart';

// import '../../models/location_model.dart';

// import '../../services/location_service.dart';

// import '../cab_text.dart';
// import '../cab_text_field.dart';

// class LocationTile extends StatefulWidget {
//   Location location;
//   int index;
//   void Function(Location? newLocation, int index, String type) func;
//   LocationTile(
//       {Key? key,
//       required this.location,
//       required this.index,
//       required this.func})
//       : super(key: key);

//   @override
//   State<LocationTile> createState() => _LocationTileState();
// }

// class _LocationTileState extends State<LocationTile> {
//   bool addMode = false;
//   bool editMode = false;
//   TextEditingController nameController = TextEditingController();
//   @override
//   void initState() {
//     nameController.text = widget.location.name;
//     if (widget.location.id == null) {
//       addMode = true;
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Card(
//         elevation: 4,
//         child: ListTile(
//           trailing: const SizedBox(),
//           title: Padding(
//               padding: const EdgeInsets.all(4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 14, right: 30),
//                         child: SizedBox(
//                           width: 50,
//                           child: Icon(
//                             Icons.menu,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 400,
//                         height: 60,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             addMode || editMode
//                                 ? const SizedBox()
//                                 : CabText(
//                                     "Title: ",
//                                     color: Colors.grey[700],
//                                     size: 20,
//                                     weight: FontWeight.w100,
//                                   ),
//                             addMode || editMode
//                                 ? Padding(
//                                     padding: const EdgeInsets.only(top: 4),
//                                     child: SizedBox(
//                                       width: 300,
//                                       child: CabTextField(
//                                           controller: nameController,
//                                           hintText: "Location Title ",
//                                           isPassword: false),
//                                     ),
//                                   )
//                                 : CabText(
//                                     widget.location.name,
//                                     color: const Color(0xFF000000),
//                                     size: 22,
//                                     weight: FontWeight.w100,
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.blue[700])),
//                         onPressed: () async {
//                           if (addMode || editMode) {
//                             if (nameController.text.trim().isEmpty) {
//                             } else {
//                               if (editMode) {
//                                 await LocationService()
//                                     .editLocation(widget.location.id!,
//                                         nameController.text.trim(), context)
//                                     .then((value) {
//                                   if (value == "success") {
//                                     widget.func(
//                                         Location(
//                                           id: value,
//                                           name: nameController.text.trim(),
//                                         ),
//                                         widget.index,
//                                         "edit");
//                                     setState(() {
//                                       editMode = false;
//                                     });
//                                   }
//                                 });
//                               } else {
//                                 await LocationService()
//                                     .createLocation(
//                                         nameController.text.trim(), context)
//                                     .then((value) {
//                                   if (value is String) {
//                                     widget.func(
//                                         Location(
//                                           id: value,
//                                           name: nameController.text.trim(),
//                                         ),
//                                         widget.index,
//                                         "add");
//                                     setState(() {
//                                       addMode = false;
//                                     });
//                                   }
//                                 });
//                               }
//                             }
//                           } else {
//                             setState(() {
//                               editMode = true;
//                             });
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 2),
//                           child: Row(
//                             children: [
//                               Icon(
//                                   addMode || editMode ? Icons.done : Icons.edit,
//                                   color: Colors.white),
//                               const SizedBox(width: 6),
//                               CabText(
//                                 addMode || editMode ? "Save" : "Edit",
//                                 color: Colors.white,
//                                 size: 16,
//                                 weight: FontWeight.w100,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 30),
//                       ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.red)),
//                         onPressed: () async {
//                           if (addMode) {
//                             widget.func(null, widget.index, "cancel");
//                             setState(() {
//                               addMode = false;
//                             });
//                           } else if (editMode) {
//                             setState(() {
//                               editMode = false;
//                               nameController.text = widget.location.name;
//                             });
//                           } else {
//                             await LocationService()
//                                 .deleteLocation(widget.location.id!)
//                                 .then((value) {
//                               if (value == "success") {
//                                 editMode = false;
//                                 widget.func(null, widget.index, "cancel");
//                                 setState(() {});
//                               }
//                             });
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 2),
//                           child: Row(
//                             children: [
//                               Icon(
//                                   addMode || editMode
//                                       ? Icons.close
//                                       : Icons.delete,
//                                   color: Colors.white),
//                               const SizedBox(width: 6),
//                               CabText(
//                                 addMode || editMode ? "Cancel" : "Delete",
//                                 color: Colors.white,
//                                 size: 16,
//                                 weight: FontWeight.w100,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
