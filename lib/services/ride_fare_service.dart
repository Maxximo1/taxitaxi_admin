import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/methods.dart';
import '../models/ride_fare_model.dart';

class RideFareService {
  Future<List<RideFare>> fetchRideFare() async {
    List<RideFare> rideFares = [];
    QuerySnapshot snaps =
        await FirebaseFirestore.instance.collection("rides").get();
    for (var element in snaps.docs) {
      rideFares.add(RideFare.fromJson(element.data() as Map<String, dynamic>));
    }
    return rideFares;
  }

  Future editRideFare(
      {required String rideFareId,
      dynamic image,
      required String name,
      required double fare,
      required String desc,
      required double fixedFare,
      required bool isActive,
      required BuildContext context}) async {
    try {
      Map<String, Object> updateData = {
        "name": name,
        "farePerKm": fare,
        "isActive": isActive,
        "desc": desc,
        "fixedFare": fixedFare
      };
      if (image != null && image is XFile) {
        String url = await uploadImage(image, name.toLowerCase());
        updateData["imageUrl"] = url;
      }

      FirebaseFirestore.instance
          .collection("rides")
          .doc(rideFareId)
          .update(updateData);

      return rideFareId;
    } catch (e) {
      showSnack(
          context: context,
          message: 'RideFare Add Failed. Try again later.',
          color: Colors.red);
    }
  }

  Future<String> uploadImage(XFile imageFile, String id) async {
    String url = "";
    Reference ref = FirebaseStorage.instance.ref("rides/").child(
        "${id.trim().toLowerCase().replaceAll(" ", "-")}.${imageFile.mimeType?.split("/")[1] ?? ".png"}");
    UploadTask uploadTask = ref.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(
            contentType:
                "image/${imageFile.mimeType?.split("/")[1] ?? "png"}"));
    await uploadTask.then((res) async {
      url = await res.ref.getDownloadURL();
      return url;
    });

    return url;
  }

  Future addRideFare(
      {required XFile image,
      required String name,
      required String desc,
      required double fixedFare,
      required double fare,
      required BuildContext context}) async {
    try {
      DocumentReference ref =
          FirebaseFirestore.instance.collection("rides").doc();
      String url = await uploadImage(image, name.toLowerCase());
      Map<String, dynamic> dataMap = {
        "name": name,
        "id": ref.id,
        "desc": desc,
        "fixedFare": fixedFare,
        "imageUrl": url,
        "isActive": true,
        "farePerKm": fare,
      };
      await ref.set(dataMap);
      return dataMap;
    } catch (e) {
      showSnack(
          context: context,
          message: 'RideFare Add Failed. Try again later.',
          color: Colors.red);
    }
  }

//   Future<dynamic> deleteRideFare(String id) async {
//     http.Response response = await http.delete(
//       Uri.parse("$baseUrl/rideFare/$id"),
//       headers: headerApiMap,
//     );

//     if (response.statusCode == 200) {
//       return "success";
//     } else {
//       return null;
//     }
//   }
// }
}
