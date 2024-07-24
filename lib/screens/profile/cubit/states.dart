abstract class AppProfileStates {}

class AppProfileInitialState extends AppProfileStates{}
class AppGetProfileLoadingState extends AppProfileStates{}
class AppGetProfileSuccessState extends AppProfileStates{}
class AppGetProfileErrorState extends AppProfileStates
{
  final String error;
  AppGetProfileErrorState({required this.error});
}


class AppUpdateProfileLoadingState extends AppProfileStates{}
class AppUpdateProfileSuccessState extends AppProfileStates{}
class AppUpdateProfileErrorState extends AppProfileStates {
  final String error;

  AppUpdateProfileErrorState({required this.error});
}


class AppProfileUpdateProfileImageLoadingState extends AppProfileStates{}
class AppProfileUpdateProfileImageSuccessState extends AppProfileStates{
  final String imageUrl;

  AppProfileUpdateProfileImageSuccessState({required this.imageUrl});
}
class AppProfileUpdateProfileImageErrorState extends AppProfileStates {
  final String error;

  AppProfileUpdateProfileImageErrorState({required this.error});
}



class AppProfileGetReviewsLoadingState extends AppProfileStates{}
class AppProfileGetReviewsSuccessState extends AppProfileStates{}
class AppProfileGetReviewsErrorState extends AppProfileStates{
  final String error;

  AppProfileGetReviewsErrorState({required this.error});
}

class AppProfileChangeAvailableContainerColorState extends AppProfileStates{}

class AppProfileChangeAvailableLoadingState extends AppProfileStates{}
class AppProfileChangeAvailableSuccessState extends AppProfileStates{}
class AppProfileChangeAvailableErrorState extends AppProfileStates{
  final String error;

  AppProfileChangeAvailableErrorState({required this.error});
}