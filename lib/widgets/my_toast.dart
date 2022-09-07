// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mmt_club/styles/app_colors.dart';

enum ToastState { ERROR, WARNING, SUCCESS }

class MyToast {
  static show(
      {required BuildContext context, String? text, ToastState? toastState}) {
    Color color;
    switch (toastState!.index) {
      case 0:
        color = AppColors.error;
        break;
      case 1:
        color = AppColors.warning;
        break;
      default:
        color = AppColors.success;
        break;
    }
    // var snackBar = SnackBar(
    //   content: Text(
    //     text!,
    //     style: TextStyle(color: AppColors.textWhite),
    //   ),
    //   backgroundColor: color,
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Fluttertoast.showToast(
      msg: text ?? "",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
    );
  }
}
