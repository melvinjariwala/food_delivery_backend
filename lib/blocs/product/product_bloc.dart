// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_backend/blocs/category/category_bloc.dart';
import 'package:food_delivery_backend/models/category_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/repositories/restaurant/restaurant_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final RestaurantRepository _restaurantRepository;
  final CategoryBloc _categoryBloc;
  StreamSubscription? _restaurantSubscription;
  StreamSubscription? _categorySubscription;
  ProductBloc(
      {required CategoryBloc categoryBloc,
      required RestaurantRepository restaurantRepository})
      : _categoryBloc = categoryBloc,
        _restaurantRepository = restaurantRepository,
        super(ProductLoading()) {
    on<LoadProducts>(loadProducts);
    on<FilterProducts>(updateProducts);
    on<SortProducts>(sortProducts);
    on<AddProducts>(addProducts);

    _categorySubscription = _categoryBloc.stream.listen((state) {
      if (state is CategoryLoaded && state.selectedCategory != null) {
        add(FilterProducts(category: state.selectedCategory!));
      }
    });

    _restaurantSubscription =
        _restaurantRepository.getRestaurant().listen((restaurant) {
      add(LoadProducts(products: restaurant.products!));
    });
  }

  FutureOr<void> loadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    Future<void>.delayed(const Duration(seconds: 1));
    emit(ProductLoaded(products: event.products));
  }

  FutureOr<void> updateProducts(
      FilterProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    await Future<void>.delayed(const Duration(seconds: 1));
    List<Product> filteredProducts = Product.products
        .where((product) => product.category == event.category.name)
        .toList();
    emit(ProductLoaded(products: filteredProducts));
  }

  FutureOr<void> sortProducts(
      SortProducts event, Emitter<ProductState> emit) async {
    final state = this.state as ProductLoaded;
    emit(ProductLoading());
    await Future<void>.delayed(const Duration(seconds: 1));
    int newIndex =
        (event.newIndex > event.oldIndex) ? event.newIndex - 1 : event.newIndex;
    try {
      Product selectedProduct = state.products[event.oldIndex];
      List<Product> sortedProducts = List.from(state.products)
        ..remove(selectedProduct)
        ..insert(newIndex, selectedProduct);
      emit(ProductLoaded(products: sortedProducts));
    } catch (e) {
      print("Error in sortProducts : $e");
    }
  }

  FutureOr<void> addProducts(
      AddProducts event, Emitter<ProductState> emit) async {
    List<Product> newProducts = List.from((state as ProductLoaded).products)
      ..add(event.product);

    _restaurantRepository.editProducts(newProducts);

    if (state is ProductLoaded) {
      emit(ProductLoaded(products: newProducts));
    }
  }

  @override
  Future<void> close() async {
    _restaurantSubscription?.cancel();
    _categorySubscription?.cancel();
    super.close();
  }
}
