import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmt_club/styles/app_colors.dart';

class AppTheme {
  static LoginTheme loginTheme = LoginTheme(
    primaryColor: AppColors.backgroundColor,
    accentColor: Colors.white,
    errorColor: Colors.red,
    titleStyle: const TextStyle(
      color: Colors.greenAccent,
      letterSpacing: 4,
    ),
    bodyStyle: const TextStyle(
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
    ),
    textFieldStyle: GoogleFonts.roboto(
      fontSize: 16.0,
      color: Colors.black,
    ),
    buttonStyle: const TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
    cardTheme: const CardTheme(),
    switchAuthTextColor: Colors.black,
    inputTheme: InputDecorationTheme(
      filled: false,
      contentPadding: const EdgeInsets.all(20.0),
      errorStyle: const TextStyle(
        color: Colors.red,
      ),
      labelStyle:
          GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.basicColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.basicColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade700),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade400),
        borderRadius: BorderRadius.circular(15.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    buttonTheme: LoginButtonTheme(
      splashColor: Colors.green,
      backgroundColor: AppColors.topGradiant,
      highlightColor: AppColors.bottomGradiant,
      elevation: 9.0,
      highlightElevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //shape: CircleBorder(side: BorderSide(color: Colors.green)),
      // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
    ),
  );
}
