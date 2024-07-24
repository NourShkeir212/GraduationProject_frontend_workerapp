import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import 'package:hire_me_worker/shared/var/var.dart';
import '../../../model/profile_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/dimensions.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/shared_cubit/theme_cubit/cubit.dart';
import '../../../shared/shared_cubit/theme_cubit/states.dart';
import '../../../shared/styles/colors.dart';
import '../components/components.dart';
import '../cubit/profile_lib.dart';
import 'package:intl/intl.dart';
class EditProfileScreen extends StatelessWidget {
  final ProfileModel profileModel;

  const EditProfileScreen({Key? key, required this.profileModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(profileModel.data!.startTime!="") {
      backEndStartTime = DateFormat('H:mm').format(
          DateFormat.jm().parse(profileModel.data!.startTime!));
      backEndEndTime = DateFormat('H:mm').format(
          DateFormat.jm().parse(profileModel.data!.endTime!));
    }
    var profile = profileModel.data!;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController startTimeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();
    String profileImageUrl = profile.profileImage ?? "";
    emailController.text = profile.email!;
    nameController.text = profile.name!;
    phoneController.text = profile.phone!;
    addressController.text = profile.address ?? "";
    startTimeController.text = profile.startTime ?? startTime;
    endTimeController.text = profile.endTime ?? endTime;
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
          Dimensions dimensions = Dimensions(context);
          bool isDark = AppThemeCubit
              .get(context)
              .isDark!;
          return BlocProvider(
            create: (context) => AppProfileCubit(),
            child: BlocConsumer<AppProfileCubit, AppProfileStates>(
              listener: (context, state) {
                if (state is AppUpdateProfileErrorState) {
                  errorSnackBar(
                      isDark: isDark, context: context, message: state.error);
                }
                if (state is AppProfileUpdateProfileImageErrorState) {
                  errorSnackBar(
                      isDark: isDark, context: context, message: state.error);
                }
                if (state is AppUpdateProfileSuccessState) {
                  Navigator.pop(context, 'updated');
                  successSnackBar(isDark: isDark, context: context,
                      message: 'Profile has been updated'.translate(context));
                }
                if (state is AppProfileUpdateProfileImageSuccessState) {
                  profile.profileImage = state.imageUrl;
                  profileImageUrl = state.imageUrl;
                  CacheHelper.saveData(key: 'check_profile_image', value: state.imageUrl);
                  successSnackBar(
                      isDark: isDark,
                      context: context,
                      message: 'Profile image has been updated'.translate(
                          context)
                  );
                }
              },
              builder: (context, state) {
                var cubit = AppProfileCubit.get(context);
                return Scaffold(
                  appBar: myAppBar(
                      title: 'Edit profile'.translate(context),
                      actions: [
                        const MyAppBarLogo(),
                      ],
                      leading: IconButton(
                        onPressed: () {
                          if (state is AppUpdateProfileSuccessState ||
                              state is AppProfileUpdateProfileImageSuccessState
                          ) {
                            Navigator.pop(context, 'updated');
                          } else {
                            Navigator.pop(context, 'no_update');
                          }
                        },
                        icon: const Icon(Icons.arrow_back_outlined),
                      )
                  ),
                  body: SafeArea(
                    child: MainBackGroundImage(
                      centerDesign: false,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            LinerProgressConditions(state: state),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    ProfileImage(
                                      gender: profile.gender!,
                                      imageName: profile.name!,
                                      imgUrl: profileImageUrl,
                                      height: 150,
                                      width: 150,
                                      onTap: () {},
                                    ),
                                    const SizedBox(height: 30),
                                    //Profile Image Update Button
                                    MyButton(
                                      radius: 10,
                                      background: isDark ? AppColors
                                          .darkAccentColor : AppColors.lightAccentColor,
                                      onPressed: () {
                                        cubit.updateProfileImage();
                                      },
                                      text: 'Update profile image'.translate(
                                          context),
                                      isUpperCase: false,
                                      fontSize: 13,
                                    ),
                                    const SizedBox(height: 15,),
                                    StartAndEndTimeSection(
                                      isDark: isDark,
                                      startTimeController: startTimeController,
                                      endTimeController: endTimeController,
                                    ),
                                    const SizedBox(height: 10),
                                    //user name
                                    MyTextField(
                                      isDark: isDark,
                                      hintText: "Full name".translate(context),
                                      controller: nameController,
                                      type: TextInputType.name,
                                      prefixIcon: Icons.person,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your full name'
                                              .translate(context);
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    //email
                                    MyTextField(
                                      isDark: isDark,
                                      hintText: "Email address".translate(
                                          context),
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      prefixIcon: Icons.email,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your email address'
                                              .translate(context);
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    //address
                                    MyTextField(
                                      isDark: isDark,
                                      hintText: "Address".translate(context),
                                      controller: addressController,
                                      type: TextInputType.text,
                                      prefixIcon: Icons.location_on_outlined,
                                    ),
                                    const SizedBox(height: 10),
                                    //phone
                                    MyTextField(
                                      isDark: isDark,
                                      hintText: "Phone number".translate(
                                          context),
                                      controller: phoneController,
                                      type: TextInputType.phone,
                                      prefixIcon: Icons.phone,
                                      isPhoneNumber: true,
                                      validator: (value) {
                                        if (value!.length < 9) {
                                          return 'Phone number must be 9 digits'
                                              .translate(context);
                                        } else if (value.isEmpty) {
                                          return 'Please enter your phone number'
                                              .translate(context);
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MyButton(
                        background: isDark
                            ? AppColors.darkMainGreenColor
                            : AppColors.lightMainGreenColor,
                        radius: dimensions.radius10,
                        height: dimensions.radius50,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (kDebugMode) {
                              print(emailController.text);
                            }
                            cubit.updateProfile(
                              startTime: backEndStartTime,
                              endTime:  backEndEndTime,
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              context: context,
                            );
                          }
                        },
                        text: "Confirm".translate(context)),
                  ),
                );
              },
            ),
          );
        }
    );
  }
}

class LinerProgressConditions extends StatelessWidget {
  final AppProfileStates state;

  const LinerProgressConditions({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is AppUpdateProfileLoadingState) {
      return const LinearProgressIndicator();
    }
    if (state is AppProfileUpdateProfileImageLoadingState) {
      return const LinearProgressIndicator();
    }
    return const SizedBox.shrink();
  }
}






