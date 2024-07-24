abstract class AppUploadProfileImageStates{}

class AppUploadProfileImageInitialState extends AppUploadProfileImageStates{}

class AppUploadProfileImageErrorState extends AppUploadProfileImageStates{
  final String error;

  AppUploadProfileImageErrorState({required this.error});
}
class AppUploadProfileImageLoadingState extends AppUploadProfileImageStates{}
class AppUploadProfileImageSuccessState extends AppUploadProfileImageStates{
  final String imageUrl;

  AppUploadProfileImageSuccessState({required this.imageUrl});
}

class AppUpdateProfileImageLoadingState extends AppUploadProfileImageStates{}
class AppUpdateProfileImageSuccessState extends AppUploadProfileImageStates{
  final String imageUrl;

  AppUpdateProfileImageSuccessState({required this.imageUrl});
}
class AppUpdateProfileImageErrorState extends AppUploadProfileImageStates{
  final String error;

  AppUpdateProfileImageErrorState({required this.error});
}