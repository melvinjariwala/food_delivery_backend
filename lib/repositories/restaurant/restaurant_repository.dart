import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_backend/models/restaurant_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/models/opening_hours_model.dart';
import 'package:food_delivery_backend/repositories/restaurant/base_restaurant_repository.dart';

class RestaurantRepository extends BaseRestaurantRepository {
  final FirebaseFirestore _firebaseFirestore;

  RestaurantRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> addRestaurant(Restaurant restaurant) async {
    await _firebaseFirestore
        .collection('restaurants')
        .add(restaurant.toDocument());
  }

  @override
  Future<void> editProducts(List<Product> products) async {
    await _firebaseFirestore
        .collection('restaurants')
        .doc('RHh1BHaV4nGUCmINPM81')
        .update({
      'products': products.map((product) {
        return product.toDocument();
      }).toList()
    });
  }

  @override
  Future<void> editRestaurantOpeningHours(
      List<OpeningHours> opeiningHours) async {
    await _firebaseFirestore
        .collection('restaurants')
        .doc('RHh1BHaV4nGUCmINPM81')
        .update({
      'openingHours': opeiningHours.map((openingHour) {
        return openingHour.toDocument();
      }).toList()
    });
  }

  @override
  Future<void> editRestaurntSettings(Restaurant restaurant) async {
    await _firebaseFirestore
        .collection('restaurants')
        .doc('RHh1BHaV4nGUCmINPM81')
        .update(restaurant.toDocument());
  }

  @override
  Stream<Restaurant> getRestaurant() {
    return _firebaseFirestore
        .collection('restaurants')
        .doc('RHh1BHaV4nGUCmINPM81')
        .snapshots()
        .map((snapshot) {
      return Restaurant.fromSnapshot(snapshot);
    });
  }
}
