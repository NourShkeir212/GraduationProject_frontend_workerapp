import 'package:flutter/material.dart';
import 'colors.dart';


class AppThemes {

  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.lightMainGreenColor,
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.lightMainGreenColor
      ),
      scaffoldBackgroundColor: AppColors.lightBackGroundColor,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.lightMainGreenColor,
          ),
          backgroundColor: Colors.grey[100],
          elevation: 2,
          titleTextStyle: TextStyle(
            color: AppColors.lightAccentColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.lightMainGreenColor,
          )
      ),
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              color: AppColors.lightMainTextColor,
              fontSize: 16
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            color: AppColors.lightMainTextColor,
          ),
          bodyLarge: TextStyle(
              fontWeight: FontWeight.w800
          ),
          headlineLarge: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColors.lightMainTextColor
          )
      ),
      chipTheme: const ChipThemeData(
        labelStyle: TextStyle(
          fontSize: 12, color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      )
  );


  static ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.darkMainGreenColor,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.darkMainGreenColor,
      ),
      scaffoldBackgroundColor: AppColors.darkBackGroundColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: AppColors.darkMainGreenColor
        ),
        backgroundColor: AppColors.darkSecondGrayColor,
        elevation: 2,
        titleTextStyle: TextStyle(
          color: AppColors.darkAccentColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        actionsIconTheme: IconThemeData(
          color: AppColors.darkMainGreenColor,
        ),
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(
              color: AppColors.darkMainTextColor,
              fontWeight: FontWeight.w800
          ),
          titleMedium: TextStyle(
              color: AppColors.darkMainTextColor,
              fontSize: 16
          ),
          titleSmall: TextStyle(
              fontSize: 12,
              color: AppColors.darkSecondaryTextColor
          ),
          headlineLarge: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColors.darkMainTextColor
          )
      ),
      chipTheme: const ChipThemeData(
        labelStyle: TextStyle(
          fontSize: 12, color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      )
  );

}