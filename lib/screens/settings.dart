// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_backend/blocs/settings/settings_bloc.dart';
import 'package:food_delivery_backend/config/responsive.dart';
import 'package:food_delivery_backend/widgets/custom_app_bar.dart';
import 'package:food_delivery_backend/widgets/custom_drawer.dart';
import 'package:food_delivery_backend/widgets/custom_layout.dart';
import 'package:food_delivery_backend/widgets/custom_opening_hours.dart';
import 'package:food_delivery_backend/widgets/custom_text_form_field.dart';

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
      body: CustomLayout(title: 'Settings', widgets: [
        _buildImage(),
        Responsive.isDesktop(context) || Responsive.isWideDesktop(context)
            ? IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: _buildBasicInformation(context)),
                    const SizedBox(width: 10.0),
                    Expanded(child: _buildRestaurantDescription(context)),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicInformation(context),
                  const SizedBox(height: 20.0),
                  _buildRestaurantDescription(context),
                ],
              ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Opening Hours",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        _buildOpeningHours(),
      ]),
    );
  }

  BlocBuilder<SettingsBloc, SettingsState> _buildOpeningHours() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        } else if (state is SettingsLoaded) {
          if (state.restaurant.openingHours != null) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.restaurant.openingHours!.length,
              itemBuilder: (context, index) {
                var openingHours = state.restaurant.openingHours![index];
                return OpeningHoursSettings(
                  openingHours: openingHours,
                  onCheckboxChanged: (value) {
                    context.read<SettingsBloc>().add(UpdateOpeningHours(
                        openingHours: openingHours.copyWith(
                            isOpen: !openingHours.isOpen)));
                  },
                  onSliderChanged: (value) {
                    context.read<SettingsBloc>().add(UpdateOpeningHours(
                        openingHours: openingHours.copyWith(
                            openAt: value.start, closeAt: value.end)));
                  },
                );
              },
            );
          }
        }
        return const Center(
          child: Text("Something went wrong"),
        );
      },
    );
  }

  Container _buildBasicInformation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).backgroundColor,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (state is SettingsLoaded) {
            return Column(
              children: [
                Text(
                  "Basic Information",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Name',
                  hasTitle: true,
                  initialValue: (state.restaurant.name != null)
                      ? state.restaurant.name!
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(UpdateSettings(
                        restaurant: state.restaurant.copyWith(name: value)));
                  },
                  onFocusChanged: (hasFocus) {
                    context.read<SettingsBloc>().add(UpdateSettings(
                        isUpdateComplete: true, restaurant: state.restaurant));
                  },
                ),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Image',
                  hasTitle: true,
                  initialValue: (state.restaurant.imgUrl != null)
                      ? state.restaurant.imgUrl!
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(UpdateSettings(
                        restaurant: state.restaurant.copyWith(imgUrl: value)));
                  },
                  onFocusChanged: (hasFocus) {
                    context.read<SettingsBloc>().add(UpdateSettings(
                        isUpdateComplete: true, restaurant: state.restaurant));
                  },
                ),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Tags',
                  hasTitle: true,
                  initialValue: (state.restaurant.tags != null)
                      ? state.restaurant.tags!.join(', ')
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(UpdateSettings(
                        restaurant: state.restaurant
                            .copyWith(tags: value.split(', '))));
                  },
                  onFocusChanged: (hasFocus) {
                    context.read<SettingsBloc>().add(UpdateSettings(
                        isUpdateComplete: true, restaurant: state.restaurant));
                  },
                ),
              ],
            );
          }
          return const Center(
            child: Text("Something went wrong!"),
          );
        },
      ),
    );
  }

  Container _buildRestaurantDescription(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).backgroundColor,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (state is SettingsLoaded) {
            return Column(
              children: [
                Text(
                  "Restaurant Description",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  maxLines: 5,
                  title: 'Description',
                  hasTitle: false,
                  initialValue: (state.restaurant.description != null)
                      ? state.restaurant.description!
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(UpdateSettings(
                        restaurant:
                            state.restaurant.copyWith(description: value)));
                    print('Restaurant : ${state.restaurant}');
                  },
                  onFocusChanged: (hasFocus) {
                    if (!hasFocus) {
                      context.read<SettingsBloc>().add(UpdateSettings(
                          isUpdateComplete: true,
                          restaurant: state.restaurant));
                    }
                  },
                ),
              ],
            );
          }
          return const Center(
            child: Text("Something went wrong!"),
          );
        },
      ),
    );
  }

  BlocBuilder<SettingsBloc, SettingsState> _buildImage() {
    //"https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        } else if (state is SettingsLoaded) {
          return (state.restaurant.imgUrl != null)
              ? Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(state.restaurant.imgUrl!),
                          fit: BoxFit.cover)),
                )
              : const SizedBox();
        }
        return const Center(
          child: Text("Something went wrong!"),
        );
      },
    );
  }
}
