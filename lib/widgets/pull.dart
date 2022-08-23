import 'package:flutter/material.dart';

import '../Localization/Localization.dart';
import '../styles/app_colors.dart';

class PullToRefreesh extends StatelessWidget {
  final onTap;
  const PullToRefreesh({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              Localization.of(context).getTranslatedValue("pull"),
            )),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.arrow_circle_down,
              color: AppColors.basicColor,
            ),
          ),
        )
      ],
    );
  }
}
