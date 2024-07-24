import 'package:flutter_bloc/flutter_bloc.dart';
import '../../network/local/cache_helper.dart';
import 'states.dart';


class AppThemeCubit extends Cubit<AppThemeStates> {
  AppThemeCubit() : super(AppThemeInitialState());

  static AppThemeCubit get(context) => BlocProvider.of(context);


  bool? isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared == false) {
      CacheHelper.putBoolean(key: 'isDark', value: false).then((value) {
        isDark =false;
        emit(AppChangeModeState());
      });
    } else {
      CacheHelper.putBoolean(key: 'isDark', value: true).then((value) {
        isDark =true;
        emit(AppChangeModeState());
      });
    }
  }
}