import 'package:flutter/material.dart';
import 'package:food_delivery_backend/config/theme.dart';
import 'package:food_delivery_backend/config/app_router.dart';
import 'package:food_delivery_backend/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery Backend',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: MenuScreen.routeName,
    );
  }
}
