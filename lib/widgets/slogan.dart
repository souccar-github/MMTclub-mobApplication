import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Localization/localization.dart';
import '../styles/app_colors.dart';

class Slogan extends StatelessWidget {
  const Slogan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: Text(Localization.of(context).getTranslatedValue("NATURE"),
              style: GoogleFonts.tajawal(
                fontSize: 22,
                color: AppColors.basicColor,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 16.h),
          child: Text(
              Localization.of(context).getTranslatedValue("isourinspiration"),
              style: GoogleFonts.tajawal(
                fontSize: 22,
                color: AppColors.basicColor,
              )),
        ),
      ],
    );
  }
}
