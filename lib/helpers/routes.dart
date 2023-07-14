import 'package:flutter/material.dart';
import 'package:taxitaxi_admin/screens/ride_fare.dart';

import '../../screens/login.dart';
import '../screens/rides.dart';

import '../screens/home.dart';

import '../screens/user_address.dart';
import '../screens/users.dart';
import '../screens/drivers.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case UserAddressScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => UserAddressScreen(args: args as Map),
        );
      case RidesScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => RidesScreen(args: args as Map),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case RideFareScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RideFareScreen(),
        );

      // case NotificationScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (context) => const NotificationScreen(),
      //   );
      case DriversScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const DriversScreen(),
        );
      case UsersScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const UsersScreen(),
        );

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('ERROR')),
          body: const Center(
            child: Text("Page not found"),
          ),
        );
      },
    );
  }
}
