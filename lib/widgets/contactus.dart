import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/bloc/generalSettingBloc/general_setting_bloc.dart';
import 'package:mmt_club/widgets/hour_glass.dart';
import 'package:mmt_club/widgets/refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Localization/localization.dart';
import 'my_toast.dart';

class ContactsUS extends StatefulWidget {
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
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: BlocBuilder(
        bloc: generalSettingBloc,
        builder: (context, state) {
          if (state is GetGeneralSettingWaiting) {
            return const HourGlass();
          } else if (state is GetGeneralSettingSuccessfully) {
            return (state.generalSettingModel != null)
                ? Column(
                    children: [
                      Text(
                        Localization.of(context)
                            .getTranslatedValue("contactUs"),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 3),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GoToLink(
                              link: state.generalSettingModel!.facebook,
                              iconData: FontAwesomeIcons.facebook),
                          GoToLink(
                              link: state.generalSettingModel!.instagram,
                              iconData: FontAwesomeIcons.instagram),
                          GoToLink(
                              link: state.generalSettingModel!.youTube,
                              iconData: FontAwesomeIcons.youtube),
                          GoToLink(
                              link:
                                  "tel://<+${state.generalSettingModel!.mobilePhone}>",
                              iconData: FontAwesomeIcons.phone),
                          GoToLink(
                              link: state.generalSettingModel!.telegram,
                              iconData: FontAwesomeIcons.telegram),
                        ],
                      ),
                    ],
                  )
                : Container();
          } else {
            return TapToRefreesh(onTap: () {
              generalSettingBloc.add(GetGeneralSettingEvent());
            });
          }
        },
      ),
    );
  }
}

class GoToLink extends StatelessWidget {
  final String? link;
  final IconData iconData;
  const GoToLink({Key? key, this.link, required this.iconData})
      : super(key: key);
  _launchTo(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return (link == null || link!.isEmpty)
        ? Container()
        : TextButton(
            onPressed: () async {
              await _launchTo(link ?? "");
            },
            style: TextButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                elevation: 1),
            child: Icon(iconData));
  }
}
