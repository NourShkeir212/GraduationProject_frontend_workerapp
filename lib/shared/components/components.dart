import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import '../constants/consts.dart';
import '../shared_cubit/theme_cubit/cubit.dart';
import '../shared_cubit/theme_cubit/states.dart';
import '../styles/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../var/var.dart';

class MyAppBarLogo extends StatelessWidget {
  const MyAppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppConstant.LOGO_WITHOUT_TEXT_URL))),
    );
  }
}

AppBar myAppBar(
    {required String title,
    List<Widget>? actions,
    bool centerTitle = true,
    Widget? leading}) {
  return AppBar(
    centerTitle: centerTitle,
    title: Text(title),
    actions: actions,
    leading: leading,
  );
}

class MainBackGroundImage extends StatelessWidget {
  final Widget child;
  final bool centerDesign;
  final String textUnderImage;

  const MainBackGroundImage(
      {super.key,
      required this.child,
      this.centerDesign = true,
      this.textUnderImage = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Opacity(
            opacity: 0.1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(AppConstant.LOGO_WITH_TEXT_URL),
                  Text(textUnderImage ?? ''),
                ],
              ),
            ),
          ),
          Container(
              alignment: centerDesign ? Alignment.center : Alignment.topLeft,
              child: child)
        ],
      ),
    );
  }
}

String timeAgo({required DateTime date, required String lang}) {
  Duration diff = DateTime.now().difference(date);
  if (lang == "ar") {
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "سنة" : "سنوات"} مضت";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "شهر" : "أشهر"} مضت";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "أسبوع" : "أسابيع"} مضت";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "يوم" : "أيام"} مضت";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "ساعة" : "ساعات"} مضت";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "دقيقة" : "دقائق"} مضت";
    }
    return "الآن";
  } else {
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }
}

class MyButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? background;
  final bool isUpperCase;
  final double radius;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight? fontWeight;
  final double marginTop;
  final double marginLeft;
  final double marginBottom;
  final double marginRight;

  const MyButton({super.key,
    this.width = double.infinity,
    this.height = 40.0,
    this.background,
    this.isUpperCase = true,
    this.radius = 3.0,
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 14,
    this.fontWeight,
    this.marginTop = 0.0,
    this.marginLeft = 0.0,
    this.marginBottom = 0.0,
    this.marginRight = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: marginTop,
        left: marginLeft,
        right: marginRight,
        bottom: marginBottom,
      ),
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radius,
          ),
          color: background ?? AppColors.lightAccentColor.withOpacity(0.8)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        height: height,
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.normal),
        ),
      ),
    );
  }
}

class MyOutLinedButton extends StatelessWidget {
  final double height;
  final bool isUpperCase;
  final double radius;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;

  const MyOutLinedButton(
      {super.key,
      this.height = 40.0,
      this.isUpperCase = true,
      this.radius = 3.0,
      required this.onPressed,
      required this.text,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
        ),
      ),
    );
  }
}

class MyDropDownFormField extends StatelessWidget {
  const MyDropDownFormField({
    super.key,
    required this.isDark,
    required this.hintText,
    required this.onChanged,
    required this.items, this.prefixIcon, required this.value,
  });

  final bool isDark;
  final String hintText;
  final void Function(Object?) onChanged;
  final List<DropdownMenuItem<Object?>> items;
  final IconData? prefixIcon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      iconEnabledColor: isDark ? AppColors.darkMainGreenColor : AppColors
          .lightMainGreenColor,
      dropdownColor: Colors.white,
      style: TextStyle(
          color: isDark
              ? AppColors.darkMainTextColor
              : AppColors.lightMainTextColor,
          fontWeight: FontWeight.normal),
      hint: Text(hintText, style: TextStyle(
          fontSize: 14,
          color: isDark
              ? AppColors.darkSecondaryTextColor
              : AppColors.lightSecondaryTextColor),
      ),
      items: items,
      onChanged: (v)=> onChanged(v),
      decoration: InputDecoration(
          prefixIcon: prefixIcon == null ? null : Icon(
            prefixIcon,
            color: isDark
                ? AppColors.darkSecondaryTextColor
                : AppColors.lightSecondaryTextColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10)),
    );
  }
}

class MyTextButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final bool isDark;

  const MyTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.size = 14,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    required this.isDark
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
            color: color==Colors.black ? isDark?AppColors.darkMainGreenColor: AppColors.lightMainGreenColor:color,
            fontSize: size,
            fontWeight: fontWeight
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType type;
  final IconData? prefixIcon;
  final IconData? suffix;
  final Function()? suffixPressed;
  final String? Function(String?)? validator;
  final bool isPhoneNumber;
  final Color prefixIconColor;
  final Color backColor;
  final double radius;
  final int maxLine;
  final bool isWithoutPrefixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  void Function()? onTap;
  final bool isDark;
  final bool readOnly;

  MyTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isPassword = false,
      required this.type,
      this.prefixIcon,
      this.suffix,
      this.suffixPressed,
      this.validator,
      this.isPhoneNumber = false,
      this.prefixIconColor = AppColors.textGray2Color,
      this.backColor = Colors.transparent,
      this.radius = 35.0,
      this.maxLine = 1,
      this.isWithoutPrefixIcon = false,
      this.onChanged,
      this.onFieldSubmitted,
      required this.isDark,
      this.onTap,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: backColor),
        child: TextFormField(
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged, cursorColor: isDark ? AppColors.darkAccentColor : AppColors.lightAccentColor,
          maxLines: maxLine,
          maxLength: isPhoneNumber ? 9 : null,
          obscureText: isPassword,
          keyboardType: type,
          controller: controller,
          validator: validator,
          style: TextStyle(
              color: isDark
                  ? AppColors.darkMainTextColor
                  : AppColors.lightMainTextColor,
              fontWeight: FontWeight.normal),
          decoration: InputDecoration(
              prefixIcon: isWithoutPrefixIcon
                  ? null
                  : Icon(
                      prefixIcon,
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
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isDark
                          ? AppColors.darkSecondaryTextColor
                          : AppColors.lightSecondaryTextColor),
                  borderRadius: BorderRadius.circular(radius)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isDark
                          ? AppColors.darkSecondaryTextColor
                          : AppColors.lightSecondaryTextColor),
                  borderRadius: BorderRadius.circular(radius)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isDark
                          ? AppColors.darkSecondaryTextColor
                          : AppColors.lightSecondaryTextColor),
                  borderRadius: BorderRadius.circular(radius)),
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.darkSecondaryTextColor
                      : AppColors.lightSecondaryTextColor),
              contentPadding: const EdgeInsets.all(10)),
        ),
      ),
    );
  }
}

//----------------------------snack bars-----------------------
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorSnackBar(
    {required BuildContext context,
    required String message,
    required bool isDark}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: isDark ? AppColors.darkRedColor : AppColors.lightRedColor,
    content: Text(message),
    duration: const Duration(milliseconds: 1000),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ));
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> successSnackBar(
    {required BuildContext context,
      required String message,
      required bool isDark}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: isDark ? AppColors.darkMainGreenColor : AppColors.lightMainGreenColor,
    content: Text(message),
    duration: const Duration(milliseconds: 1000),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ));
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> warningSnackBar(
    {required String message,
  required BuildContext context,
  required bool isDark,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor:
        isDark ? AppColors.darkAccentColor : AppColors.lightAccentColor,
    content: Text(message),
    duration: const Duration(milliseconds: 1000),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ));
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> bottomErrorSnackBar({
  required BuildContext context,
  required String title,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.lightRedColor,
    content: Text(title),
    duration: const Duration(milliseconds: 1000),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ));
}

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
      return Divider(
        color: AppThemeCubit.get(context).isDark!
            ? AppColors.darkSecondaryTextColor
            : AppColors.lightSecondaryTextColor,
        thickness: 0.5,
      );
    });
  }
}

