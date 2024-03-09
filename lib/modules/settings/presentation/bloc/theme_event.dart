part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final bool isDark;

  const ThemeChanged({required this.isDark});

  @override
  List<Object> get props => [isDark];
}