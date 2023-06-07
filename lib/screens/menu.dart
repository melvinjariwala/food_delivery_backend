import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  static const String routeName = '/menu';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const MenuScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Menu Screen', style: Theme.of(context).textTheme.headline2),
      ),
    );
  }
}
