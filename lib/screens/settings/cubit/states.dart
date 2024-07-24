import 'dart:ui';

abstract class AppSettingsStates {

}

class AppSettingsInitialState extends AppSettingsStates {
}



class AppSettingsUpdatePasswordLoadingState extends AppSettingsStates{}

class ChangePasswordVisibilityState extends AppSettingsStates{}


class AppSettingsLogoutLoadingState extends AppSettingsStates{}
class AppSettingsLogoutSuccessState extends AppSettingsStates{}
class AppSettingsLogoutErrorState extends AppSettingsStates {
  final String error;

  AppSettingsLogoutErrorState({required this.error});
}

class AppSettingsLangChangeState extends AppSettingsStates {}

