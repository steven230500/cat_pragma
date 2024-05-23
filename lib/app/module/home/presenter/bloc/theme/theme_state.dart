part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  final ThemeData themeData;
  final ThemeMode themeMode;

  const ThemeState({required this.themeData, required this.themeMode});

  @override
  List<Object> get props => [themeData];
}

class ThemeInitial extends ThemeState {
  ThemeInitial() : super(themeData: ThemeData.light(), themeMode: ThemeMode.light);
}

class ThemeDataChanged extends ThemeState {
  const ThemeDataChanged({required super.themeData, required super.themeMode});
}