//----------------------------Text-----------------------
class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight fontWeight;
  const ExpandableTextWidget({
    super.key,
    required this.text,
    this.size = 14,
    this.color,
    this.fontWeight = FontWeight.normal,
  });

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  late double fontSize;
  late Color color;
  late FontWeight fontWeight;
  bool hiddenText = true;

  @override
  void initState() {
    super.initState();
    double textHeight = 50;
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
    fontSize = widget.size;
    color = widget.color ?? Colors.grey;
    fontWeight = widget.fontWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              height: 1.5,
              color: color == Colors.grey ? const Color(0xFF8f837f) : color,
              size: fontSize,
              text: firstHalf,
              fontWeight: fontWeight,
            )
          : Column(
              children: [
                SmallText(
                    height: 1.5,
                    color: const Color(0xFF8f837f),
                    size: 16,
                    text: hiddenText
                        ? ('$firstHalf....')
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText
                            ? 'Show more'.translate(context)
                            : "Show less".translate(context),
                        color: AppColors.lightMainGreenColor,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.lightMainGreenColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double? size;
  final TextOverflow overflow;

  const BigText({
    super.key,
    this.color,
    this.size,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1,
        overflow: overflow,
        style: TextStyle(
            color: color ?? AppColors.lightMainTextColor,
            fontSize: size ?? 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto'));
  }
}

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double? size;
  final double? height;
  final bool isOverFlow;
  final FontWeight fontWeight;

  const SmallText({
    super.key,
    this.color,
    this.size,
    this.height,
    this.isOverFlow = false,
    this.fontWeight = FontWeight.normal,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        // maxLines: 2,
        style: TextStyle(
            //overflow:isOverFlow ?TextOverflow.ellipsis,
            height: height ?? 1.2,
            color: color ?? const Color(0xFFccc7c5),
            fontSize: size ?? 12,
            fontWeight: fontWeight));
  }
}

//-------------------------- navigation--------------------------------

void back(context)=>Navigator.pop(context);

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

//----------------------------Dialog----------------------
Future myCustomDialog(
    {Widget? body,
    required BuildContext context,
    required String title,
    required String desc,
    required DialogType dialogType,
    void Function()? btnOkOnPress,
    bool isDeleteAccount = false,
    required bool isDark}) {
  return AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.topSlide,
    headerAnimationLoop: false,
    title: title,
    titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 20,
        color: isDark
            ? AppColors.darkMainTextColor
            : AppColors.lightMainTextColor),
    descTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: isDark
            ? AppColors.darkMainTextColor
            : AppColors.lightMainTextColor),
    desc: desc,
    btnCancelColor:
        isDark ? AppColors.darkAccentColor : AppColors.lightAccentColor,
    btnOkColor:
        isDark ? AppColors.darkMainGreenColor : AppColors.lightMainGreenColor,
    dialogBackgroundColor: isDark
        ? AppColors.darkSecondGrayColor
        : AppColors.lightGrayBackGroundColor,
    btnOkOnPress: btnOkOnPress,
    btnCancelOnPress: () {},
    body: isDeleteAccount ? body : null,
    btnCancelText: "Cancel".translate(context),
    btnOkText: "Ok".translate(context),
  ).show();
}

class MyRatingBarIndicator extends StatelessWidget {
  final double rating;
  final double? iconSize;
  final bool isDark;

  const MyRatingBarIndicator(
      {super.key, required this.rating, this.iconSize, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemCount: 5,
      rating: rating,
      itemSize: iconSize ?? 14,
      unratedColor: isDark
          ? AppColors.darkSecondaryTextColor
          : AppColors.lightSecondaryTextColor.withOpacity(0.5),
      itemBuilder: (_, __) => Icon(
        Icons.star,
        color: isDark ? AppColors.darkAccentColor : AppColors.lightAccentColor,
      ),
    );
  }
}

class NoDataFount extends StatelessWidget {
  final String? message;

