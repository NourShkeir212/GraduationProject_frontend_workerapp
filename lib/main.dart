import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/screens/splash/splash_screen.dart';
import 'shared/Localization/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'shared/Localization/cubit/cubit.dart';
import 'shared/Localization/cubit/states.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/shared_cubit/theme_cubit/cubit.dart';
import 'shared/shared_cubit/theme_cubit/states.dart';
import 'shared/styles/themes.dart';
import 'shared/var/var.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  lang = CacheHelper.getData(key: "LOCALE") ?? "en";
  await initializeDateFormatting(lang, null);

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;


  token = CacheHelper.getData(key: 'token') ?? "";
  print("Your token is : $token");
  print("Check Profile Image: ${CacheHelper.getData(key: 'check_profile_image')??""}");
  // CacheHelper.removeData(key: 'check_profile_image');
  // token="";
  // CacheHelper.removeData(key: 'token');

  //to prevent the mobile rotate
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(MyApp(isDark: isDark));
  });
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppThemeCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => AppLocaleCubit()..getSavedLanguage(),
        ),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeStates>(
          builder: (context, state) {
            return BlocBuilder<AppLocaleCubit, AppLocaleStates>(
                builder: (context, state) {
                  if (state is AppLocaleChangeLocaleState) {
                    return BuildMaterialApp(
                        locale: state.locale,
                        themeMode: AppThemeCubit.get(context).isDark!
                            ? ThemeMode.dark
                            : ThemeMode.light
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
            );
          }
      ),
    );
  }
}


class BuildMaterialApp extends StatelessWidget {
  final Locale locale;
  final ThemeMode themeMode;

  const BuildMaterialApp(
      {super.key, required this.themeMode, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      locale: locale,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeMode,
      // home: const SplashScreen(),
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (deviceLocale != null &&
              deviceLocale.languageCode == locale.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}



