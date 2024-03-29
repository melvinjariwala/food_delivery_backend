// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_backend/blocs/authentication/authentication_bloc.dart';
import 'package:food_delivery_backend/blocs/settings/settings_bloc.dart';
import 'package:food_delivery_backend/cubits/login/login_cubit.dart';
import 'package:food_delivery_backend/screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> screens = {
      'Dashboard': {
        'routeName': '/dashboard',
        'icon': const Icon(Icons.dashboard)
      },
      'Menu': {'routeName': '/menu', 'icon': const Icon(Icons.menu_book)},
      'Settings': {
        'routeName': '/settings',
        'icon': const Icon(Icons.lock_clock)
      },
      'Logout': {'routeName': '/logout', 'icon': const Icon(Icons.logout)}
    };
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state is SettingsLoading) {
                  return DrawerHeader(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: Text("Restaurant Name",
                          style: Theme.of(context).textTheme.headline2));
                }
                if (state is SettingsLoaded) {
                  return DrawerHeader(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: Text(
                          (state.restaurant.name == null)
                              ? 'Set your restaurant name'
                              : state.restaurant.name!,
                          style: Theme.of(context).textTheme.headline2));
                }
                return DrawerHeader(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Text("Restaurant Name",
                        style: Theme.of(context).textTheme.headline2));
              },
            ),
          ),
          ...screens.entries.map((screen) {
            if (screen.key == 'Logout') {
              return ListTile(
                leading: screen.value['icon'],
                title: Text(screen.key),
                onTap: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticcationLogoutRequest());
                  print("route : ${LoginScreen.route()}");
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              );
            } else {
              return ListTile(
                leading: screen.value['icon'],
                title: Text(screen.key),
                onTap: () {
                  Navigator.pushNamed(context, screen.value['routeName']);
                },
              );
            }
          })
        ],
      ),
    );
  }
}
