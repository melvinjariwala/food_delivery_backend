import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_backend/blocs/category/category_bloc.dart';
import 'package:food_delivery_backend/blocs/product/product_bloc.dart';
import 'package:food_delivery_backend/blocs/settings/settings_bloc.dart';
import 'package:food_delivery_backend/config/theme.dart';
import 'package:food_delivery_backend/config/app_router.dart';
import 'package:food_delivery_backend/firebase_options.dart';
import 'package:food_delivery_backend/models/category_model.dart';
import 'package:food_delivery_backend/models/opening_hours_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/models/restaurant_model.dart';
import 'package:food_delivery_backend/screens/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => CategoryBloc()
                ..add(LoadCategory(categories: Category.categories))),
          BlocProvider(
              create: (context) => ProductBloc(
                  categoryBloc: BlocProvider.of<CategoryBloc>(context))
                ..add(LoadProducts(products: Product.products))),
          BlocProvider(
              create: (context) => SettingsBloc()
                ..add(LoadSettings(
                    restaurant: Restaurant(
                        openingHours: OpeningHours.openingHoursList)))),
        ],
        child: MaterialApp(
          title: 'Food Delivery Backend',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: MenuScreen.routeName,
        ));
  }
}
