// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../constants.dart';
// import '../helpers/methods.dart';

// class NotificationService {
//   Future sendNotification(
//       {XFile? image,
//       required Map<String, String> data,
//       required BuildContext context}) async {
//     try {
//       FocusScope.of(context).unfocus();
//       var request =
//           http.MultipartRequest("POST", Uri.parse("$baseUrl/sendNotification"));
//       if (image != null) {
//         var multipartFile = http.MultipartFile.fromBytes(
//           'notificationImage',
//           await image.readAsBytes(),
//           filename: "notificationimg.${image.mimeType!.split("/").last}",
//         );

//         request.files.add(multipartFile);
//       }
//       request.fields.addAll(data);
//       http.Response response =
//           await http.Response.fromStream(await request.send());
//       print(response.body);
//       if (response.statusCode == 200) {
//         FocusScope.of(context).unfocus();
//         showSnack(
//             context: context,
//             message: 'Notification Sent Successfully.',
//             color: Colors.green);
//       } else {
//         showSnack(
//             context: context,
//             message: 'Notification Sent Failed. Try again later.',
//             color: Colors.red);
//       }
//     } catch (e) {
//       print(e);
//       showSnack(
//           context: context,
//           message: 'Notification Sent Failed. Try again later.',
//           color: Colors.red);
//     }
//   }
// }
