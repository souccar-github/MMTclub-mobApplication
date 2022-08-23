import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/Models/Project/home_model.dart';
import 'package:mmt_club/Models/Project/level_model.dart';
import 'package:mmt_club/Models/Project/profile_model.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../Localization/Localization.dart';
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
    double pointBalance =
        homeInfo?.level?.point ?? profileInfo?.level?.point ?? 0.0;
    LevelModel? level = homeInfo?.level ?? profileInfo?.level;
    String? phone = profileInfo?.username;
    Color progressBarColor = _getColorFromHex(strProgressBarColor);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.h),
          child: Text(
            Localization.of(context).getTranslatedValue("Points_Balance"),
            style: TextStyle(
              fontSize: 16.0.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SleekCircularSlider(
          innerWidget: (percentage) {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Text(pointBalance.toString()),
                  Image.asset(
                    "assets/images/pcoins.png",
                  ),
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
          initialValue: pointBalance,
          min: 0,
          max: 100,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            level != null
                ? Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Text(
                      Localization.of(context)
                              .getTranslatedValue("your_level") +
                          " " +
                          level.name,
                      style: TextStyle(
                        fontSize: 16.0.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
            phone != null
                ? Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Text(
                      Localization.of(context)
                              .getTranslatedValue("phone_number") +
                          " : " +
                          phone,
                      style: TextStyle(
                        fontSize: 16.0.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}

// class CustomCircularSliderInfo {
//   String? phone;
//   LevelModel? level;
//   String? pointBalance;
//   CustomCircularSliderInfo(this.phone, this.level, this.pointBalance);

//   static getInfoFromHome(HomeModel homeModel) {
//     this. level = homeModel.level;
    
//   }
// }
