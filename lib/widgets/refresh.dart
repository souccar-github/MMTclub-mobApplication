import 'package:flutter/material.dart';
import 'package:mmt_club/styles/app_text.dart';
import 'package:mmt_club/widgets/neum.dart';

import '../Localization/localization.dart';
import '../styles/app_colors.dart';

class TapToRefreesh extends StatelessWidget {
  final VoidCallback onTap;
  const TapToRefreesh({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              Localization.of(context).getTranslatedValue("refresh"),
              style: AppTextStyle.titeTextTheme(context)
                  .copyWith(fontWeight: FontWeight.w600),
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
