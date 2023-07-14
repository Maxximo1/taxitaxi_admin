import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taxitaxi_admin/models/driver_model.dart';

import '../helpers/methods.dart';

class DriverService {
  Future<List<Driver>> fetchDrivers() async {
    List<Driver> drivers = [];
    QuerySnapshot snaps =
        await FirebaseFirestore.instance.collection("drivers").get();

    for (var element in snaps.docs) {
      drivers.add(Driver.fromSnapshot(element));
    }
    return drivers.reversed.toList();
  }

  Future editDriverStatus(
      {required String driverId,
      required bool isActive,
      required BuildContext context}) async {
    try {
      Map<String, Object> updateData = {"isActive": isActive};

      FirebaseFirestore.instance
          .collection("drivers")
          .doc(driverId)
          .update(updateData);
      showSnack(
          context: context,
          message: 'Driver Status Updated Successfully.',
          color: Colors.green);
    } catch (e) {
      showSnack(
          context: context,
          message: 'Driver Status Update Failed. Try again later.',
          color: Colors.red);
    }
  }
}
