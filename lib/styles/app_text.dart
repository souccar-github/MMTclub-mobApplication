import 'package:flutter/material.dart';
import 'package:mmt_club/styles/app_colors.dart';

class AppTextStyle {
  static TextStyle appBarTextTheme(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle customButtonTextTheme(
      BuildContext context, Color? textColor) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.bold,
        color: textColor ?? Colors.black.withOpacity(0.5));
  }

  static TextStyle itemListTextTheme(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!;
  }

  static TextStyle titeTextTheme(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle caption(BuildContext context) {
    return Theme.of(context).textTheme.caption!.copyWith(
          color: AppColors.basicColor,
        );
  }

  static TextStyle decTextTheme(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!;
  }

  static TextStyle labelText1Theme(BuildContext context) {
    return Theme.of(context).textTheme.headline6!;
  }

  static TextStyle labelText2Theme(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Colors.black.withOpacity(0.5),
        );
  }

  static TextStyle labelText3Theme(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!;
  }
}
