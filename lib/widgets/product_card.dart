// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_delivery_backend/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(product.imageUrl),
          ),
          Text(product.name, style: Theme.of(context).textTheme.headline5),
          Text('\$${product.price}',
              style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }
}
