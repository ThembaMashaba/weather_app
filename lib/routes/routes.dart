import 'package:flutter/material.dart';
import 'package:flutter_weather_app_apr22/pages/home.dart';
import 'package:flutter_weather_app_apr22/pages/login.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String homePage = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const Home(),
        );

      default:
        throw const FormatException('Route not found. Please check routing.');
    }
  }
}
