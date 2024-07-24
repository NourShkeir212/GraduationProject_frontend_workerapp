import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/screens/upload_profile_image/upload_profile_image_screen.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import '../../../../layout/layout_screen.dart';
import '../../../../shared/Localization/cubit/cubit.dart';
import '../../../../shared/Localization/cubit/states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/constants/dimensions.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/shared_cubit/theme_cubit/cubit.dart';
import '../../../../shared/shared_cubit/theme_cubit/states.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/var/var.dart';
import '../sign_up/sign_up_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
          bool isDark = AppThemeCubit
              .get(context)
              .isDark!;
          //  bool isDark = true;
          Dimensions dimensions = Dimensions(context);
          return BlocProvider(
            create: (context) => AppLoginCubit(),
            child: BlocConsumer<AppLoginCubit, AppLoginStates>(
                listener: (context, state) {
                  if (state is AppLoginErrorState) {
                    errorSnackBar(
                      context: context,
                      message: state.error,
                      isDark: isDark,
                    );
                  }
                  if (state is AppLoginSuccessState) {
                    if (AppLoginCubit.get(context).isRememberMe) {
                      CacheHelper.saveData(
                          key: 'token',
                          value: state.token
                      );
                      CacheHelper.saveData(key: 'check_profile_image', value: state.checkProfileImage);
                    }
                    successSnackBar(
                      context: context,
                      message: "Welcome Back".translate(context),
                      isDark: isDark,
                    );
                    token = state.token;
                    //if there is no profileImage came from the server then he should upload his profileImage
                    if(state.checkProfileImage==""){
                      navigateTo(context, const UploadProfileImageScreen());
                    }else {
                      navigateAndFinish(context, const LayoutScreen());
                    }
                  }
                },
                builder: (context, state) {
                  var cubit = AppLoginCubit.get(context);
                  return Scaffold(
                    body: Container(
                      padding: const EdgeInsets.only(top: 30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkMainGreenColor
                              : AppColors.lightMainGreenColor
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          changeLanguageSection(
                              context: context,
                              value: 'en',
                              isDark: isDark
                          ),
                          const SizedBox(height: 10,),
                          const GrettingSection(),
                          const SizedBox(height: 20,),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        dimensions.radius50 +
                                            dimensions.radius10),
                                    topRight: Radius.circular(
                                        dimensions.radius50 +
                                            dimensions.radius10),
                                  )
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 50,),
                                      //FormField
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColors
                                                      .lightAccentColor
                                                      .withOpacity(0.1),
                                                  blurRadius: 20,
                                                  offset: const Offset(0, 10)
                                              )
                                            ]
                                        ),
                                        child: Column(
                                          children: [
                                            MyAuthTextField(
                                              controller: emailController,
                                              isDark: isDark,
                                              type: TextInputType.emailAddress,
                                              hintText: 'Email address'.translate(context),
                                              prefixIcon: Icons.email_outlined,
                                            ),
                                            MyAuthTextField(
                                              isPassword: cubit.isPassword,
                                              suffix: cubit.suffix,
                                              suffixPressed: () =>
                                                  cubit
                                                      .changePasswordVisibility(),
                                              controller: passwordController,
                                              isDark: isDark,
                                              type: TextInputType
                                                  .visiblePassword,
                                              hintText: 'Password'.translate(
                                                  context),
                                              prefixIcon: Icons.lock_outline,
                                            ),
                                            rememberMeWidget(
                                                cubit, isDark, context),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 40,),
                                      //Forgot Password
                                      MyTextButton(
                                        isDark: isDark,
                                        title: 'Forgot Password?'.translate(
                                            context),
                                        onPressed: () {},
                                        color: isDark ? AppColors
                                            .darkAccentColor : AppColors
                                            .lightAccentColor,
                                        size: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      //Login Button
                                      state is AppLoginLoadingState ?
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 30.0),
                                        child: CircularProgressIndicator(),
                                      )
                                          : MyButton(
                                        background: isDark ? AppColors
                                            .darkMainGreenColor : AppColors
                                            .lightMainGreenColor,
                                        marginLeft: 40,
                                        marginRight: 40,
                                        marginBottom: 30,
                                        marginTop: 30,
                                        onPressed: () {
                                          if (emailController.text == "" ||
                                              passwordController.text == "") {
                                            errorSnackBar(context: context,
                                                message: "Please fill all fields"
                                                    .translate(context),
                                                isDark: isDark);
                                          } else {
                                            cubit.login(
                                                email: emailController.text,
                                                password: passwordController
                                                    .text);
                                          }
                                        },
                                        text: 'Login'.translate(context),
                                        fontWeight: FontWeight.bold,
                                        isUpperCase: false,
                                        radius: 50,
                                        height: 50,
                                      ),
                                      //Don't have an account
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Text(
                                            'Don\'t have an account?'.translate(
                                                context),
                                            style: TextStyle(
                                                color: isDark
                                                    ? AppColors
                                                    .darkSecondaryTextColor
                                                    : AppColors
                                                    .lightSecondaryTextColor,
                                                fontSize: 16
                                            ),
                                          ),
                                          MyTextButton(
                                              isDark: isDark,
                                              title: 'Signup'.translate(
                                                  context),
                                              fontWeight: FontWeight.bold,
                                              size: 18,
                                              color: isDark ? AppColors
                                                  .darkAccentColor : AppColors
                                                  .lightAccentColor,
                                              onPressed: () {
                                                navigateTo(context,
                                                    const SignUpScreen());
                                              }
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          );
        }
    );
  }

  changeLanguageSection({
    required BuildContext context,

    required String value,
    required bool isDark
  }) {
    return BlocBuilder<AppLocaleCubit, AppLocaleStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
                alignment: lang == "en" ? Alignment.centerLeft : Alignment
                    .centerRight,
                child: DropdownButton(
                    dropdownColor: AppColors.darkSecondGrayColor,
                    value: lang,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                    elevation: 0,
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.language, color: Colors.white,),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text('English'.translate(context)),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text('Arabic'.translate(context)),
                        ),
                      )
                    ],
                    onChanged: (value) {
                      context.read<AppLocaleCubit>().changeLanguage(value!);
                    }
                )
            ),
          );
        }
    );
  }

  Row rememberMeWidget(AppLoginCubit cubit, bool isDark, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: cubit.isRememberMe,
                activeColor: isDark
                    ? AppColors.darkSecondaryTextColor
                    : AppColors.lightSecondaryTextColor,
                side: BorderSide(
                  color: isDark
                      ? AppColors.darkSecondaryTextColor
                      : AppColors.lightSecondaryTextColor,),
                onChanged: (value) {
                  cubit.rememberMe();
                }
            ),
            FittedBox(
              child: Text(
                  'Remember me'.translate(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.darkSecondaryTextColor
                          : AppColors.lightSecondaryTextColor
                  )
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MyAuthTextField extends StatelessWidget {
  const MyAuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    required this.type,
    this.prefixIcon,
    this.suffix,
    this.suffixPressed,
    required this.isDark,
    this.isPhoneNumber = false,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType type;
  final IconData? prefixIcon;
  final IconData? suffix;
  final Function()? suffixPressed;
  final bool isDark;
  final bool isPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
              color:  AppColors.lightGrayBackGroundColor
              )
          )
      ),
      child: TextField(
        maxLength: isPhoneNumber ? 9 : null,
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        style: TextStyle(color: isDark? AppColors.darkSecondaryTextColor:AppColors.lightSecondaryTextColor),
        decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon ?? null,
              color:  AppColors.lightSecondaryTextColor,
            ),
            suffixIcon: suffix != null
                ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(suffix ?? Icons.clear,
                  color:  AppColors.lightSecondaryTextColor),
            )
                : null,
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: isDark ? AppColors.darkSecondaryTextColor : AppColors.lightSecondaryTextColor,
            )
        ),
      ),
    );
  }
}

class GrettingSection extends StatelessWidget {
  const GrettingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Login'.translate(context),
            style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
          Text('Welcome Back'.translate(context),
            style: const TextStyle(fontSize: 18, color: Colors.white),),
        ],
      ),
    );
  }
}