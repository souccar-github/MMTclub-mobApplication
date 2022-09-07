import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/Models/Project/home_model.dart';
import 'package:mmt_club/Models/Project/level_model.dart';
import 'package:mmt_club/Models/Project/profile_model.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../Localization/localization.dart';
import '../styles/app_colors.dart';

class CustomCircularSlider extends StatelessWidget {
  final ProfileModel? profileInfo;
  final HomeModel? homeInfo;
  const CustomCircularSlider({Key? key, this.profileInfo, this.homeInfo})
      : super(key: key);

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return AppColors.basicColor;
  }

  @override
  Widget build(BuildContext context) {
    String strProgressBarColor =
        homeInfo?.level?.color ?? profileInfo?.level?.color ?? "";
    LevelModel? level = homeInfo?.level ?? profileInfo?.level;

    double pointBalance =
        homeInfo?.userPoints ?? profileInfo?.userPoints ?? 10.0;

    // double minPoints =
    //     homeInfo?.level!.fromPoint ?? profileInfo?.level!.fromPoint ?? 0.0;

    double maxPoints =
        homeInfo?.level!.toPoint ?? profileInfo?.level!.toPoint ?? 100.0;

    String? phone = profileInfo?.username;
    Color progressBarColor = _getColorFromHex(strProgressBarColor);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.h),
          child: Text(
            Localization.of(context).getTranslatedValue("Points_Balance"),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        SleekCircularSlider(
          max: maxPoints,
          initialValue: pointBalance,
          innerWidget: (percentage) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pointBalance.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    "point",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: progressBarColor),
                  ),
                  // SizedBox(
                  //     height: 50.w,
                  //     width: 50.w,
                  //     child: Image.asset("assets/images/pcoins.png")),
                ],
              ),
            );
          },
          appearance: CircularSliderAppearance(
            size: 150.h,
            customWidths: CustomSliderWidths(
              progressBarWidth: 25.w,
            ),
            customColors: CustomSliderColors(
              progressBarColor: progressBarColor,
              trackColor: AppColors.textBlack,
            ),
            infoProperties: InfoProperties(
              bottomLabelText: "point",
              bottomLabelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: (150 / 10.0).h,
                color: progressBarColor,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (level != null)
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Text(
                  Localization.of(context).getTranslatedValue("your_level") +
                      " " +
                      level.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            if (phone != null)
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Text(
                  Localization.of(context).getTranslatedValue("phone_number") +
                      " : " +
                      phone,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
