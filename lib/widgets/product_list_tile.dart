// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_delivery_backend/models/product_model.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  final Function()? onTap;
  const ProductListTile({Key? key, required this.product, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name, style: Theme.of(context).textTheme.headline5),
      subtitle: Text(product.description,
          style: Theme.of(context).textTheme.headline6),
    );
  }
}
