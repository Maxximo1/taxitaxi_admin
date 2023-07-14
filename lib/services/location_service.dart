// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../constants.dart';
// import '../helpers/methods.dart';
// import '../models/location_model.dart';

// class LocationService {
//   Future<List<Location>> fetchLocation() async {
//     List<Location> rideFares = [];

//     http.Response response = await http.get(Uri.parse("$baseUrl/locations"));

//     List data = jsonDecode(response.body)['data'];
//     for (var element in data) {
//       rideFares.add(Location.fromJson(element));
//     }
//     return rideFares;
//   }

//   Future<dynamic> createLocation(String name, BuildContext context) async {
//     http.Response response = await http.post(Uri.parse("$baseUrl/location"),
//         headers: headerApiMap, body: jsonEncode({"name": name}));

//     if (response.statusCode == 200) {
//       FocusScope.of(context).unfocus();
//       showSnack(
//           context: context,
//           message: 'Location Added Successfully.',
//           color: Colors.green);
//       return jsonDecode(response.body)['data']["_id"];
//     } else {
//       showSnack(
//           context: context,
//           message: 'Location Add Failed. Try again later.',
//           color: Colors.red);
//       return null;
//     }
//   }

//   Future<dynamic> editLocation(
//       String id, String name, BuildContext context) async {
//     http.Response response = await http.post(Uri.parse("$baseUrl/location/$id"),
//         headers: headerApiMap, body: jsonEncode({"name": name}));

//     if (response.statusCode == 200) {
//       FocusScope.of(context).unfocus();
//       showSnack(
//           context: context,
//           message: 'Location Updated Successfully.',
//           color: Colors.green);
//       return "success";
//     } else {
//       showSnack(
//           context: context,
//           message: 'Location Update Failed. Try again later.',
//           color: Colors.red);
//       return null;
//     }
//   }

//   Future<dynamic> deleteLocation(String id) async {
//     http.Response response = await http.delete(
//       Uri.parse("$baseUrl/location/$id"),
//       headers: headerApiMap,
//     );

//     if (response.statusCode == 200) {
//       return "success";
//     } else {
//       return null;
//     }
//   }
// }
