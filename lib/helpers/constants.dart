import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/drivers.dart';
import '../screens/ride_fare.dart';
import '../screens/rides.dart';
import '../screens/users.dart';
// ignore: depend_on_referenced_packages

const loggedInPref = "loggedIn";
const authPref = "id";
FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

final navigatorKey = GlobalKey<NavigatorState>();
// const showPref = "SHOW_STATUS";
const requestIdPref = "REQUEST_ID";
const driverIdPref = "DRIVER_ID";
const List homeSections = [
  {
    'name': "Bookings",
    "icon": CupertinoIcons.doc_append,
    "route": RidesScreen.routeName,
    "color": Colors.indigo
  },
  {
    'name': "Drivers",
    "icon": Icons.work_history,
    "route": DriversScreen.routeName,
    "color": Colors.green
  },
  {
    'name': "Users",
    "icon": Icons.group,
    "route": UsersScreen.routeName,
    "color": Colors.cyan
  },
  {
    'name': "Rides & Fares",
    "icon": CupertinoIcons.car,
    "route": RideFareScreen.routeName,
    "color": Colors.purple
  },
  // {
  //   'name': "Locations",
  //   "icon": Icons.location_history,
  //   "route": LocationScreen.routeName,
  //   "color": Colors.amber
  // },
  // {
  //   'name': "Notification",
  //   "icon": Icons.notifications_outlined,
  //   "route": NotificationScreen.routeName,
  //   "color": Colors.indigoAccent
  // }
];
