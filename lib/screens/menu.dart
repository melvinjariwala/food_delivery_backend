import 'package:flutter/material.dart';
import 'package:food_delivery_backend/config/responsive.dart';
import 'package:food_delivery_backend/models/category_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/widgets/category_list_tile.dart';
import 'package:food_delivery_backend/widgets/custom_app_bar.dart';
import 'package:food_delivery_backend/widgets/custom_drawer.dart';
import 'package:food_delivery_backend/widgets/product_card.dart';
import 'package:food_delivery_backend/widgets/product_list_tile.dart';

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
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Restaurant Menu",
                        style: Theme.of(context).textTheme.headline3),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: Product.products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                                product: Product.products[index], index: index);
                          }),
                    ),
                    const SizedBox(height: 20.0),
                    Responsive.isWideDesktop(context) ||
                            Responsive.isDesktop(context)
                        ? Container(
                            constraints: const BoxConstraints(
                                minHeight: 300, maxHeight: 1000),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildCategories(context),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: _buildProducts(context),
                                )
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              _buildCategories(context),
                              const SizedBox(height: 20.0),
                              _buildProducts(context)
                            ],
                          ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 75),
                      color: Theme.of(context).backgroundColor,
                      child: const Center(child: Text("Advertisements")),
                    )
                  ],
                ),
              ),
            ),
          ),
          Responsive.isWideDesktop(context) || Responsive.isDesktop(context)
              ? Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, right: 20.0),
                    color: Theme.of(context).colorScheme.background,
                    child: const Center(child: Text("Advertisements")),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Container _buildProducts(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Products", style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 20.0),
          ...Product.products.map((product) {
            return ProductListTile(product: product);
          }).toList()
        ],
      ),
    );
  }

  Container _buildCategories(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Categories", style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 20.0),
          ...Category.categories.map((category) {
            return CategoryListTile(category: category);
          }).toList()
        ],
      ),
    );
  }
}
