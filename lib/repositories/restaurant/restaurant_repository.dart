import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_backend/models/restaurant_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/models/opening_hours_model.dart';
import 'package:food_delivery_backend/repositories/restaurant/base_restaurant_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RestaurantRepository extends BaseRestaurantRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth = FirebaseAuth.instance;

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
    // await _firebaseFirestore
    //     .collection('restaurants')
    //     .doc('RHh1BHaV4nGUCmINPM81')
    //     .update({
    //   'products': products.map((product) {
    //     return product.toDocument();
    //   }).toList()
    // });
    final userId = auth.currentUser!.uid;
    final querySnapshot = await _firebaseFirestore
        .collection('restaurants')
        .where('user.id', isEqualTo: userId)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final restaurantDoc = querySnapshot.docs.first;
      await restaurantDoc.reference.update({
        'products': products.map((product) {
          return product.toDocument();
        })
      });
    }
  }

  @override
  Future<void> editRestaurantOpeningHours(
      List<OpeningHours> opeiningHours) async {
    // await _firebaseFirestore
    //     .collection('restaurants')
    //     .doc('RHh1BHaV4nGUCmINPM81')
    //     .update({
    //   'openingHours': opeiningHours.map((openingHour) {
    //     return openingHour.toDocument();
    //   }).toList()
    // });
    final userId = auth.currentUser!.uid;
    final querySnapshot = await _firebaseFirestore
        .collection('restaurants')
        .where('user.id', isEqualTo: userId)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final restaurantDoc = querySnapshot.docs.first;
      await restaurantDoc.reference.update({
        'openingHours': opeiningHours.map((openingHour) {
          return openingHour.toDocument();
        })
      });
    }
  }

  @override
  Future<void> editRestaurntSettings(Restaurant restaurant) async {
    // await _firebaseFirestore
    //     .collection('restaurants')
    //     .where('user.id', isEqualTo: auth.currentUser!.uid)
    //     .get()
    //     .then((value) => value.docs.forEach((doc) {
    //           doc.reference.update(restaurant.toDocument());
    //         }));
    // .doc('RHh1BHaV4nGUCmINPM81')
    // .update(restaurant.toDocument());
    final userId = auth.currentUser!.uid;
    final querySnapshot = await _firebaseFirestore
        .collection('restaurants')
        .where('user.id', isEqualTo: userId)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final restaurantDoc = querySnapshot.docs.first;
      await restaurantDoc.reference.update(restaurant.toDocument());
    }
  }

  @override
  Stream<Restaurant> getRestaurant() {
    print("auth.currentUser!.uid : ${auth.currentUser!.uid}");
    return _firebaseFirestore
        .collection('restaurants')
        .where('user.id', isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return Restaurant.fromSnapshot(snapshot.docs.first);
      } else {
        return Restaurant.empty;
      }
    });
  }
}
