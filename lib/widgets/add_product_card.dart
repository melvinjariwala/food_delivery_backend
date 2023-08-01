// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_backend/blocs/category/category_bloc.dart';
import 'package:food_delivery_backend/blocs/product/product_bloc.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/widgets/custom_drop_down_button.dart';
import 'package:food_delivery_backend/widgets/custom_text_form_field.dart';

class AddProductCard extends StatelessWidget {
  const AddProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Product product = Product(
                          name: '',
                          restaurantId: 'RHh1BHaV4nGUCmINPM81',
                          category: '',
                          description: '',
                          imageUrl: '',
                          price: 0);
                      return Dialog(
                        child: Container(
                          height: 430,
                          width: 500,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              Text(
                                "Add Product",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 75,
                                    child: Text(
                                      'Category',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  BlocBuilder<CategoryBloc, CategoryState>(
                                    builder: (context, state) {
                                      if (state is CategoryLoaded) {
                                        return CustomDropDownButton(
                                          items: state.categories!
                                              .map((category) => category.name)
                                              .toList(),
                                          onChanged: (value) {
                                            product = product.copyWith(
                                                category: value);
                                            print('Product : $product');
                                          },
                                        );
                                      }
                                      return const Center(
                                        child: Text("Something went wrong"),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              CustomTextFormField(
                                  maxLines: 1,
                                  title: 'Name',
                                  hasTitle: true,
                                  initialValue: '',
                                  onChanged: (value) {
                                    product = product.copyWith(name: value);
                                  }),
                              const SizedBox(width: 20.0),
                              CustomTextFormField(
                                  maxLines: 1,
                                  title: 'Image',
                                  hasTitle: true,
                                  initialValue: '',
                                  onChanged: (value) {
                                    product = product.copyWith(imageUrl: value);
                                  }),
                              const SizedBox(width: 20.0),
                              CustomTextFormField(
                                  maxLines: 1,
                                  title: 'Price',
                                  hasTitle: true,
                                  initialValue: '',
                                  onChanged: (value) {
                                    product = product.copyWith(
                                        price: double.parse(value));
                                  }),
                              const SizedBox(width: 20.0),
                              CustomTextFormField(
                                  maxLines: 3,
                                  title: 'Description',
                                  hasTitle: true,
                                  initialValue: '',
                                  onChanged: (value) {
                                    product =
                                        product.copyWith(description: value);
                                  }),
                              const SizedBox(width: 50.0),
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ProductBloc>(context)
                                        .add(AddProducts(product: product));
                                    print('Product : $product');
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Save',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ))
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.add_circle,
                  size: 30, color: Theme.of(context).primaryColor)),
          const SizedBox(height: 10.0),
          Text("Add Product", style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }
}
