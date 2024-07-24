import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/constants/consts.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/var/var.dart';
import 'settings_lib.dart';

class AppSettingsCubit extends Cubit<AppSettingsStates> {

  AppSettingsCubit() : super(AppSettingsInitialState());

  static AppSettingsCubit get(context) => BlocProvider.of(context);

  logout() async {
    try {
      emit(AppSettingsLogoutLoadingState());
      var response = await DioHelper.get(
        url: AppConstant.LOGOUT_CURRENT_SESSION,
        token: token,
      );
      if (response.statusCode == 200) {
        await CacheHelper.removeData(key: 'token').then((value) {
          token = "";
          profileImageUrl = "";
          CacheHelper.removeData(key: "check_profile_image");
        });
        emit(AppSettingsLogoutSuccessState());
      }
    }
    catch (e) {
      print(e.toString());
      emit(AppSettingsLogoutErrorState(error: e.toString()));
    }
  }

}



