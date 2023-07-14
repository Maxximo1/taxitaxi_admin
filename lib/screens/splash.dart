import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/constants.dart';
import '../helpers/style.dart';
import 'home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(authPref) && prefs.getString(authPref) != "") {
      Future.delayed(const Duration(seconds: 2)).whenComplete(() =>
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName));
    } else {
      Future.delayed(const Duration(seconds: 2)).whenComplete(() =>
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child:
              Hero(tag: "logo-shift", child: Image.asset('assets/logo-tb.png')),
        ));
  }
}
