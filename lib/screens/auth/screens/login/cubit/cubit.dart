import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/constants/consts.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import 'states.dart';


class AppLoginCubit extends Cubit<AppLoginStates> {

  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);


  void login({
    required String email,
    required String password,
  }) async {
    try {
      emit(AppLoginLoadingState());
      var response = await DioHelper.post(
          url: AppConstant.LOGIN,
          data: {
            'email': email,
            'password': password
          }
      );
      if (response!.statusCode == 200) {
        String token = response.data['token'];
        String profileImage = response.data['data']['profile_image'] ?? "";
        emit(AppLoginSuccessState(
            token: token,
            //this checkProfile when the user logged in successfully we get the profileImage
            checkProfileImage: profileImage
        ),
        );
      }
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        // This is a DioError, let's handle it
        var errorData = e.response?.data;
        var basicError = errorData['error'] ?? '';
        var emailError = errorData['email']?.join(' ') ?? '';
        var passwordError = errorData['password']?.join(' ') ?? '';
        var errorMessage = '$emailError $passwordError $basicError'.trim();
        emit(AppLoginErrorState(error: errorMessage));
      } else {
        // This is not a DioError
        emit(AppLoginErrorState(error: e.toString()));
      }
    }
  }


  bool isRememberMe = false;

  void rememberMe() {
    isRememberMe = !isRememberMe;
    emit(AppLoginRememberMeState());
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  List<String> categoriesName = [];

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppLoginChangePasswordVisibilityState());
  }


}