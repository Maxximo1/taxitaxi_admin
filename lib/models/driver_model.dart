import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Driver {
  static const idConst = "id";
  static const nameConst = "name";
  static const emailConst = "email";
  static const latitudeConst = "latitude";
  static const longitudeConst = "longitude";
  static const headingConst = "heading";
  static const positionConst = "position";
  static const carConst = "car";
  static const plateConst = "plate";
  static const photoConst = "photo";
  static const ratingConst = "rating";
  static const tripsConst = "trips";
  static const phoneConst = "phone";
  static const onlineConst = "online";
  static const typeConst = "type";
  static const isActiveConst = "isActive";
  static const vehicleIdProofConst = "vehicleProof";
  static const idProofConst = "idProof";

  final String id;
  final bool isActive;
  final String name;
  final String car;
  final String plate;
  final String photo;
  final String phone;
  final String type;
  final String email;
  final bool online;
  final String? vehicleIdProof;
  final String? idProof;

  final DriverPosition position;
  Driver(
      {required this.id,
      required this.isActive,
      required this.vehicleIdProof,
      required this.idProof,
      required this.name,
      required this.email,
      required this.car,
      required this.online,
      required this.type,
      required this.plate,
      required this.photo,
      required this.phone,
      required this.position});

  static Driver fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return Driver(
        isActive: data[isActiveConst],
        email: data[emailConst],
        name: data[nameConst],
        id: data[idConst],
        online: data[onlineConst],
        type: data[typeConst],
        car: data[carConst],
        plate: data[plateConst],
        photo: data[photoConst] ?? "",
        phone: data[phoneConst],
        idProof: data[idConst],
        vehicleIdProof: data[vehicleIdProofConst],
        position: DriverPosition(
            lat: data[positionConst][latitudeConst],
            lng: data[positionConst][longitudeConst],
            heading: data[positionConst][headingConst]));
  }

  LatLng getPosition() {
    return LatLng(position.lat, position.lng);
  }
}

class DriverPosition {
  final double lat;
  final double lng;
  final double heading;

  DriverPosition({required this.lat, required this.lng, required this.heading});
}
