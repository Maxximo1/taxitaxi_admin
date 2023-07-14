// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../constants.dart';
// import '../helpers/methods.dart';

// import '../helpers/style.dart';
// import '../services/notification_service.dart';
// import '../widgets/cab_header.dart';
// import '../widgets/cab_text.dart';
// import '../widgets/cab_text_field.dart';

// class NotificationScreen extends StatefulWidget {
//   static const routeName = "/notification";

//   const NotificationScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController bodyController = TextEditingController();
//   XFile? image;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         resizeToAvoidBottomInset: true,
//         body: ListView(children: [
//           const CabHeader(title: "Dashboard"),
//           const Padding(
//             padding: EdgeInsets.only(top: 40, bottom: 30),
//             child: Center(child: CabText("Notifications", size: 30)),
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     width: 480,
//                     height: 270,
//                     margin: const EdgeInsets.only(
//                         left: 40, top: 10, bottom: 10, right: 50),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: image == null
//                           ? InkWell(
//                               onTap: () async {
//                                 image = await getImageFromGallery();
//                                 setState(() {});
//                               },
//                               child: const Icon(
//                                 Icons.add,
//                                 size: 80,
//                                 color: Colors.white,
//                               ),
//                             )
//                           : Image.network(
//                               image!.path,
//                               width: 480,
//                               height: 270,
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                   ),
//                   if (image != null)
//                     Positioned(
//                         right: 35,
//                         child: InkWell(
//                           onTap: () {
//                             image = null;
//                             setState(() {});
//                           },
//                           child: const CircleAvatar(
//                               backgroundColor: Colors.red,
//                               child: Icon(Icons.delete, color: Colors.white)),
//                         ))
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                         width: 600,
//                         child: CabTextField(
//                             hintText: "Title ",
//                             controller: titleController,
//                             headerText: "Notification Title ",
//                             isPassword: false)),
//                     const Padding(
//                         padding: EdgeInsets.only(top: 30, bottom: 12, left: 2),
//                         child: CabText("Notification Message ")),
//                     SizedBox(
//                       width: 600,
//                       child: TextFormField(
//                         controller: bodyController,
//                         cursorColor: const Color(0xFF000000),
//                         cursorWidth: 1.5,
//                         cursorHeight: 14,
//                         maxLines: 3,
//                         style: const TextStyle(
//                             fontSize: 14,
//                             height: 1,
//                             letterSpacing: 1.5,
//                             color: Color(0xFF000000)),
//                         decoration: InputDecoration(
//                             isDense: true,
//                             hintText: "Message ",
//                             hintStyle: const TextStyle(
//                                 fontSize: 14,
//                                 height: 1,
//                                 //  fontWeight: FontWeight.w300,
//                                 color: Color(0xFF000000)),
//                             errorBorder: errorBorder,
//                             focusedBorder: border,
//                             enabledBorder: border,
//                             focusedErrorBorder: errorBorder,
//                             border: border),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width - 700,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 30),
//                             child: SizedBox(
//                               width: 210,
//                               child: ElevatedButton(
//                                 style: ButtonStyle(
//                                     backgroundColor: MaterialStateProperty.all(
//                                         primaryColor)),
//                                 onPressed: () {
//                                   if (bodyController.text.trim().isEmpty ||
//                                       titleController.text.trim().isEmpty) {
//                                   } else {
//                                     NotificationService()
//                                         .sendNotification(data: {
//                                       "title": titleController.text,
//                                       "body": bodyController.text,
//                                       "sendTo": "userModel"
//                                     }, context: context, image: image);
//                                   }
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 8, horizontal: 2),
//                                   child: Row(
//                                     children: const [
//                                       Icon(CupertinoIcons.paperplane,
//                                           color: Colors.white),
//                                       SizedBox(width: 9),
//                                       CabText(
//                                         "Send To Users",
//                                         color: Colors.white,
//                                         size: 17,
//                                         weight: FontWeight.w100,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 30, left: 30),
//                             child: SizedBox(
//                               width: 220,
//                               child: OutlinedButton(
//                                 style: ButtonStyle(
//                                   side: MaterialStatePropertyAll(
//                                       BorderSide(color: primaryColor)),
//                                 ),
//                                 onPressed: () {
//                                   if (bodyController.text.trim().isEmpty ||
//                                       titleController.text.trim().isEmpty) {
//                                   } else {
//                                     NotificationService().sendNotification(
//                                         data: {
//                                           "title": titleController.text,
//                                           "body": bodyController.text,
//                                           "sendTo": "driver"
//                                         },
//                                         context: context,
//                                         image: image);
//                                   }
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 8, horizontal: 2),
//                                   child: Row(
//                                     children: const [
//                                       Icon(CupertinoIcons.paperplane,
//                                           color: primaryColor),
//                                       SizedBox(width: 9),
//                                       CabText(
//                                         "Send To Drivers",
//                                         color: primaryColor,
//                                         size: 17,
//                                         weight: FontWeight.w600,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           )
//         ]));
//   }
// }
