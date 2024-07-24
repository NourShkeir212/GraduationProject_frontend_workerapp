import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import '../../shared/components/components.dart';
import '../../shared/shared_cubit/theme_cubit/cubit.dart';
import '../../shared/shared_cubit/theme_cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/var/var.dart';
import 'components/components.dart';
import 'cubit/profile_lib.dart';
import 'edit_profile/edit_profile_screen.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
          bool isDark = AppThemeCubit.get(context).isDark!;
          return BlocProvider(
            create: (context) => AppProfileCubit()..getProfile(isDark),
            child: BlocConsumer<AppProfileCubit, AppProfileStates>(
                listener: (context, state) {
                  if (state is AppGetProfileErrorState) {
                    errorSnackBar(
                        isDark: isDark, context: context, message: state.error);
                  }
                  if(state is AppProfileChangeAvailableErrorState){
                    errorSnackBar(context: context, message: state.error, isDark: isDark);
                  }
                  if(state is AppProfileChangeAvailableSuccessState){
                    successSnackBar(context: context, message: 'Success'.translate(context), isDark: isDark);
                  }
                },
                builder: (context, state) {
                  var cubit = AppProfileCubit.get(context);

                  return Scaffold(
                      appBar: myAppBar(
                          title: 'Profile Information'.translate(context),
                          actions: [
                            const MyAppBarLogo(),
                          ]
                      ),
                      body: SafeArea(
                        child: MainBackGroundImage(
                          centerDesign: false,
                          child: state is AppGetProfileLoadingState ? const Center(child: CircularProgressIndicator()) :
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //profile image section
                                  ProfileImage(
                                    gender: cubit.profileModel!.data!.gender!,
                                    imageName: cubit.profileModel!.data!.name!,
                                    imgUrl: cubit.profileModel!.data!
                                        .profileImage!,
                                  ),
                                  const SizedBox(height: 10,),
                                  //name and edit profile section
                                  NameAndEditProfileSection(
                                    isDark: isDark,
                                    name: cubit.profileModel!.data!.name!,
                                    onPressed: () async {
                                      var response = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfileScreen(
                                                      profileModel: cubit.profileModel!),
                                          ),
                                      );
                                      if (response == "updated") {
                                        cubit.getProfile(isDark);
                                        if (kDebugMode) {
                                          print('Updated from Edit Profile');
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  WorkerCounts(
                                    isDark: isDark,
                                    favorites: cubit.profileModel!.data!
                                        .favoriteCount!.toString(),
                                    rating: cubit.profileModel!.data!
                                        .ratingAverage.toString(),
                                    reviews: cubit.profileModel!.data!
                                        .reviewsCount.toString(),
                                  ),
                                 state is AppProfileChangeAvailableLoadingState ?const Padding(
                                   padding: EdgeInsets.all(20.0),
                                   child: CircularProgressIndicator(),
                                 ) : GestureDetector(
                                    onTap: (){
                                      if(cubit.profileModel!.data!.startTime==""){
                                        errorSnackBar(context: context, message: "Please Add your available time first".translate(context), isDark: isDark);
                                      }else{
                                        cubit.changeAvailability(isDark);
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 5),
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: cubit.availableButton,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          cubit.availability ==1 ?"available": "not available",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.darkMainTextColor
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //data profile data
                                  ProfileDataSection(
                                    isDark: isDark,
                                    title: cubit.profileModel!.data!.email!,
                                    icon: Icons.email_outlined,
                                  ),
                                  ProfileDataSection(
                                    isDark: isDark,
                                    isClickable: cubit.profileModel!.data!
                                        .startTime == "" ? true : false,
                                    onTap: () async {
                                      var response = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen(
                                                profileModel: cubit
                                                    .profileModel!,),
                                        ),
                                      );
                                      if (response == "updated") {
                                        cubit.getProfile(isDark);
                                        if (kDebugMode) {
                                          print('updated from Time');
                                        }
                                      }
                                    },
                                    title: cubit.profileModel!.data!
                                        .startTime == ""
                                        ? "Add your available time now"
                                        : "${cubit.profileModel!.data!
                                        .startTime!} ->  ${cubit.profileModel!
                                        .data!.endTime!}",
                                    icon: Icons.access_time_outlined,
                                  ),
                                  ProfileDataSection(
                                    isDark: isDark,
                                    title: lang == "en" ? "+963 ${cubit
                                        .profileModel!.data!.phone!}" : "${cubit
                                        .profileModel!.data!.phone!} 963+ ",
                                    icon: Icons.phone_android,
                                  ),
                                  ProfileDataSection(
                                    isDark: isDark,
                                    title: cubit.profileModel!.data!.category!,
                                    icon: Icons.category_outlined,
                                  ),
                                  ProfileDataSection(
                                    isDark: isDark,
                                    title: cubit.profileModel!.data!.address!,
                                    icon: Icons.location_on_outlined,
                                    isAddress: true,
                                    isClickable: cubit.profileModel!.data!
                                        .address == "" ? true : false,
                                    onTap: () async {
                                      var response = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen(
                                                profileModel: cubit
                                                    .profileModel!,),
                                        ),
                                      );
                                      if (response == "updated") {
                                        cubit.getProfile(isDark);
                                        if (kDebugMode) {
                                          print('updated from Address');
                                        }
                                      }
                                    },
                                  ),
                                  ProfileDataSection(
                                    isDark: isDark,
                                    title: cubit.profileModel!.data!.gender!
                                        .translate(context),
                                    icon: cubit.profileModel!.data!.gender ==
                                        "male"
                                        ? FontAwesomeIcons.person
                                        : FontAwesomeIcons.personDress,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  );
                }
            ),
          );
        }
    );
  }
}


