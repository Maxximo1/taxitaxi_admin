import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'helpers/routes.dart';
import 'screens/splash.dart';
import 'url_strategy_wative_config.dart'
    if (dart.library.html) 'url_strategy_web_config.dart';

Future<void> main() async {
  urlConfig();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCUccc-tACEJJ1mcizQz2mgHTDQfPo1iyQ",
          authDomain: "vai-vem-3e551.firebaseapp.com",
          projectId: "vai-vem-3e551",
          storageBucket: "vai-vem-3e551.appspot.com",
          messagingSenderId: "712512898881",
          appId: "1:712512898881:web:23c7c9d8557f76c6d783c0",
          measurementId: "G-65SGDVS5HD"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      title: 'TaxiTaxi Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const SplashScreen(),
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      // )
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
