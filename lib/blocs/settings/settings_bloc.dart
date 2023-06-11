// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_backend/models/opening_hours_model.dart';
import 'package:food_delivery_backend/models/restaurant_model.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsLoading()) {
    on<LoadSettings>(loadSettings);
    on<UpdateSettings>(updateSettings);
    on<UpdateOpeningHours>(updateOpeningHours);
  }

  FutureOr<void> loadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(SettingsLoaded(event.restaurant));
  }

  FutureOr<void> updateSettings(
      UpdateSettings event, Emitter<SettingsState> emit) {
    emit(SettingsLoaded(event.restaurant));
  }

  FutureOr<void> updateOpeningHours(
      UpdateOpeningHours event, Emitter<SettingsState> emit) {
    final state = this.state;
    if (state is SettingsLoaded) {
      final List<OpeningHours> openingHoursList =
          state.restaurant.openingHours!.map((openingHours) {
        return (openingHours.id == event.openingHours.id)
            ? event.openingHours
            : openingHours;
      }).toList();

      emit(SettingsLoaded(
          state.restaurant.copyWith(openingHours: openingHoursList)));
    }
  }
}