class WorkerCounts extends StatelessWidget {
  final bool isDark;
  final String rating;
  final String favorites;
  final String reviews;
  const WorkerCounts(
      {
        super.key,
        required this.isDark,
        required this.favorites,
        required this.rating,
        required this.reviews,
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _section(
            context: context,
            title: 'Favorites'.translate(context),
            body: favorites,
            isFavorites: true
        ),
        const SizedBox(width: 10,),
        Expanded(
          flex: 5,
          child: Container(
            height: 68,
            decoration: BoxDecoration(
                color: isDark ? AppColors.darkSecondGrayColor : AppColors
                    .darkMainTextColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: isDark ? AppColors.darkShadowColor : AppColors
                          .lightShadowColor,
                      blurRadius: 15,
                      spreadRadius: 1
                  )
                ]
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FittedBox(
                    child: Text(
                      'RATING'.translate(context),
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.darkMainTextColor
                              : AppColors.lightMainTextColor
                      ),
                    ),
                  ),
                  Text(
                    //3.50 = 3.5
                      num.parse(rating)
                          .toStringAsFixed(1),
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? AppColors.darkMainTextColor
                              : AppColors.lightMainTextColor
                      )
                  ),
                  MyRatingBarIndicator(
                    isDark: isDark,
                    rating: double.parse(rating),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10,),
        _section(
            context: context,
            title: 'Reviews'.translate(context),
            body: reviews,
          onTap: (){

          }
        ),
      ],
    );
  }
  Expanded _section({
    required BuildContext context,
    required String title,
    required String body,
    bool isFavorites = false,
    void Function()? onTap
  }) {
    return Expanded(
      flex: 5,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSecondGrayColor : AppColors
                .darkMainTextColor,
            borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color:isDark?AppColors.darkShadowColor: AppColors.lightShadowColor,
                    blurRadius: 15,
                    spreadRadius: 1
                )
              ]
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  child: Text(
                    title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.darkMainTextColor
                            : AppColors.lightMainTextColor
                    ),
                  ),
                ),
                Text(
                    isFavorites ?favorites: reviews ,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.darkMainTextColor
                            : AppColors.lightMainTextColor
                    )
                ),
                // Icon(Icons.favorite,color: AppColors.lightRedColor,size: 15,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
