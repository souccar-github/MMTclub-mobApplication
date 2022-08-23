import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';

class CustomText extends StatelessWidget {
  String? text;
  final onPressed;
  final icon;
  final double? size;
  final textColor;
  final iconColor;
  final background;
  CustomText({
    Key? key,
    this.text = null,
    this.onPressed,
    this.icon,
    this.size = null,
    this.textColor = null,
    this.background = null,
    this.iconColor = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: NeumorphicButton(
        onPressed: onPressed,
        style: NeumorphicStyle(
            color: background ?? AppColors.textGrey,
            shape: NeumorphicShape.concave,
            boxShape:
                NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text != null
                ? Text(
                    text!,
                    style: TextStyle(
                      color: textColor ?? Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
            SizedBox(width: 5.w),
            Icon(
              icon,
              color: iconColor ?? Colors.black.withOpacity(0.65),
              size: size ?? 10.h,
            )
          ],
        ),
      ),
    );
  }
}
