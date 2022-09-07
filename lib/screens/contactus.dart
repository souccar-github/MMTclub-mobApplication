import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/bloc/generalSettingBloc/general_setting_bloc.dart';
import 'package:mmt_club/constants.dart';
import 'package:mmt_club/widgets/refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Localization/localization.dart';
import '../styles/app_colors.dart';
import '../widgets/slogan.dart';

class ContactsUS extends StatefulWidget {
  static String routeName = "/contactUs";

  const ContactsUS({Key? key}) : super(key: key);

  @override
  State<ContactsUS> createState() => _ContactsUSState();
}

class _ContactsUSState extends State<ContactsUS> {
  final GeneralSettingBloc generalSettingBloc = GeneralSettingBloc();

  @override
  void initState() {
    super.initState();
    generalSettingBloc.add(GetGeneralSettingEvent());
  }

  @override
  void dispose() {
    super.dispose();
    generalSettingBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _launchTo(String url) async {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
      )) {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("contactUs"),
          style: CustomTextStyle.appBarTextTheme(context),
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
          children: [
            SizedBox(
              height: 150.h,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/logommt.png',
                fit: BoxFit.contain,
              ),
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
                                onPressed: () async {
                                  await _launchTo(
                                      state.generalSettingModel.facebook ?? "");
                                },
                                style: TextButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white,
                                    elevation: 1),
                                child: const Icon(FontAwesomeIcons.facebook)),
                            TextButton(
                                onPressed: () async {
                                  await _launchTo(
                                      state.generalSettingModel.instagram ??
                                          "");
                                },
                                style: TextButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white,
                                    elevation: 1),
                                child: const Icon(FontAwesomeIcons.instagram)),
                            TextButton(
                                onPressed: () async {
                                  await _launchTo(
                                      state.generalSettingModel.twitter ?? "");
                                },
                                style: TextButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white,
                                    elevation: 1),
                                child: const Icon(FontAwesomeIcons.twitter)),
                            TextButton(
                                onPressed: () async {
                                  await _launchTo(
                                      state.generalSettingModel.telegram ?? "");
                                },
                                style: TextButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white,
                                    elevation: 1),
                                child: const Icon(FontAwesomeIcons.telegram)),
                            TextButton(
                                onPressed: () async {
                                  await _launchTo(
                                      state.generalSettingModel.youTube ?? "");
                                },
                                style: TextButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white,
                                    elevation: 1),
                                child: const Icon(FontAwesomeIcons.youtube)),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return TapToRefreesh(onTap: () {
                    generalSettingBloc.add(GetGeneralSettingEvent());
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
