abstract class AppDeleteAccountStates{}

class AppDeleteAccountInitialState extends AppDeleteAccountStates{}

class AppDeleteAccountLoadingState extends AppDeleteAccountStates{}
class AppDeleteAccountSuccessState extends AppDeleteAccountStates{}
class AppDeleteAccountErrorState extends AppDeleteAccountStates {
  final String error;

  AppDeleteAccountErrorState({required this.error});
}

class ChangePasswordVisibilityState extends AppDeleteAccountStates{}