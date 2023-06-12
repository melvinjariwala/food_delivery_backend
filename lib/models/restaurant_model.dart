// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:food_delivery_backend/models/category_model.dart';
import 'package:food_delivery_backend/models/opening_hours_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';

class Restaurant extends Equatable {
  final String? id;
  final String? name;
  final String? imgUrl;
  final String? description;
  final List<String>? tags;
  final List<Category>? categories;
  final List<Product>? products;
  final List<OpeningHours>? openingHours;

  const Restaurant(
      {this.id,
      this.name,
      this.imgUrl,
      this.description,
      this.tags,
      this.categories,
      this.products,
      this.openingHours});

  @override
  List<Object?> get props =>
      [id, name, imgUrl, description, tags, categories, products, openingHours];

  Restaurant copyWith({
    String? id,
    String? name,
    String? imgUrl,
    String? description,
    List<String>? tags,
    List<Category>? categories,
    List<Product>? products,
    List<OpeningHours>? openingHours,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      openingHours: openingHours ?? this.openingHours,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id ?? '',
      'name': name ?? '',
      'imgUrl': imgUrl ?? '',
      'description': description ?? '',
      'tags': tags ?? [],
      'categories': categories!.map((category) {
        return category.toDocument();
      }).toList(),
      'products': products!.map((product) {
        return product.toDocument();
      }).toList(),
      'openingHours': openingHours!.map((openingHour) {
        return openingHour.toDocument();
      }).toList(),
    };
  }

  factory Restaurant.fromSnapshot(DocumentSnapshot snap) {
    return Restaurant(
        id: snap['id'].toString(),
        name: snap['name'],
        imgUrl: snap['imgUrl'],
        description: snap['description'],
        tags: (snap['tags'] as List).map((tag) {
          return tag as String;
        }).toList(),
        categories: (snap['categories'] as List).map((category) {
          return Category.fromSnapshot(category);
        }).toList(),
        products: (snap['products'] as List).map((product) {
          return Product.fromSnapshot(product);
        }).toList(),
        openingHours: (snap['openingHours'] as List).map((openingHour) {
          return OpeningHours.fromSnapshot(openingHour);
        }).toList());
  }

  static List<Restaurant> restaurants = [
    Restaurant(
      id: '1',
      name: 'Golden Ice Gelato Artigianale',
      imgUrl:
          'https://images.unsplash.com/photo-1479044769763-c28e05b5baa5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      description: 'This is the description.',
      tags: const ['italian', 'desserts'],
      categories: Category.categories,
      products: Product.products,
      openingHours: OpeningHours.openingHoursList,
    ),
  ];
}
