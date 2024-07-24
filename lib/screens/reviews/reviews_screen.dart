import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_me_worker/shared/Localization/app_localizations.dart';
import '../../model/reviews_model.dart';
import '../../shared/components/components.dart';
import '../../shared/shared_cubit/theme_cubit/cubit.dart';
import '../../shared/shared_cubit/theme_cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/var/var.dart';
import 'components/components.dart';

class ReviewsScreen extends StatelessWidget {
  final ReviewsModel reviewsModel;

  const ReviewsScreen({super.key, required this.reviewsModel});

  @override
  Widget build(BuildContext context) {
    List<ProgressBarIndicator> indicators = [];
    reviewsModel.data!.sort((a, b) =>
        b.reviews!.date!.compareTo(a.reviews!.date!));
    calculateTheRatings({required List<
        ProgressBarIndicator> indicators, required bool isDark}) {
      // Initialize a map to store the count of each rate
      Map<int, int> rateCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0, 0: 0};

      // Count the occurrences of each rate
      // Count the occurrences of each rate
      for (var review in reviewsModel.data!) {
        int? count = rateCounts[review.reviews!.rate!];
        if (count != null) {
          rateCounts[review.reviews!.rate!] = count + 1;
        } else {
          rateCounts[review.reviews!.rate!] = 1;
        }
      }

      // Calculate the percentage of each rate
      Map<int, double> ratePercentages = {};
      for (var entry in rateCounts.entries) {
        ratePercentages[entry.key] = entry.value / reviewsModel.data!.length;
      }

      // Create a list of ProgressIndicators

      for (var entry in ratePercentages.entries) {
        indicators.add(
            ProgressBarIndicator(
              text: entry.key.toString(), value: entry.value, isDark: isDark,));
      }
    }

    return BlocBuilder<AppThemeCubit, AppThemeStates>(
        builder: (context, state) {
          bool isDark = AppThemeCubit.get(context).isDark!;
          calculateTheRatings(indicators: indicators, isDark: isDark);
          return Scaffold(
            appBar: myAppBar(
                title: 'Reviews'.translate(context),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: lang == "en" ? Text(
                      '(${reviewsModel.data!.length}) Reviews',
                      style: TextStyle(
                        color: AppColors.lightMainGreenColor,
                      ),
                    ) : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Text(
                            "(${reviewsModel.data!.length})",
                            style: TextStyle(
                                color: AppColors.lightAccentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                          const SizedBox(width: 3,),
                          Text(
                            'Reviews'.translate(context),
                            style: TextStyle(
                                color: AppColors.lightMainGreenColor,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            ),
            body: SafeArea(
              child: MainBackGroundImage(
                centerDesign: false,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReviewsAndRatingSection(
                          isDark: isDark,
                          rating: double.parse(reviewsModel.message!),
                          ratingCount: reviewsModel.data!.length,
                          indicators: indicators,
                        ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ReviewCard(
                                        isDark: isDark,
                                        reviews: reviewsModel.data![index]
                                            .reviews!),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 1),
                                    width: double.infinity,
                                    height: 1,
                                    color: isDark ? AppColors
                                        .darkSecondGrayColor : AppColors
                                        .lightSecondaryTextColor.withOpacity(
                                        0.3),
                                  )
                              );
                            },
                            itemCount: reviewsModel.data!.length
                        ),
                      ]
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}








