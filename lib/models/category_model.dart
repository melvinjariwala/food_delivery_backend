import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int index;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.index,
  });

  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    int? index,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'index': index
    };
  }

  factory Category.fromSnapshot(Map<String, dynamic> snap) {
    return Category(
      id: snap['id'].toString(),
      name: snap['name'],
      description: snap['description'],
      imageUrl: snap['imageUrl'],
      index: snap['index'],
    );
  }

  @override
  List<Object> get props => [id, name, description, imageUrl, index];

  static List<Category> categories = const [
    Category(
      id: '1',
      name: 'Salads',
      description:
          'Refreshing and wholesome greens, tossed with vibrant ingredients, offering a burst of natural flavors.',
      imageUrl: 'assets/images/avocado.png',
      index: 0,
    ),
    Category(
      id: '2',
      name: 'Drinks',
      description:
          'An oasis of quenching elixirs, from refreshing beverages to luxurious libations.',
      imageUrl: 'assets/images/juice.png',
      index: 1,
    ),
    Category(
      id: '3',
      name: 'Desserts',
      description:
          'Decadent and indulgent creations, satisfying sweet cravings with a delightful array of treats.',
      imageUrl: 'assets/images/pancake.png',
      index: 2,
    ),
    Category(
      id: '4',
      name: 'Pizza',
      description:
          'A heavenly fusion of fresh ingredients, baked to perfection on a delectable crust.',
      imageUrl: 'assets/images/pizza.png',
      index: 3,
    ),
    Category(
      id: '5',
      name: 'Burgers',
      description:
          'Juicy and succulent patties, layered with savory toppings, creating a symphony of flavors.',
      imageUrl: 'assets/images/burger.png',
      index: 4,
    ),
  ];
}
