import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/dimensions.dart';
import '../../shared/shared_cubit/theme_cubit/cubit.dart';
import '../../shared/shared_cubit/theme_cubit/states.dart';
import '../../shared/styles/colors.dart';
import 'cubit/change_password_lib.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);

    var oldPasswordController = TextEditingController();
    var newPasswordController = TextEditingController();
    var newPasswordConfirmationController = TextEditingController();
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
          bool isDark = AppThemeCubit
              .get(context)
              .isDark!;
          return BlocProvider(
            create: (context) => AppChangePasswordCubit(),
            child: BlocConsumer<AppChangePasswordCubit,
                AppChangePasswordStates>(
              listener: (context, state) {
                if (state is AppChangePasswordSuccessStates) {
                  Navigator.pop(context);
                  successSnackBar(
                      isDark: isDark,
                      context: context,
                      message: "Password has been changed Successfully"
                  );
                  oldPasswordController.text = "";
                  newPasswordController.text = "";
                  newPasswordConfirmationController.text = "";
                }
                if (state is AppChangePasswordErrorStates) {
                  errorSnackBar(
                      isDark: isDark, context: context, message: state.error);
                }
              },
              builder: (context, state) {
                var cubit = AppChangePasswordCubit.get(context);
                return Scaffold(
                  appBar: myAppBar(
                      title: '',
                      actions: [
                        const MyAppBarLogo(),
                      ]
                  ),
                  body: SafeArea(
                    child: MainBackGroundImage(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:
                              [
                                Text(
                                  'Reset Password'.translate(context),
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      fontSize: dimensions.font25,
                                      color: isDark ? AppColors
                                          .darkAccentColor : AppColors
                                          .lightAccentColor
                                  ),
                                ),
                                SizedBox(height: dimensions.height15 * 2,),
                                //old password
                                MyTextField(
                                  isDark: isDark,
                                  radius: dimensions.radius10,
                                  hintText: 'Old Password'.translate(context),
                                  controller: oldPasswordController,
                                  type: TextInputType.visiblePassword,
                                  isPassword: cubit.isOldPassword,
                                  suffixPressed: () =>
                                      cubit.changePasswordVisibility(
                                          type: "oldPassword"),
                                  suffix: cubit.suffixOld,
                                  prefixIcon: Icons.lock,
                                ),
                                SizedBox(height: dimensions.height10,),
                                //new password
                                MyTextField(
                                  isDark: isDark,
                                  radius: dimensions.radius10,
                                  hintText: 'New Password'.translate(context),
                                  controller: newPasswordController,
                                  type: TextInputType.visiblePassword,
                                  isPassword: cubit.isNewPassword,
                                  suffixPressed: () =>
                                      cubit.changePasswordVisibility(
                                          type: "newPassword"),
                                  suffix: cubit.suffixNew,
                                  prefixIcon: Icons.lock,
                                ),
                                SizedBox(height: dimensions.height10,),
                                //confirm password
                                MyTextField(
                                  isDark: isDark,
                                  radius: dimensions.height10,
                                  hintText: 'Confirm Password'.translate(
                                      context),
                                  controller: newPasswordConfirmationController,
                                  type: TextInputType.visiblePassword,
                                  isPassword: cubit.isNewConfirmationPassword,
                                  suffixPressed: () =>
                                      cubit.changePasswordVisibility(
                                          type: "NewConfirmationPassword"),
                                  suffix: cubit.suffixNewConfirmation,
                                  prefixIcon: Icons.lock,
                                ),
                                SizedBox(height: dimensions.height15 * 2,),
                                //button
                                state is AppChangePasswordLoadingStates
                                    ? const Center(
                                    child: CircularProgressIndicator())
                                    : MyButton(
                                  background: isDark ? AppColors
                                      .darkMainGreenColor : AppColors
                                      .lightMainGreenColor,
                                  onPressed: () {
                                    if (
                                    oldPasswordController.text == "" ||
                                        newPasswordController.text == "" ||
                                        newPasswordConfirmationController
                                            .text == ""
                                    ) {
                                      bottomErrorSnackBar(context: context,
                                          title: 'Please fill all fields'
                                              .translate(context));
                                    } else {
                                      cubit.changePassword(
                                          oldPassword: oldPasswordController
                                              .text,
                                          newPassword: newPasswordController
                                              .text,
                                          newConfirmationPassword: newPasswordConfirmationController
                                              .text
                                      );
                                    }
                                  },
                                  text: 'Reset Password'.translate(context),
                                  isUpperCase: false,
                                  radius:dimensions.height10,
                                )
                              ],
                            ),
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
}
