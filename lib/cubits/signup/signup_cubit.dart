import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_backend/models/category_model.dart';
import 'package:food_delivery_backend/models/opening_hours_model.dart';
import 'package:food_delivery_backend/models/product_model.dart';
import 'package:food_delivery_backend/models/restaurant_model.dart';
import 'package:food_delivery_backend/models/user_model.dart' as Owner;
import 'package:food_delivery_backend/repositories/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_backend/repositories/restaurant/restaurant_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationRepository _authenticationRepository;
  final RestaurantRepository _restaurantRepository;
  SignupCubit(this._authenticationRepository, this._restaurantRepository)
      : super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  Future<void> signupFormSubmitted() async {
    if (state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));

    try {
      await _authenticationRepository.signUp(
          email: state.email, password: state.password);

      final auth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;
      final user = auth.currentUser;

      if (user != null) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .set({'email': state.email, 'id': user.uid, 'name': "Owner"});
        final restaurant = Restaurant(
            id: '',
            name: '',
            imgUrl: '',
            description: '',
            user: Owner.User(id: user.uid, email: user.email, name: "Owner"),
            tags: [],
            categories: Category.categories,
            products: <Product>[],
            openingHours: OpeningHours.openingHoursList);

        await _restaurantRepository.addRestaurant(restaurant);
        print("restaurant after signup : $restaurant");
      }
      emit(state.copyWith(status: SignupStatus.success));
    } catch (e) {
      print("Error in signupFormSubmitted : $e");
      emit(state.copyWith(status: SignupStatus.error));
    }
  }
}
