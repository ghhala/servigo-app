import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.light)) {
    on<ThemeToggled>((event, emit) {
      final nextMode = state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
      emit(ThemeState(themeMode: nextMode));
    });
  }
}
