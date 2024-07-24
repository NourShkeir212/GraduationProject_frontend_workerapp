import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/constants/consts.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/var/var.dart';
import 'delete_account_lib.dart';

class AppDeleteAccountCubit extends Cubit<AppDeleteAccountStates> {

  AppDeleteAccountCubit() : super(AppDeleteAccountInitialState());

  static AppDeleteAccountCubit get(context) => BlocProvider.of(context);

  deleteAccount({required String password}) async {
    try {
      emit(AppDeleteAccountLoadingState());
      var response = await DioHelper.delete(
          url: AppConstant.DELETE_ACCOUNT,
          token: token,
          data: {
            'password': password
          }
      );
      if (response!.statusCode == 200) {
        await CacheHelper.removeData(key: 'token').then((value) {
          token = "";
        });
        emit(AppDeleteAccountSuccessState());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (e is DioException) {
        var errorData = e.response?.data;
        var messageError = errorData['message'] ?? '';
        emit(AppDeleteAccountErrorState(error: messageError.toString()));
      } else {
        emit(AppDeleteAccountErrorState(error: e.toString()));
      }
    }
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }
}