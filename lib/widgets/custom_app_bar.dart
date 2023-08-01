// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_backend/blocs/settings/settings_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return AppBar(
            title: Text('Restaurant Name',
                style: Theme.of(context).textTheme.headline2),
            centerTitle: false,
          );
        }
        if (state is SettingsLoaded) {
          return AppBar(
            title: Text(
                (state.restaurant.name == null)
                    ? 'Set your restaurnt name'
                    : state.restaurant.name!,
                style: Theme.of(context).textTheme.headline2),
            centerTitle: false,
          );
        }
        return const Text("Something went wrong");
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
