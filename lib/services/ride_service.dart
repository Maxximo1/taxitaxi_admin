import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/methods.dart';
import '../models/ride_model.dart';

class RideService {
  Future<List<RideModel>> fetchRides(String role, String id) async {
    List<RideModel> rides = [];
    if (role.isEmpty) {
      QuerySnapshot snaps =
          await FirebaseFirestore.instance.collection("requests").get();
      for (var element in snaps.docs) {
        rides.add(RideModel.fromMap(element.data() as Map));
      }
    } else {
      QuerySnapshot snaps = await FirebaseFirestore.instance
          .collection("requests")
          .where("${role}Id", isEqualTo: id)
          .get();
      for (var element in snaps.docs) {
        rides.add(RideModel.fromMap(element.data() as Map));
      }
    }
    return rides;
  }

  Future editBooingStatus(
      String rideId, String bookingStatus, BuildContext context) async {
    try {
      Map<String, Object> updateData = {"status": bookingStatus.toLowerCase()};

      FirebaseFirestore.instance
          .collection("requests")
          .doc(rideId)
          .update(updateData);
      showSnack(
          context: context,
          message: 'Booking Status Updated Successfully.',
          color: Colors.green);
    } catch (e) {
      showSnack(
          context: context,
          message: 'Booking Status Update Failed. Try again later.',
          color: Colors.red);
    }
  }

  // Future<RideModel?> updateBooking(
  //     String id, String status, BuildContext ctx) async {
  //   RideModel? ride;
  //   Map body = {
  //     "bookingStatus": status,
  //   };
  //   http.Response response = await http.post(
  //       body: jsonEncode(body),
  //       headers: headerApiMap,
  //       Uri.parse("$baseUrl/updateBooking/$id"));
  //   print(jsonDecode(response.body));
  //   if (response.statusCode == 200) {
  //     ride = RideModel.fromJson(jsonDecode(response.body)['data']);
  //     showSnack(
  //         context: ctx,
  //         message: 'RideModel Updated Successfully.',
  //         color: Colors.green);
  //   } else {
  //     showSnack(
  //         context: ctx,
  //         message: 'RideModel Update Failed. Try again later.',
  //         color: Colors.red);
  //   }
  //   return ride;
  // }
}
