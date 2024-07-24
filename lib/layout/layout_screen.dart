import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/components.dart';
import '../shared/shared_cubit/theme_cubit/cubit.dart';
import '../shared/shared_cubit/theme_cubit/states.dart';
import '../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLayoutCubit()..getProfile(),
      child: BlocConsumer<AppLayoutCubit, AppLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppLayoutCubit.get(context);
            return BlocBuilder<AppThemeCubit, AppThemeStates>(
                builder: (context, state) {
                  bool isDark = AppThemeCubit.get(context).isDark!;
                  return Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      centerTitle: true,
                      leading: InkWell(
                          onTap: () {
                            cubit.bottomNavBarCurrentIndex = 0;
                            cubit.changeBottomNavBar(0);
                          },
                          child: const MyAppBarLogo()
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_outlined,
                          ),
                        ),
                      ],
                      title: Text(
                          ''
                      ),
                    ),
                    bottomNavigationBar: CurvedNavigationBar(
                      backgroundColor: isDark ? AppColors.darkBackGroundColor : AppColors.lightBackGroundColor,
                      height: 50,
                      index: cubit.bottomNavBarCurrentIndex,
                      color: isDark ? AppColors.darkSecondGrayColor : AppColors.lightMainGreenColor,
                      onTap: (index) => cubit.changeBottomNavBar(index),
                      items: [
                        Icon(
                          Icons.home,
                          color: isDark ? AppColors.darkMainGreenColor : Colors
                              .white,
                        ),
                        Icon(
                          cubit.bottomNavBarCurrentIndex != 1 ? Icons
                              .favorite_border : Icons.favorite,
                          color: isDark ? AppColors.darkMainGreenColor : Colors
                              .white,
                        ),
                        Icon(
                          Icons.apps,
                          color: isDark ? AppColors.darkMainGreenColor : Colors
                              .white,
                        ),
                        Icon(
                          Icons.settings,
                          color: isDark ? AppColors.darkMainGreenColor : Colors
                              .white,
                        ),
                      ],
                    ),
                    body: cubit.screens[cubit.bottomNavBarCurrentIndex],
                  );
                }
            );
          }
      ),
    );
  }
}