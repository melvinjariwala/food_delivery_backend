import 'package:flutter/material.dart';
import 'package:food_delivery_backend/widgets/custom_app_bar.dart';
import 'package:food_delivery_backend/widgets/custom_drawer.dart';
import 'package:food_delivery_backend/widgets/custom_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const SettingsScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: CustomLayout(title: 'Settings', widgets: []),
    );
  }
}
