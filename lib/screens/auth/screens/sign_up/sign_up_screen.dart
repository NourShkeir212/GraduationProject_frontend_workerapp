import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/constants/dimensions.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/shared_cubit/theme_cubit/cubit.dart';
import '../../../../shared/shared_cubit/theme_cubit/states.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/var/var.dart';
import '../../../upload_profile_image/upload_profile_image_screen.dart';
import '../login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordConfirmationController = TextEditingController();
    String gender = 'Male';
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
      builder: (context, state) {
        var isDark = AppThemeCubit
            .get(context)
            .isDark!;
        return BlocProvider(
          create: (context) =>
          AppSignUpCubit()
            ..getCategories(),
          child: BlocConsumer<AppSignUpCubit, AppSignUpStates>(
              listener: (context, state) {
                if (state is AppSignUpErrorState) {
                  errorSnackBar(
                      context: context, message: state.error, isDark: isDark);
                }
                if (state is AppSignUpSuccessState) {
                  if (AppSignUpCubit.get(context).isRememberMe) {
                    CacheHelper.saveData(key: 'token', value: state.token);
                  }
                  token = state.token;
                  successSnackBar(
                      context: context, message: "Success", isDark: isDark);
                  navigateAndFinish(context, const UploadProfileImageScreen());
                }
              },
              builder: (context, state) {
                Dimensions dimensions = Dimensions(context);
                var cubit = AppSignUpCubit.get(context);
                List<DropdownMenuItem<String>> getDropDownItems() {
                  return cubit.categoryModel.data!.map((item) {
                    return DropdownMenuItem(
                      value: item.category!.name!,
                      child: Text(item.category!.name!.translate(context)),
                    );
                  }).toList();
                }
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
                          //back
                          IconButton(
                            onPressed: () {
                              back(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.white, size: 25,
                            ),
                          ),
                          //gretting
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Signup'.translate(context),
                                  style: const TextStyle(fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),),
                                Text('Welcome to HireMe'.translate(context),
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                          //body
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
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
                                  child:state is AppSignUpGetCategoriesNameLoadingState?const Center(child: CircularProgressIndicator(),):  Column(
                                    children: [
                                      const SizedBox(height: 20,),
                                      //FormField
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
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
                                        child:   Column(
                                          children: [
                                            MyAuthTextField(
                                              controller: nameController,
                                              isDark: isDark,
                                              type: TextInputType.name,
                                              hintText: "User name".translate(context),
                                              prefixIcon: Icons
                                                  .person_2_outlined,
                                            ),
                                            MyAuthTextField(
                                              controller: emailController,
                                              isDark: isDark,
                                              type: TextInputType.emailAddress,
                                              hintText: 'Email address'
                                                  .translate(context),
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
                                            MyAuthTextField(
                                              isPassword: cubit.isPassword,
                                              suffix: cubit.suffix,
                                              suffixPressed: () =>
                                                  cubit
                                                      .changePasswordVisibility(),
                                              controller: passwordConfirmationController,
                                              isDark: isDark,
                                              type: TextInputType
                                                  .visiblePassword,
                                              hintText: 'Confirm Password'
                                                  .translate(
                                                  context),
                                              prefixIcon: Icons.lock_outline,
                                            ),
                                            MyAuthTextField(
                                              controller: phoneController,
                                              isPhoneNumber: true,
                                              isDark: isDark,
                                              type: TextInputType.phone,
                                              hintText: 'Phone Number'
                                                  .translate(context),
                                              prefixIcon: Icons.phone_outlined,
                                            ),
                                            const SizedBox(height: 10,),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: isDark
                                                              ? AppColors
                                                              .darkSecondGrayColor
                                                              : AppColors
                                                              .lightGrayBackGroundColor
                                                      )
                                                  )
                                              ),
                                              child: MyDropDownFormField(
                                                  prefixIcon: Icons.list,
                                                  isDark: isDark,
                                                  hintText: 'Select your Category',
                                                  onChanged: (value) =>
                                                      cubit.selectYourCategory(
                                                          value.toString()),
                                                  items: getDropDownItems(),
                                                  value: cubit.dropDownItemValue
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            genderSection(isDark: isDark,
                                                context: context,
                                                cubit: cubit,
                                                gender: gender),
                                            const SizedBox(height: 10,),
                                            rememberMeWidget(
                                                cubit, isDark, context),
                                            const SizedBox(height: 5,),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      //Login Button
                                      state is AppSignUpLoadingState ?
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: CircularProgressIndicator(),
                                      )
                                          : MyButton(
                                        background: isDark ? AppColors
                                            .darkMainGreenColor : AppColors
                                            .lightMainGreenColor,
                                        marginLeft: 40,
                                        marginRight: 40,
                                        marginBottom: 10,
                                        marginTop: 10,
                                        onPressed: () {
                                          if (emailController.text == "" ||
                                              passwordController.text == "" ||
                                              passwordConfirmationController
                                                  .text == "" ||
                                              phoneController.text == "" ||
                                              nameController.text == "" ||
                                              cubit.dropDownItemValue == ""
                                          ) {
                                            errorSnackBar(
                                              context: context,
                                              message: "Please fill all fields"
                                                  .translate(context),
                                              isDark: isDark,
                                            );
                                          } else {
                                            cubit.register(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              passwordConfirmation: passwordConfirmationController
                                                  .text,
                                              category: cubit.dropDownItemValue,
                                              gender: cubit.isMale
                                                  ? 'male'
                                                  : 'female',
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                        text: 'Signup'.translate(context),
                                        fontWeight: FontWeight.bold,
                                        isUpperCase: false,
                                        radius: 50,
                                        height: 50,
                                      ),
                                      //Already have an account?
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Text(
                                            'Already have an account?'
                                                .translate(
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
                                              title: 'Login'.translate(
                                                  context),
                                              fontWeight: FontWeight.bold,
                                              size: 18,
                                              color: isDark ? AppColors
                                                  .darkAccentColor : AppColors
                                                  .lightAccentColor,
                                              onPressed: () {
                                                back(context);
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
                    )
                );
              }
          ),
        );
      },
    );
  }

  Row rememberMeWidget(AppSignUpCubit cubit, bool isDark,
      BuildContext context) {
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

  Padding genderSection({required String gender,
    required AppSignUpCubit cubit,
    required bool isDark,
    required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              gender = 'Male';
              cubit.gender();
            },
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: lang == "en" ? 8 : 0,
                    left: lang == "en" ? 0 : 8,
                  ),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: cubit.isMale
                          ? isDark
                          ? AppColors
                          .darkSecondaryTextColor
                          : AppColors
                          .lightSecondaryTextColor
                          : Colors.transparent,
                      border: Border.all(
                          width: 1,
                          color: isDark
                              ? AppColors
                              .darkSecondaryTextColor
                              : AppColors
                              .lightSecondaryTextColor
                      ),
                      borderRadius: BorderRadius
                          .circular(15)
                  ),
                  child: Icon(
                      Icons.man_outlined,
                      color: cubit.isMale
                          ? Colors.white
                          : isDark
                          ? AppColors
                          .darkSecondaryTextColor
                          : AppColors
                          .lightSecondaryTextColor
                  ),
                ),
                Text(
                  'Male'.translate(context),
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                      fontSize: 14,
                      color: isDark
                          ? AppColors
                          .darkSecondaryTextColor
                          : AppColors
                          .lightSecondaryTextColor
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 30,),
          GestureDetector(
            onTap: () {
              gender = 'Female';
              cubit.gender();
              if (kDebugMode) {
                print(cubit.isMale);
              }
            },
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: lang == "en" ? 8 : 0,
                    left: lang == "en" ? 0 : 8,),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: cubit.isMale ? Colors
                          .transparent : isDark
                          ? AppColors
                          .darkSecondaryTextColor
                          : AppColors
                          .lightSecondaryTextColor,
                      border: Border.all(
                          width: 1,
                          color: isDark
                              ? AppColors
                              .darkSecondaryTextColor
                              : AppColors
                              .lightSecondaryTextColor
                      ),
                      borderRadius: BorderRadius
                          .circular(15)
                  ),
                  child: Icon(
                      Icons.woman_2_outlined,
                      color: cubit.isMale
                          ? AppColors
                          .lightSecondaryTextColor
                          : Colors
                          .white

                  ),
                ),
                Text(
                  'Female'.translate(context),
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                      fontSize: 14,
                      color: isDark
                          ? AppColors
                          .darkSecondaryTextColor
                          : AppColors
                          .lightSecondaryTextColor
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

