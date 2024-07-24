import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../network/local/cache_helper.dart';
import '../../var/var.dart';
import 'states.dart';

class AppLocaleCubit extends Cubit<AppLocaleStates> {

  AppLocaleCubit() : super(AppLocaleInitialState());

  static AppLocaleCubit get(context) => BlocProvider.of(context);

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode = await CacheHelper().getCachedLanguageCode();
    emit(AppLocaleChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await CacheHelper().cacheLanguageCode(languageCode);
    lang = languageCode;
    emit(AppLocaleChangeLocaleState(locale: Locale(languageCode)));
  }

}