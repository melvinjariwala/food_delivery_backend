import 'package:flutter/material.dart';
import 'package:food_delivery_backend/models/category_model.dart';

class CategoryListTile extends StatelessWidget {
  final Category category;
  final Function()? onTap;
  const CategoryListTile(
      {Key? key, required this.category, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(category.imageUrl, height: 25.0),
      title: Text(category.name, style: Theme.of(context).textTheme.headline5),
      subtitle: Text(category.description,
          style: Theme.of(context).textTheme.headline6),
    );
  }
}
