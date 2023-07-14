import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:taxitaxi_admin/screens/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/constants.dart';
import '../helpers/methods.dart';

class AdminService {
  Future signIn(String email, String password, BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        prefs.setString(authPref, value.user!.uid);
        prefs.setBool(loggedInPref, true);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnack(context: context, message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnack(
            context: context,
            message: 'Wrong password provided for that user.');
      } else {
        showSnack(context: context, message: e.message ?? "");
      }
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  Future<Map> fetchCount() async {
    AggregateQuerySnapshot usersSnaps =
        await FirebaseFirestore.instance.collection('users').count().get();
    AggregateQuerySnapshot driversSnaps =
        await FirebaseFirestore.instance.collection('drivers').count().get();
    AggregateQuerySnapshot requestsSnaps =
        await FirebaseFirestore.instance.collection('requests').count().get();
    return {
      "Bookings": requestsSnaps.count,
      "Drivers": driversSnaps.count,
      "Users": usersSnaps.count,
    };
  }
}
