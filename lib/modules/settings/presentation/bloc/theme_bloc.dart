import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: ThemeData.light())) {
    on<ThemeChanged>((event, emit) {
      emit(ThemeState(themeData: event.isDark ? ThemeData.dark() : ThemeData.light()));
    });
  }
}
