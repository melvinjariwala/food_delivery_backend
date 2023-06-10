import 'package:flutter/material.dart';
import 'package:food_delivery_backend/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.index});

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: (index == 0)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle,
                        size: 30, color: Theme.of(context).primaryColor)),
                Text("Add Product",
                    style: Theme.of(context).textTheme.headline5),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(product.imageUrl),
                ),
                Text(product.name,
                    style: Theme.of(context).textTheme.headline5),
                Text('\$${product.price}',
                    style: Theme.of(context).textTheme.headline6),
              ],
            ),
    );
  }
}
