abstract class AppLoginStates{}

class AppLoginInitialState extends AppLoginStates{}

class AppLoginLoadingState extends AppLoginStates{}
class AppLoginSuccessState extends AppLoginStates{
  final String token;
  final String checkProfileImage;

  AppLoginSuccessState({required this.checkProfileImage, required this.token});
}
class AppLoginErrorState extends AppLoginStates {
  final String error;

  AppLoginErrorState({required this.error});
}

class AppLoginChangePasswordVisibilityState extends AppLoginStates{}
class AppLoginRememberMeState extends AppLoginStates{}