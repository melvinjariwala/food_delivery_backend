// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:food_delivery_backend/screens/login_screen.dart';
import 'package:food_delivery_backend/screens/menu.dart';
import 'package:food_delivery_backend/screens/settings.dart';
import 'package:food_delivery_backend/screens/signup_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print("The route is : ${settings.name}");
    switch (settings.name) {
      case '/':
        return LoginScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      case MenuScreen.routeName:
        return MenuScreen.route();
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
            ),
        settings: const RouteSettings(name: '/error'));
  }
}
