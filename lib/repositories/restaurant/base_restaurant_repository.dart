import 'package:food_delivery_backend/models/opening_hours_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/models/restaurant_model.dart';

abstract class BaseRestaurantRepository {
  Future<void> addRestaurant(Restaurant restaurant);
  Future<void> editRestaurntSettings(Restaurant restaurant);
  Future<void> editRestaurantOpeningHours(List<OpeningHours> opeiningHours);
  Future<void> editProducts(List<Product> products);

  Stream<Restaurant> getRestaurant();
}
