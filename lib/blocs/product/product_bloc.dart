// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_backend/blocs/category/category_bloc.dart';
import 'package:food_delivery_backend/models/category_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CategoryBloc _categoryBloc;
  StreamSubscription? _categorySubscription;
  ProductBloc({required CategoryBloc categoryBloc})
      : _categoryBloc = categoryBloc,
        super(ProductLoading()) {
    on<LoadProducts>(loadProducts);
    on<UpdateProducts>(updateProducts);
    on<SortProducts>(sortProducts);
    on<AddProducts>(addProducts);

    _categorySubscription = _categoryBloc.stream.listen((state) {
      if (state is CategoryLoaded && state.selectedCategory != null) {
        add(UpdateProducts(category: state.selectedCategory!));
      }
    });
  }

  FutureOr<void> loadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    Future<void>.delayed(const Duration(seconds: 1));
    emit(ProductLoaded(products: event.products));
  }

  FutureOr<void> updateProducts(
      UpdateProducts event, Emitter<ProductState> emit) async {
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
    if (state is ProductLoaded) {
      emit(ProductLoaded(
          products: List.from((state as ProductLoaded).products)
            ..add(event.product)));
    }
  }
}
