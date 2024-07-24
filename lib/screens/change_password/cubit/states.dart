abstract class AppChangePasswordStates{}

class AppChangePasswordInitialStates extends AppChangePasswordStates{}

class AppChangePasswordLoadingStates extends AppChangePasswordStates{}
class AppChangePasswordSuccessStates extends AppChangePasswordStates{}
class AppChangePasswordErrorStates extends AppChangePasswordStates
{
  final String error;

  AppChangePasswordErrorStates({required this.error});
}

class ChangePasswordVisibilityState extends AppChangePasswordStates{}