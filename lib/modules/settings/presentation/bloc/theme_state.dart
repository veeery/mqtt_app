part of 'theme_bloc.dart';

class ThemeInitial extends Equatable {
  const ThemeInitial();

  @override
  List<Object> get props => [];
}

class ThemeState extends Equatable {
  final ThemeData themeData;

  const ThemeState({required this.themeData});

  @override
  List<Object> get props => [themeData];
}