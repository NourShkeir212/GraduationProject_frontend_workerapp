import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import 'package:hire_me_worker/shared/var/var.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/consts.dart';
import '../../../shared/styles/colors.dart';
import 'package:intl/intl.dart';
class ProfileDataSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isAddress;
  final bool isClickable;
  final bool isDark;
  final void Function()? onTap;

  ProfileDataSection({
    Key? key,
    required this.title,
    required this.icon,
    this.isAddress = false,
    this.isClickable = false,
    this.onTap,
    required this.isDark

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isClickable ? onTap : () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
            color: isDark ?AppColors.darkSecondGrayColor : AppColors.lightGrayBackGroundColor,
            borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 1,
              color: isDark?Colors.grey[700]! : Colors.grey[400]!,
          ),
          boxShadow: [
            BoxShadow(
               offset: const Offset(0,0),
              color: isDark ?AppColors.darkShadowColor :AppColors.lightShadowColor,
              blurRadius: 5,
              spreadRadius: 1
            )
          ]
        ),
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isDark ? AppColors.darkMainGreenColor :AppColors.lightMainGreenColor,
                ),
                const SizedBox(width: 15,),
                Flexible(
                  child: Text(
                    isAddress?
                    title == "" ? 'Add your address now'.translate(context)
                        : title:title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String imgUrl;
  final double height;
  final double width;
  void Function()? onTap;
  final String imageName;
  final String gender;

  ProfileImage({
    Key? key,
    required this.imgUrl,
    this.height = 150,
    this.width = 150,
    this.onTap,
    required this.imageName,
    required this.gender
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          GestureDetector(
            onTap: () {
              imgUrl != ""
                  ? navigateTo(
                  context,
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.9),
                      child: Center(
                        child: Hero(
                          tag: imageName,
                          child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Container(
                                  height: height,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    gender == "male"
                                        ? Icons.person_outline
                                        : Icons.person_2_outlined,
                                    size: 90,
                                  ),
                                ),
                            imageUrl: AppConstant.BASE_URL + imgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ))
                  : null;
            },
            child: Hero(
              tag: imageName,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(110)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(110),
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) =>
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              gender == "male" ? Icons.person_outline : Icons
                                  .person_2_outlined,
                              size: 120,
                            ),
                          ),
                      imageUrl: AppConstant.BASE_URL + imgUrl,
                      fit: BoxFit.cover,
                      height: 110,
                      width: 110,
                      placeholder: (context, _) {
                        return Container(
                          color: Colors.grey.shade300,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
    );
  }
}


class NameAndEditProfileSection extends StatelessWidget {
  final String name;
  final void Function() onPressed;
  final bool isDark;

  const NameAndEditProfileSection({
    super.key,
    required this.name,
    required this.onPressed,
    required this.isDark
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
      [
        Flexible(
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 22
            ),
          ),
        ),
        MyOutLinedButton(
          textColor: isDark ?AppColors.darkMainTextColor :AppColors.lightMainTextColor,
          text: 'Edit profile'.translate(context),
          onPressed: onPressed,
          radius: 8,
        ),
      ],
    );
  }
}


class StartAndEndTimeSection extends StatelessWidget {
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final bool isDark;


  const StartAndEndTimeSection({
    super.key,
    required this.isDark,
    required this.startTimeController,
    required this.endTimeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            timeSelection(
                context: context,
                hintText: 'Start Time',
                controller: startTimeController,
                isStartTime: true
            ),
            const SizedBox(width: 10,),
            timeSelection(
                context: context,
                hintText: 'End Time',
                controller: endTimeController,
                isStartTime: false
            ),
          ],
        ),
      ],
    );
  }

  Expanded timeSelection({
    required TextEditingController controller,
    required String hintText,
    required BuildContext context,
    required bool isStartTime,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              isStartTime?"Start Time" :'End Time',
            style:Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14
            )
          ),
          SizedBox(height:3,),
          MyTextField(
            validator: (value) {
              if (value!.isEmpty) {
                return '$hintText cannot be empty';
              }
              return null;
            },
            readOnly: true,
            onTap: () async{
              TimeOfDay? pickedTime = await  showTimePicker(
                  context: context, initialTime: TimeOfDay.now()
              );
              if (pickedTime != null) {
                print(pickedTime.format(context)); // Output: 10:51 PM
                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                if(isStartTime){
                  startTime = _formatTimeToAmPm(parsedTime.toString());
                  controller.text =startTime;
                  backEndStartTime = DateFormat('H:mm').format(parsedTime);
                }else{
                  endTime = _formatTimeToAmPm(parsedTime.toString());
                  controller.text = endTime;
                  backEndEndTime = DateFormat('H:mm').format(parsedTime);
                }
              } else {
                print("Time is not selected");
              }

            },
            hintText: hintText,
            controller: controller,
            type: TextInputType.none,
            isDark: isDark,
            radius: 50,
            prefixIcon: Icons.access_time_outlined,
          ),
        ],
      ),
    );
  }
  String _formatTimeToAmPm(String dateTimeString) {
    // Parse the date time string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Create a DateFormat object with lowercase 'h' for 12-hour format and 'a' for am/pm
    DateFormat formatter = DateFormat('h:mm a');

    // Format the DateTime object into a string with am/pm
    String formattedTime = formatter.format(dateTime);
    return formattedTime;
  }



}

