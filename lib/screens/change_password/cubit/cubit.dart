import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constants/consts.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/var/var.dart';
import 'change_password_lib.dart';

class AppChangePasswordCubit extends Cubit<AppChangePasswordStates> {

  AppChangePasswordCubit() : super(AppChangePasswordInitialStates());

  static AppChangePasswordCubit get(context) => BlocProvider.of(context);


  changePassword({
    required oldPassword,
    required newPassword,
    required newConfirmationPassword,
  }) async {
    try {
      emit(AppChangePasswordLoadingStates());
      var response = await DioHelper.patch(
          url: AppConstant.CHANGE_PASSWORD,
          data: {
            'old_password': oldPassword,
            'new_password': newPassword,
            'new_password_confirmation': newConfirmationPassword
          },
          token: token
      );
      if (response!.statusCode == 200) {
        emit(AppChangePasswordSuccessStates());
      }
    } catch (e) {
      if (e is DioException) {
        // This is a DioError, let's handle it
        var errorData = e.response?.data;
        var basicError = errorData['message'] ?? '';
        var oldPasswordError = errorData['old_password']?.join(' ') ?? '';
        var newPasswordError = errorData['new_password']?.join(' ') ?? '';
        var errorMessage = '$oldPasswordError  $basicError $newPasswordError'
            .trim();
        emit(AppChangePasswordErrorStates(error: errorMessage));
        print(errorMessage);
      }
      else {
        emit(AppChangePasswordErrorStates(error: e.toString()));
      }
    }
  }


  IconData suffixOld = Icons.visibility_outlined;
  IconData suffixNew = Icons.visibility_outlined;
  IconData suffixNewConfirmation = Icons.visibility_outlined;
  bool isOldPassword = true;
  bool isNewPassword = true;
  bool isNewConfirmationPassword = true;

  void changePasswordVisibility({required String type}) {
    if (type == "oldPassword") {
      isOldPassword = !isOldPassword;
      suffixOld =
      isOldPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
      emit(ChangePasswordVisibilityState());
    }
    if (type == "newPassword") {
      isNewPassword = !isNewPassword;
      suffixNew =
      isNewPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
      emit(ChangePasswordVisibilityState());
    }
    if (type == "NewConfirmationPassword") {
      isNewConfirmationPassword = !isNewConfirmationPassword;
      suffixNewConfirmation =
      isNewConfirmationPassword ? Icons.visibility_outlined : Icons
          .visibility_off_outlined;
      emit(ChangePasswordVisibilityState());
    }
  }

}