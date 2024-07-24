import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import '../../shared/Localization/cubit/cubit.dart';
import '../../shared/Localization/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/dimensions.dart';
import '../../shared/shared_cubit/theme_cubit/cubit.dart';
import '../../shared/shared_cubit/theme_cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../auth/screens/login/login_screen.dart';
import '../change_password/change_password_screen.dart';
import '../delete_account/delete_account_screen.dart';
import '../profile/profile_screen.dart';
import 'components/components.dart';
import 'cubit/settings_lib.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
          bool isDark = AppThemeCubit
              .get(context)
              .isDark!;
          return BlocProvider(
            create: (context) => AppSettingsCubit(),
            child: BlocConsumer<AppSettingsCubit, AppSettingsStates>(
              listener: (context, state) {
                if (state is AppSettingsLogoutSuccessState) {
                  successSnackBar(
                      isDark: isDark,
                      context: context, message: 'Successfully Logout');
                  navigateAndFinish(context, const LoginScreen());
                }
                if (state is AppSettingsLogoutErrorState) {
                  errorSnackBar(
                      isDark: isDark, context: context, message: state.error);
                }
              },
              builder: (context, state) {
                var cubit = AppSettingsCubit.get(context);
                return SafeArea(
                  child: Scaffold(
                    key: scaffoldState,
                    body: MainBackGroundImage(
                      centerDesign: false,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: dimensions.height30),
                          child: Column(
                            children: [
                              if(state is AppSettingsLogoutLoadingState)
                                const LinearProgressIndicator(),
                              //Profile Information
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: dimensions.height4 * 4,
                                    vertical: dimensions.height10
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppThemeCubit
                                      .get(context)
                                      .isDark!
                                      ? AppColors.darkSecondGrayColor
                                      : AppColors.lightBackGroundColor,
                                  border: Border.all(
                                    width: 1,
                                    color: isDark
                                        ? AppColors.darkBorderColor
                                        : AppColors.lightBorderColor,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                  [
                                    FittedBox(
                                      child: Text(
                                          'Profile Information'.translate(
                                              context),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(
                                              fontSize: dimensions.font19
                                          )
                                      ),
                                    ),
                                    SizedBox(height: dimensions.height10,),
                                    Sections(
                                        dimensions: dimensions,
                                        leftTitle: 'Name,location,and industry'
                                            .translate(context),
                                        isDark: isDark,
                                        onTap: () {
                                           navigateTo(context, const ProfileScreen());
                                        }
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: dimensions.height30 +
                                    dimensions.height10,
                              ),
                              //General Settings
                              GeneralSection(
                                dimensions: dimensions,
                                isDark: isDark,
                                context: context,
                                cubit: AppSettingsCubit.get(context),
                                deleteAccountPressed: () {
                                  navigateTo(
                                      context, const DeleteAccountScreen());
                                },
                                changePasswordPressed: () {
                                  navigateTo(
                                      context, const ChangePasswordScreen());
                                },
                                languagePressed: () {
                                  scaffoldState.currentState!.showBottomSheet((
                                      context) => buildLanguageSection(dimensions)
                                  );
                                },
                                modePressed: () {
                                  scaffoldState.currentState!.showBottomSheet((
                                      context) => buildThemeSection(isDark,dimensions)
                                  );
                                },
                              ),
                              //Logout button
                              SizedBox(height: dimensions.height10,),
                              Container(
                                  padding: EdgeInsets.all(
                                      dimensions.height4 * 4),
                                  child: MyButton(
                                    height: dimensions.height10 * 5,
                                    radius: dimensions.height10,
                                    background: isDark
                                        ? AppColors.darkRedColor
                                        : AppColors.lightRedColor,
                                    onPressed: () {
                                      myCustomDialog(
                                        isDark: isDark,
                                        context: context,
                                        title: 'Logout'.translate(context),
                                        desc: 'Are you sure you want to logout ?'
                                            .translate(context),
                                        dialogType: DialogType.question,
                                        btnOkOnPress: () {
                                          cubit.logout();
                                        },
                                      );
                                    },
                                    text: 'Logout'
                                        .translate(context)
                                        .toUpperCase(),
                                  )
                              ),
                              SizedBox(height: dimensions.height30,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }

  BlocBuilder<AppThemeCubit, AppThemeStates> buildLanguageSection(Dimensions dimensions) {
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
          return BlocBuilder<AppLocaleCubit, AppLocaleStates>(
              builder: (context, state) {
                return Container(
                  height: dimensions.height150+dimensions.height20,
                  padding:  EdgeInsets.symmetric(
                      horizontal: dimensions.height4*4, vertical: dimensions.height15
                  ),
                  decoration: BoxDecoration(
                      color: AppThemeCubit.get(context).isDark!
                          ? AppColors.darkSecondGrayColor.withOpacity(0.8)
                          : AppColors.lightSecondaryTextColor.withOpacity(0.3),
                      borderRadius:  BorderRadius.only(
                        topRight: Radius.circular(dimensions.radius10*2),
                        topLeft: Radius.circular(dimensions.radius10*2),
                      )
                  ),
                  child: Column(
                    children:
                    [
                      MyButton(
                        onPressed: () {
                          context.read<AppLocaleCubit>().changeLanguage('en');
                        },
                        radius: dimensions.radius10*0.8,
                        background: AppThemeCubit
                            .get(context).isDark! ? AppColors.darkMainGreenColor : AppColors.lightMainGreenColor,
                        text: 'English'.translate(context),
                        isUpperCase: false,
                      ),
                       SizedBox(height: dimensions.height10,),
                      MyButton(
                        background: AppThemeCubit.get(context).isDark! ? AppColors.darkAccentColor : AppColors.lightAccentColor,
                        onPressed: () {
                          context.read<AppLocaleCubit>().changeLanguage('ar');
                        },
                        radius: dimensions.radius10*0.8,
                        text: "Arabic".translate(context),
                        isUpperCase: false,
                      )
                    ],
                  ),
                );
              }
          );
        }
    );
  }
  BlocBuilder<AppThemeCubit, AppThemeStates> buildThemeSection(bool isDark,Dimensions dimensions) {
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
          return Container(
            height: dimensions.height150 + dimensions.height20,
            padding: EdgeInsets.symmetric(
                horizontal: dimensions.height4 * 4,
                vertical: dimensions.height15
            ),
            decoration: BoxDecoration(
                color: AppThemeCubit
                    .get(context)
                    .isDark!
                    ? AppColors.darkSecondGrayColor.withOpacity(0.8)
                    : AppColors.lightSecondaryTextColor.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(dimensions.radius10 * 2),
                  topLeft: Radius.circular(dimensions.radius10 * 2),
                )
            ),
            child: Column(
              children:
              [
                MyButton(
                  onPressed: () {
                    AppThemeCubit.get(context).changeAppMode(fromShared: false);
                  },
                  radius: dimensions.radius10*0.8,
                  background: AppThemeCubit
                      .get(context)
                      .isDark!
                      ? AppColors.darkMainGreenColor
                      : AppColors.lightMainGreenColor,
                  text: "Light theme".translate(context),
                  isUpperCase: false,
                ),
                SizedBox(height: dimensions.height10,),
                MyButton(
                  onPressed: () {
                    AppThemeCubit.get(context).changeAppMode(fromShared: true);
                  },
                  radius: dimensions.radius10*0.8,
                  background: AppThemeCubit
                      .get(context)
                      .isDark!
                      ? AppColors.darkAccentColor
                      : AppColors.lightAccentColor,
                  text: "Dark theme".translate(context),
                  isUpperCase: false,
                )
              ],
            ),
          );
        }
    );
  }
}