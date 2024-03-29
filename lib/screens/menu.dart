// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_backend/blocs/category/category_bloc.dart';
import 'package:food_delivery_backend/blocs/product/product_bloc.dart';
import 'package:food_delivery_backend/config/responsive.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/widgets/add_product_card.dart';
import 'package:food_delivery_backend/widgets/category_list_tile.dart';
import 'package:food_delivery_backend/widgets/custom_app_bar.dart';
import 'package:food_delivery_backend/widgets/custom_drawer.dart';
import 'package:food_delivery_backend/widgets/product_card.dart';
import 'package:food_delivery_backend/widgets/product_list_tile.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static List<Product> products = <Product>[];
  static const String routeName = '/menu';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const MenuScreen(),
        settings: const RouteSettings(name: routeName));
  }

  Container _buildProducts(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).backgroundColor,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Products", style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 20.0),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              } else if (state is ProductLoaded) {
                return ReorderableListView(
                    shrinkWrap: true,
                    children: [
                      for (int index = 0;
                          index < state.products.length;
                          index++)
                        ProductListTile(
                          product: state.products[index],
                          onTap: () {},
                          key: ValueKey(state.products[index].id),
                        )
                    ],
                    onReorder: (oldIndex, newIndex) {
                      context.read<ProductBloc>().add(
                          SortProducts(oldIndex: oldIndex, newIndex: newIndex));
                    });
              }
              return const Center(
                child: Text("Something went wrong!"),
              );
            },
          )
        ],
      ),
    );
  }

  Container _buildCategories(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxHeight: 400),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).backgroundColor),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Categories", style: Theme.of(context).textTheme.headline4),
            const SizedBox(
              height: 20.0,
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                } else if (state is CategoryLoaded) {
                  return ReorderableListView(
                      shrinkWrap: true,
                      children: [
                        for (int index = 0;
                            index < state.categories!.length;
                            index++)
                          CategoryListTile(
                            category: state.categories![index],
                            onTap: () {
                              context.read<CategoryBloc>().add(SelectCategory(
                                  state.categories![index], products));
                            },
                            key: ValueKey(state.categories![index].id),
                          )
                      ],
                      onReorder: (oldIndex, newIndex) {
                        context.read<CategoryBloc>().add(SortCategories(
                            oldIndex: oldIndex, newIndex: newIndex));
                      });
                }
                return const Center(
                  child: Text("Something went wrong!"),
                );
              },
            )
          ],
        ));
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
                    const SizedBox(height: 20.0),
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        }
                        if (state is ProductLoaded) {
                          products = state.products;
                          return SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.products.length + 1,
                                itemBuilder: (context, index) {
                                  return (index == 0)
                                      ? const AddProductCard()
                                      : ProductCard(
                                          product: state.products[index - 1],
                                        );
                                }),
                          );
                        }
                        return const Center(
                            child: Text("Something went wrong!"));
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Responsive.isWideDesktop(context) ||
                            Responsive.isDesktop(context)
                        ? Container(
                            constraints: const BoxConstraints(
                                minHeight: 300, maxHeight: 1000),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _buildCategories(context)),
                                const SizedBox(width: 10.0),
                                Expanded(
                                    child: SingleChildScrollView(
                                        child: _buildProducts(context)))
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              _buildCategories(context),
                              const SizedBox(height: 20.0),
                              SingleChildScrollView(
                                  child: _buildProducts(context))
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
                    color: Theme.of(context).backgroundColor,
                    child: const Center(child: Text("Advertisements")),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
