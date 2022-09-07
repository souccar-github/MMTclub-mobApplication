import 'package:flutter/material.dart';

import '../Localization/localization.dart';
import '../styles/app_colors.dart';

class TapToRefreesh extends StatelessWidget {
  final VoidCallback onTap;
  const TapToRefreesh({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              Localization.of(context).getTranslatedValue("refresh"),
            )),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.refresh,
              color: AppColors.basicColor,
            ),
          ),
        )
      ],
    );
  }
}
