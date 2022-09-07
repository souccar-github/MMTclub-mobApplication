import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/constants.dart';
import 'package:mmt_club/styles/app_colors.dart';

import '../../../Localization/localization.dart';

class CustomAppBar extends StatelessWidget {
  final double points;

  const CustomAppBar({Key? key, required this.points}) : super(key: key);

  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          SizedBox(
            height: 75.h,
            width: 40.w,
            child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: AppColors.textBlack,
                  //backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
          ),
          const Spacer(),
          Text(
            Localization.of(context).getTranslatedValue("product_details"),
            style: CustomTextStyle.appBarTextTheme(context),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.basicColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(points.toString(),
                      style: TextStyle(color: AppColors.textWhite)),
                  Image.asset("assets/images/pcoins.png"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
