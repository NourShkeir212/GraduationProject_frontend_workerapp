import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/model/reviews_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/profile_model.dart';
import '../../../shared/constants/consts.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/var/var.dart';
import 'profile_lib.dart';

class AppProfileCubit extends Cubit<AppProfileStates> {
  AppProfileCubit() : super(AppProfileInitialState());

  static AppProfileCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel;
  ReviewsModel? reviewsModel;

 void getReviews() async {
    try {
      emit(AppProfileGetReviewsLoadingState());
      var response = await DioHelper.get(
        url: AppConstant.GET_REVIEWS,
        token: token,
      );
      if (response.statusCode == 200) {
        reviewsModel = ReviewsModel.fromJson(response.data);
        emit(AppProfileGetReviewsSuccessState());
      }
    } catch (error) {
      emit(AppProfileGetReviewsErrorState(error: error.toString()));
    }
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String startTime,
    required String endTime,
    required BuildContext context,
  }) async {
    try {
      emit(AppUpdateProfileLoadingState());
      var response = await DioHelper.patch(
          url: AppConstant.UPDATE_PROFILE,
          token: token,
          data: {
            'name':name,
            'email': email,
            'phone': phone,
            'address': address,
            'start_time': startTime,
            'end_time' :endTime,
          }
      );
      if (response?.statusCode == 200) {
        profileModel = ProfileModel.fromJson(response!.data);
        emit(AppUpdateProfileSuccessState());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (e is DioException) {
        // This is a DioError, let's handle it
        var errorData = e.response?.data;
        var basicError = errorData['error'] ?? '';
        var nameError = errorData['name']?.join(' ') ?? '';
        var emailError = errorData['email']?.join(' ') ?? '';
        var phoneError = errorData['phone']?.join(' ') ?? '';
        var addressError = errorData['address']?.join(' ') ?? '';
        var errorMessage = '$nameError $emailError $phoneError $addressError $basicError'
            .trim();
        emit(AppUpdateProfileErrorState(error: errorMessage));
      } else {
        // This is not a DioError
        emit(AppUpdateProfileErrorState(error: e.toString()));
      }
    }
  }

  Color? availableButton;
 int? availability;

  void getProfile(bool isDark) async {
    try {
      emit(AppGetProfileLoadingState());
      var response = await DioHelper.get(
          url: AppConstant.PROFILE,
          token: token
      );
      if (response.statusCode == 200) {
        profileModel = ProfileModel.fromJson(response.data);
        availableButton = profileModel!.data!.availability == 1 ?
        isDark ? AppColors.darkMainGreenColor : AppColors.lightMainGreenColor :
        isDark ? AppColors.darkRedColor : AppColors.lightRedColor;
        availability = profileModel!.data!.availability;
        emit(AppGetProfileSuccessState());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (e is DioException) {
        // This is a DioError, let's handle it
        var errorData = e.response?.data;
        var error = errorData['message'] ?? '';
        var errorMessage = '$error'.trim();
        emit(AppGetProfileErrorState(error: errorMessage));
      } else {
        emit(AppGetProfileErrorState(error: e.toString()));
      }
    }
  }

 bool isRed = true;


  _switch(bool isDark) {
    isRed = !isRed;
    availability = isRed ? 0 : 1;
    availableButton = isRed ?
    isDark ? AppColors.darkRedColor : AppColors.lightRedColor : isDark ? AppColors.darkMainGreenColor : AppColors.lightMainGreenColor;
    emit(AppProfileChangeAvailableContainerColorState());
  }

changeAvailability(isDark)async {
  try {
    _switch(isDark);
    emit(AppProfileChangeAvailableLoadingState());
    var response = await DioHelper.patch(
      url: AppConstant.UPDATE_PROFILE,
      data: {
        'availability': availability,
        'name': profileModel!.data!.name,
      },
      token: token,
    );
    if (response!.statusCode == 200) {
      emit(AppProfileChangeAvailableSuccessState());
    }
  } catch (error) {
    print(error.toString());
    emit(AppProfileChangeAvailableErrorState(error: error.toString()));
  }
}



  XFile? imageFile;

  void _updateProfileImage(File imageFile) async {
    FormData formData = FormData.fromMap({
      "profile_image": await MultipartFile.fromFile(imageFile.path),
    });

    try {
      emit(AppProfileUpdateProfileImageLoadingState());
      var response = await DioHelper.post(
          url: AppConstant.UPDATE_PROFILE_IMAGE,
          isProfileImage: true,
          formData: formData,
          token: token
      );
      if (response!.statusCode == 200) {
        response.data['data']['profile_image'];
        emit(AppProfileUpdateProfileImageSuccessState(imageUrl: response.data['data']['profile_image']));
      }
    } catch (e) {
      emit(AppProfileUpdateProfileImageErrorState(error: e.toString()));
      print(e.toString());
    }
  }

  Future<void> updateProfileImage() async {
    final ImagePicker _picker = ImagePicker();

    imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      // If an image is picked successfully, upload it to the server
      _updateProfileImage(File(imageFile!.path));
    } else {
      print('No image selected.');
    }
  }
}

