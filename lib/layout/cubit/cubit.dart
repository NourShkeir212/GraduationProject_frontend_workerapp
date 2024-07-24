import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/profile_model.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/reviews/reviews_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/tasks/tasks_screen.dart';
import '../../shared/constants/consts.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shared/var/var.dart';
import 'states.dart';


class AppLayoutCubit extends Cubit<AppLayoutStates> {
  AppLayoutCubit() : super(AppLayoutInitialState());

  static AppLayoutCubit get(context) => BlocProvider.of(context);

  int bottomNavBarCurrentIndex = 0;

  void changeBottomNavBar(int index) {
    bottomNavBarCurrentIndex = index;
    emit(AppLayoutBottomNavBarChangeStates());
  }

  List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    TasksScreen(),
    SettingsScreen(),
  ];


  ProfileModel? profileModel;

  void getProfile() async {
    print(token);
    try {
      emit(AppLayoutGetProfileLoadingState());
      var response = await DioHelper.get(
          url: AppConstant.PROFILE,
          token: token
      );
      if (response.statusCode == 200) {
        profileModel = ProfileModel.fromJson(response.data);
        emit(AppLayoutGetProfileSuccessState());
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
        emit(AppLayoutGetProfileErrorState(error: errorMessage));
      } else {
        emit(AppLayoutGetProfileErrorState(error: e.toString()));
      }
    }
  }
}
