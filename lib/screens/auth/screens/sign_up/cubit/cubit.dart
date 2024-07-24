import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/screens/auth/screens/sign_up/cubit/states.dart';

import '../../../../../model/category_model.dart';
import '../../../../../shared/constants/consts.dart';
import '../../../../../shared/network/remote/dio_helper.dart';

class AppSignUpCubit extends Cubit<AppSignUpStates> {
  AppSignUpCubit() : super(AppSignUpInitialState());

  static AppSignUpCubit get(context) => BlocProvider.of(context);

  bool isRememberMe = false;

  void rememberMe() {
    isRememberMe = !isRememberMe;
    emit(AppSignUpRememberMeState());
  }


  void register({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String password,
    required String passwordConfirmation,
    required String category
  }) async {
    try {
      emit(AppSignUpLoadingState());
      var response = await DioHelper.post(
          url: AppConstant.REGISTER,
          data: {
            'name': name,
            'email': email,
            'phone': phone,
            'gender': gender,
            'password': password,
            'category': category,
            'password_confirmation': passwordConfirmation
          }
      );
      if (response!.statusCode == 201) {
        emit(AppSignUpSuccessState(response.data['data']['token']));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (e is DioException) {
        // This is a DioError, let's handle it
        var errorData = e.response?.data;
        var basicError = errorData['error'] ?? '';
        var emailError = errorData['email']?.join(' ') ?? '';
        var nameError = errorData['name']?.join(' ') ?? '';
        var passwordError = errorData['password']?.join(' ') ?? '';
        var phoneError = errorData['phone']?.join(' ') ?? '';
        var genderError = errorData['gender']?.join(' ') ?? '';
        var errorMessage = '$emailError $passwordError $basicError $nameError $phoneError $genderError'
            .trim();
        emit(AppSignUpErrorState(error: errorMessage));
      } else {
        // This is not a DioError
        emit(AppSignUpErrorState(error: e.toString()));
      }
    }
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  List<String> categoriesName = [];

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AppSignUpChangePasswordVisibilityState());
  }

  bool isMale = true;

  void gender() {
    isMale = !isMale;
    emit(AppSignUpGenderSelectionState());
  }

  CategoryModel categoryModel = CategoryModel();
  String dropDownItemValue = "";

  getCategories() async {
    try {
      emit(AppSignUpGetCategoriesNameLoadingState());
      var response = await DioHelper.get(url: AppConstant.GET_CATEGORIES_NAME);
      if (response.statusCode == 200) {
        categoryModel = CategoryModel.fromJson(response.data);
        emit(AppSignUpGetCategoriesNameSuccessState());
      }
    }
    catch (error) {
      emit(AppSignUpGetCategoriesNameErrorState(error: error.toString()));
    }
  }

  selectYourCategory(String value) {
    dropDownItemValue = value;
    emit(AppSignUpSelectDropDownItemState());
  }
}