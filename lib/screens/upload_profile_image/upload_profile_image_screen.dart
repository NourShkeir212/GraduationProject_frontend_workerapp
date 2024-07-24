import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/layout/layout_screen.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/consts.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/shared_cubit/theme_cubit/cubit.dart';
import '../../shared/shared_cubit/theme_cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/var/var.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';



class UploadProfileImageScreen extends StatelessWidget {
  const UploadProfileImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    lang = 'en';
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
          bool isDark = AppThemeCubit
              .get(context)
              .isDark!;
          //  bool isDark = true;
          return BlocProvider(
            create: (context) => AppUploadProfileImageCubit(),
            child: BlocConsumer<
                AppUploadProfileImageCubit,
                AppUploadProfileImageStates>(
              listener: (context, state) {
                if (state is AppUploadProfileImageSuccessState) {
                  profileImageUrl = state.imageUrl;
                  CacheHelper.saveData(
                      key: 'check_profile_image', value: state.imageUrl);
                  successSnackBar(context: context,
                      message: "Success".translate(context),
                      isDark: isDark);
                }
                if (state is AppUpdateProfileImageSuccessState) {
                  profileImageUrl = state.imageUrl;
                  CacheHelper.updateData(
                      key: 'check_profile_image', value: state.imageUrl).then((
                      value) {});
                  successSnackBar(context: context,
                      message: "Success".translate(context),
                      isDark: isDark);
                }
                if (state is AppUploadProfileImageErrorState) {
                  errorSnackBar(
                      context: context, message: state.error, isDark: isDark);
                }
                if (state is AppUpdateProfileImageErrorState) {
                  errorSnackBar(
                      context: context, message: state.error, isDark: isDark);
                }
              },
              builder: (context, state) {
                var cubit = AppUploadProfileImageCubit.get(context);
                return Scaffold(
                  backgroundColor: isDark
                      ? AppColors.darkSecondGrayColor
                      : AppColors.lightGrayBackGroundColor,
                  body: SafeArea(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //ProfileImage
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.selectAndUploadImage();
                                },
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: AppConstant.BASE_URL + cubit.profileImage,
                                      imageBuilder: (context, image) {
                                        return Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: isDark ? AppColors
                                                  .darkSecondaryTextColor
                                                  .withOpacity(0.5) : AppColors
                                                  .lightShadowColor,
                                              borderRadius: BorderRadius
                                                  .circular(100),
                                              image: DecorationImage(
                                                  image: image,
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center
                                              )
                                          ),
                                        );
                                      },
                                      fit: BoxFit.contain,
                                      placeholder: (context, _) =>
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: isDark ? AppColors
                                                  .darkSecondaryTextColor
                                                  .withOpacity(0.5) : AppColors
                                                  .lightShadowColor,
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  100),
                                            ),
                                            child: const Center(
                                              child: CircularProgressIndicator(),),
                                          ),
                                      errorWidget: (context, _, __) {
                                        return Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: isDark ? AppColors
                                                .darkSecondaryTextColor
                                                .withOpacity(
                                                0.4) : AppColors
                                                .lightShadowColor,
                                            borderRadius: BorderRadius.circular(
                                                100),
                                          ),
                                          child: const Icon(
                                            Icons.person, color: Colors.white,
                                            size: 80,),
                                        );
                                      },
                                    ),
                                    Positioned(
                                        left: 80,
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            cubit.selectAndUploadImage();
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor: isDark
                                                ? AppColors
                                                .darkSecondaryTextColor
                                                : Colors.grey[300],
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 18,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors
                                                  .black,
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            state is AppUpdateProfileImageLoadingState ||
                                state is AppUploadProfileImageLoadingState ?
                            const SizedBox(height: 15) : const SizedBox
                                .shrink(),
                            state is AppUpdateProfileImageLoadingState ||
                                state is AppUploadProfileImageLoadingState ?
                            const LinearProgressIndicator() : const SizedBox
                                .shrink(),
                            const SizedBox(height: 35,),
                            Text(
                              'Please add your profile image'.translate(context),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5.0,),
                            Text(
                                'Note: The image must be up-to-date for credibility and in order to observe the application policy.'.translate(context),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: isDark ? AppColors
                                        .darkSecondaryTextColor : AppColors
                                        .lightSecondaryTextColor
                                )
                            ),
                            const SizedBox(height: 20,),
                            MyButton(
                              onPressed: () {
                                if(profileImageUrl==""){
                                  errorSnackBar(context: context, message: "Please add your profile image first".translate(context), isDark: isDark);
                                }else{
                                  navigateAndFinish(context, const LayoutScreen());
                                }
                              },
                              background: isDark?AppColors.darkMainGreenColor:AppColors.lightMainGreenColor,
                              isUpperCase: false,
                              text: "Finish".translate(context),
                              radius: 50,
                            ),
                          ],
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
