abstract class AppSignUpStates{}

class AppSignUpInitialState extends AppSignUpStates{}

class AppSignUpLoadingState extends AppSignUpStates{}
class AppSignUpSuccessState extends AppSignUpStates{
  final String token;

  AppSignUpSuccessState(this.token);
}
class AppSignUpErrorState extends AppSignUpStates {
  final String error;

  AppSignUpErrorState({required this.error});
}

class AppSignUpChangePasswordVisibilityState extends AppSignUpStates{}

class AppSignUpRememberMeState extends AppSignUpStates{}


class AppSignUpGenderSelectionState extends AppSignUpStates{}



class AppSignUpGetCategoriesNameLoadingState extends AppSignUpStates{}
class AppSignUpGetCategoriesNameSuccessState extends AppSignUpStates{}
class AppSignUpGetCategoriesNameErrorState extends AppSignUpStates {
  final String error;

  AppSignUpGetCategoriesNameErrorState({required this.error});
}

class AppSignUpSelectDropDownItemState extends AppSignUpStates{}

