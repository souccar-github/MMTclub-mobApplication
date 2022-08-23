import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/bloc/generalSettingBloc/general_setting_bloc.dart';
import 'package:mmt_club/widgets/shimmer_news.dart';

import '../Localization/Localization.dart';
import '../styles/app_colors.dart';
import '../widgets/logo.dart';
import '../widgets/shimmer_category.dart';
import '../widgets/slogan.dart';

class ContactsUS extends StatelessWidget {
  static String routeName = "/contactUs";

  const ContactsUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GeneralSettingBloc generalSettingBloc = GeneralSettingBloc();
    generalSettingBloc.add(GetGeneralSettingEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("contactUs"),
          style: TextStyle(fontSize: 17, color: AppColors.textBlack),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textBlack,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logommt.png',
              fit: BoxFit.contain,
            ),
            const Slogan(),
            const Spacer(),
            BlocBuilder(
              bloc: generalSettingBloc,
              builder: (context, state) {
                if (state is GetGeneralSettingWaiting) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (state is GetGeneralSettingSuccessfully) {
                  return Expanded(
                    child: Column(
                      children: [
                        Text(
                            Localization.of(context)
                                .getTranslatedValue("contactUs"),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white,
                                    elevation: 1),
                                child: const Icon(FontAwesomeIcons.facebook)),
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white,
                                    elevation: 1),
                                child: const Icon(FontAwesomeIcons.instagram)),
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white,
                                    elevation: 1),
                                child: const Icon(FontAwesomeIcons.twitter)),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