  const NoDataFount({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/images/in_app_images/app_logo.png',
              fit: BoxFit.contain,
              height: 200,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Opacity(
            opacity: 0.3,
            child: FittedBox(
              child: Text(
                message ?? "There is no data found".toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit boxFit;
  final bool isDark;
  final bool isWorkerProfile;

  const CustomCachedNetworkImage(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width,
      this.radius,
      this.boxFit = BoxFit.fill,
      required this.isDark,
      this.isWorkerProfile = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 3.0, top: 5.0, bottom: 5.0),
        child: imageUrl != ""
            ? CachedNetworkImage(
                color: Colors.transparent,
                height: height ?? 130,
                width: width ?? 100,
                imageUrl: AppConstant.BASE_URL + imageUrl,
                imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(radius ?? 8),
                  child: Image(
                    filterQuality: FilterQuality.medium,
                    image: imageProvider,
                    fit: boxFit,
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  direction: lang == "en"
                      ? ShimmerDirection.ltr
                      : ShimmerDirection.rtl,
                  baseColor: isDark
                      ? AppColors.darkSecondGrayColor
                      : AppColors.lightSecondaryTextColor.withOpacity(0.4),
                  highlightColor: isDark
                      ? AppColors.darkSecondGrayColor.withOpacity(0.3)
                      : AppColors.lightGrayBackGroundColor.withOpacity(0.3),
                  child: Skeleton(
                    isDark: isDark,
                    radius: radius,
                    height: height,
                    width: width,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 30,
                ),
              )
            : isWorkerProfile
                ? Container()
                : SizedBox(
                    width: 60,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: isDark
                            ? AppColors.lightSecondaryTextColor
                            : AppColors.darkSecondaryTextColor,
                      ),
                    )));
  }
}

class MyLiquidRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final bool isDark;
  const MyLiquidRefresh(
      {super.key,
      required this.onRefresh,
      required this.child,
      required this.isDark});

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: onRefresh,
      color:
          isDark ? AppColors.darkMainGreenColor : AppColors.lightMainGreenColor,
      height: 100,
      showChildOpacityTransition: false,
      child: child,
    );
  }
}

//-------------------Shimmer Loading---------------------------
class Skeleton extends StatelessWidget {
  final bool isDark;
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;

  const Skeleton(
      {super.key,
      required this.isDark,
      this.width,
      this.height,
      this.color,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: color ??
              (isDark
                  ? AppColors.darkSecondGrayColor
                  : AppColors.lightGrayBackGroundColor),
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 16))),
    );
  }
}

class WorkerLoadingCard extends StatelessWidget {
  final bool isDark;

  const WorkerLoadingCard({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => Shimmer.fromColors(
            direction:
                lang == "en" ? ShimmerDirection.ltr : ShimmerDirection.rtl,
            baseColor: isDark
                ? AppColors.darkSecondGrayColor
                : AppColors.lightSecondaryTextColor.withOpacity(0.4),
            highlightColor: isDark
                ? AppColors.darkSecondGrayColor.withOpacity(0.3)
                : AppColors.lightGrayBackGroundColor.withOpacity(0.3),
            child: workerCard()),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: 10,
      ),
    );
  }

  Widget workerCard() {
    return Row(
      children: [
        Skeleton(
          isDark: isDark,
          height: 120,
          width: 120,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(isDark: isDark, width: 80),
            const SizedBox(
              height: 8,
            ),
            Skeleton(isDark: isDark),
            const SizedBox(
              height: 8,
            ),
            Skeleton(isDark: isDark),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(child: Skeleton(isDark: isDark)),
                const SizedBox(
                  width: 30,
                ),
              ],
            )
          ],
        ))
      ],
    );
  }
}

class DefaultShimmerLoading extends StatelessWidget {
  const DefaultShimmerLoading({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: lang == "en" ? ShimmerDirection.ltr : ShimmerDirection.rtl,
      baseColor: isDark
          ? AppColors.darkSecondGrayColor
          : AppColors.lightSecondaryTextColor.withOpacity(0.4),
      highlightColor: isDark
          ? AppColors.darkSecondGrayColor.withOpacity(0.3)
          : AppColors.lightGrayBackGroundColor.withOpacity(0.3),
      child: Center(
        child: Skeleton(
          isDark: isDark,
        ),
      ),
    );
  }
}
