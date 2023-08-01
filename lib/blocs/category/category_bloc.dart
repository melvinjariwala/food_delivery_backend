// ignore_for_file: avoid_print, depend_on_referenced_packages, unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_backend/models/category_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/repositories/restaurant/restaurant_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final RestaurantRepository _restaurantRepository;
  StreamSubscription? _restaurantSubscription;
  CategoryBloc({required RestaurantRepository restaurantRepository})
      : _restaurantRepository = restaurantRepository,
        super(CategoryLoading()) {
    on<LoadCategory>(loadCategory);
    on<SelectCategory>(selectCategory);
    on<SortCategories>(sortCategories);

    _restaurantSubscription =
        _restaurantRepository.getRestaurant().listen((restaurant) {
      add(LoadCategory(categories: restaurant.categories!));
    });
  }

  FutureOr<void> loadCategory(
      LoadCategory event, Emitter<CategoryState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(CategoryLoaded(categories: event.categories));
  }

  FutureOr<void> selectCategory(
      SelectCategory event, Emitter<CategoryState> emit) async {
    final state = this.state as CategoryLoaded;
    emit(CategoryLoaded(
        categories: state.categories, selectedCategory: event.category));
    //_productBloc.updateSelectedCategory(event.category);
  }

  FutureOr<void> sortCategories(
      SortCategories event, Emitter<CategoryState> emit) async {
    final state = this.state as CategoryLoaded;
    //emit(CategoryLoading());
    //await Future<void>.delayed(const Duration(seconds: 1));
    int newIndex =
        (event.newIndex > event.oldIndex) ? event.newIndex - 1 : event.newIndex;
    try {
      Category selectedCategory = state.categories![event.oldIndex];
      List<Category> sortedCategoriees = List.from(state.categories!)
        ..remove(selectedCategory)
        ..insert(newIndex, selectedCategory);
      emit(CategoryLoaded(categories: sortedCategoriees));
    } catch (e) {
      print("Error in sortCategories : $e");
    }
  }
}
