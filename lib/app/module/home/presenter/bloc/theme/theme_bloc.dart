import 'package:cat_pragma/app/core/utils/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final Preferences preferences;

  ThemeBloc({required this.preferences}) : super(ThemeInitial()) {
    on<ThemeChanged>((event, emit) async {
      preferences.isDarkMode = event.isDarkMode;
      final ThemeData updatedThemeData = event.isDarkMode ? _darkTheme : _lightTheme;
      emit(ThemeDataChanged(
          themeData: updatedThemeData,
          themeMode: event.isDarkMode ? ThemeMode.dark : ThemeMode.light));
    });

    on<InitTheme>((event, emit) async {
      await preferences.init();
      final isDarkMode = preferences.isDarkMode;
      final ThemeData initialThemeData = isDarkMode ? _darkTheme : _lightTheme;
      emit(ThemeDataChanged(
          themeData: initialThemeData, themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light));
    });
  }

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      surface: Colors.white,
      onSurface: Colors.black87,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
  );

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.blueGrey,
      surface: Color(0xFF121212),
      onSurface: Colors.white70,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );
}
