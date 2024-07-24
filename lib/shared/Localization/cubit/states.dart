import 'dart:ui';

abstract class AppLocaleStates{}

class AppLocaleInitialState extends AppLocaleStates{}


class AppLocaleChangeLocaleState extends AppLocaleStates {
  final Locale locale;

  AppLocaleChangeLocaleState({required this.locale});
}