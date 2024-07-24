import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

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
                  color: isDark ? AppColors.darkSecondGrayColor : AppColors.lightGrayBackGroundColor
              )
          )
      ),
      child: TextField(
        maxLength: isPhoneNumber ? 9 : null,
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon ?? null,
              color: isDark
                  ? AppColors.darkSecondaryTextColor
                  : AppColors.lightSecondaryTextColor,
            ),
            suffixIcon: suffix != null
                ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(suffix ?? Icons.clear,
                  color: isDark
                      ? AppColors.darkSecondaryTextColor
                      : AppColors.lightSecondaryTextColor),
            )
                : null,
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: isDark ? AppColors.darkSecondaryTextColor : AppColors
                  .lightSecondaryTextColor,
            )
        ),
      ),
    );
  }
}