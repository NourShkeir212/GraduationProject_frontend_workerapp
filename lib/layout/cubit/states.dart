abstract class AppLayoutStates {}

class AppLayoutInitialState extends AppLayoutStates{}

class AppLayoutBottomNavBarChangeStates extends AppLayoutStates{}

class AppLayoutGetProfileSuccessState extends AppLayoutStates{}
class AppLayoutGetProfileLoadingState extends AppLayoutStates{}
class AppLayoutGetProfileErrorState extends AppLayoutStates{
  final String error;

  AppLayoutGetProfileErrorState({required this.error});
}