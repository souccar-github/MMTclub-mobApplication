import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../styles/app_colors.dart';

class HourGlass extends StatelessWidget {
  const HourGlass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SpinKitPouringHourGlassRefined(
          color: AppColors.basicColor.withOpacity(0.7),
        ),
      ),
    );
  }
}
