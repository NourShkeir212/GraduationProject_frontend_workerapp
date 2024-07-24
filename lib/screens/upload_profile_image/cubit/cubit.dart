import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/shared/network/local/cache_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/constants/consts.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/var/var.dart';
import 'states.dart';


class AppUploadProfileImageCubit extends Cubit<AppUploadProfileImageStates> {

  AppUploadProfileImageCubit() : super(AppUploadProfileImageInitialState());

  static AppUploadProfileImageCubit get(context) => BlocProvider.of(context);

  String profileImage = "";

  void _uploadProfileImage(File imageFile) async {
    FormData formData = FormData.fromMap({
      "profile_image": await MultipartFile.fromFile(imageFile.path),
    });

    try {
      emit(AppUploadProfileImageLoadingState());
      var response = await DioHelper.post(
          url: AppConstant.UPLOAD_PROFILE_IMAGE,
          isProfileImage: true,
          formData: formData,
          token: token
      );
      if (response!.statusCode == 201) {
        profileImage = response.data['data']['profile_image'];
        emit(AppUploadProfileImageSuccessState(
            imageUrl: response.data['data']['profile_image']));
      }
    } catch (e) {
      emit(AppUploadProfileImageErrorState(error: e.toString()));
      print(e.toString());
    }
  }


  void _updateProfileImage(File imageFile) async {
    FormData formData = FormData.fromMap({
      "profile_image": await MultipartFile.fromFile(imageFile.path),
    });

    try {
      emit(AppUpdateProfileImageLoadingState());
      var response = await DioHelper.post(
          url: AppConstant.UPDATE_PROFILE_IMAGE,
          isProfileImage: true,
          formData: formData,
          token: token
      );
      if (response!.statusCode == 200) {
        response.data['data']['profile_image'];
        profileImage = response.data['data']['profile_image'];
        emit(AppUpdateProfileImageSuccessState(imageUrl: response.data['data']['profile_image']));
      }
    } catch (e) {
      emit(AppUpdateProfileImageErrorState(error: e.toString()));
      print(e.toString());
    }
  }

  XFile? imageFile;

  Future<void> selectAndUploadImage() async {
    final ImagePicker picker = ImagePicker();

    imageFile = await picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      // If an image is picked successfully, upload it to the server
      if (profileImageUrl == "") {
        _uploadProfileImage(File(imageFile!.path));
      } else {
        _updateProfileImage(File(imageFile!.path));
      }
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

}