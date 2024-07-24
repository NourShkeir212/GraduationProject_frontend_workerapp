import 'package:flutter/material.dart';
import '../../../shared/Localization/app_localizations.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/dimensions.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/var/var.dart';
import '../cubit/settings_lib.dart';


class GeneralSection extends StatelessWidget {
  final BuildContext context;
  final AppSettingsCubit cubit;
  final void Function()? languagePressed;
  final void Function()? modePressed;
  final void Function()? changePasswordPressed;
  final void Function()? deleteAccountPressed;
  final bool isDark;
  final Dimensions dimensions;
  const GeneralSection({
    Key? key,
    required this.cubit,
    this.languagePressed,
    this.modePressed,
    this.changePasswordPressed,
    this.deleteAccountPressed,
    required this.context,
    required this.isDark, required this.dimensions,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color:isDark ?AppColors.darkSecondGrayColor:AppColors.lightBackGroundColor,
        border: Border.all(
            width: 1,
            color:isDark ?AppColors.darkBorderColor:AppColors.lightBorderColor
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'General'.translate(context),
            overflow: TextOverflow.ellipsis,
            style:  Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 19)
          ),
          const SizedBox(height: 10),
          Sections(
            dimensions: dimensions,
            isDark: isDark,
            leftTitle: 'Language'.translate(context),
            rightTitle: lang=="en" ? "English" :"العربية",
            onTap: languagePressed,
          ),
          Sections(
            dimensions :dimensions,
            leftTitle: 'Theme'.translate(context),
            rightTitle: isDark ? "Dark theme".translate(context) : "Light theme".translate(context),
            onTap: modePressed,
            isDark: isDark,
          ),
           Sections(
             dimensions :dimensions,
             leftTitle: 'App Version'.translate(context),
             rightTitle: '1.0',
             rightIconCondition: false,
             isDark: isDark,
          ),
          Sections(
            dimensions :dimensions,
            leftTitle: 'Reset Password'.translate(context),
            rightIconCondition: true,
            onTap: changePasswordPressed,
            isDark: isDark,
          ),
          Sections(
            dimensions :dimensions,
            leftTitle: 'Delete Account'.translate(context),
            isTheLastSection: true,
            onTap: deleteAccountPressed,
            isDark: isDark,
          )
        ],
      ),
    );
  }
}

class Sections extends StatelessWidget {

  final String leftTitle;
  final String rightTitle;
  final void Function()? onTap;
  final bool rightIconCondition;
  final bool rightTitleCondition;
  final bool isTheLastSection;
  final bool isDark;
  final Dimensions dimensions;
  const Sections({
    Key? key,
    required this.leftTitle,
    this.rightTitle = "",
    this.onTap,
    this.rightIconCondition = true,
    this.rightTitleCondition = true,
    this.isTheLastSection = false,
    required this.isDark, required this.dimensions

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.only(top: dimensions.height5, bottom: dimensions.height5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    leftTitle,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                        fontSize: dimensions.font13
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(rightTitleCondition)
                      Text(
                          rightTitle,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: dimensions.font14,
                              color: isDark
                                  ? AppColors.darkSecondaryTextColor
                                  : AppColors.lightSecondaryTextColor
                          )
                      ),
                    if(rightIconCondition & rightTitleCondition == true)
                       SizedBox(width: dimensions.height10,),
                    if(rightIconCondition)
                      Icon(
                        Icons.arrow_forward_ios,
                        color: isDark ? AppColors.darkAccentColor : AppColors
                            .lightAccentColor,
                        size: dimensions.height18,
                      ),
                  ],
                ),
              ],
            ),
            if(isTheLastSection)
               SizedBox(height: dimensions.height10,),
            if(!isTheLastSection)
              Container(
                  padding:  EdgeInsets.only(top: dimensions.height5),
                  child: const MyDivider()
              )
          ],
        ),
      ),
    );
  }
}