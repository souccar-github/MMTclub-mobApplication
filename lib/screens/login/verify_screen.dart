import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/styles/app_colors.dart';
import 'package:mmt_club/styles/app_text.dart';
import 'package:mmt_club/widgets/background.dart';
import '../../Localization/localization.dart';
import '../../pages/login_page.dart';
import '../../widgets/timer.dart';
import 'otp_screen.dart';

class VerifyScreen extends StatelessWidget {
  final String phone;
  final String code;
  const VerifyScreen({
    Key? key,
    required this.phone,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: AlertDialog(
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                  child: Text(
                    Localization.of(context).getTranslatedValue("cancel"),
                  ),
                ),
                const SizedBox(width: 10.0),
                Timer(
                  minutes: 5,
                  onTap: () async {
                    log("retry");
                    // FirebaseSMSFunctions.sms(widget.phone, widget.code);
                  },
                ),
              ],
            ),
          ],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: SizedBox(
            height: 250.h,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  Localization.of(context)
                      .getTranslatedValue("phone_number_ver"),
                  style: AppTextStyle.labelText1Theme(context),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h, bottom: 6.0),
                  child: Wrap(
                    children: [
                      Text(
                        Localization.of(context)
                                .getTranslatedValue("Enter_the_code") +
                            " ",
                        style: AppTextStyle.labelText2Theme(context),
                      ),
                      Text(
                        phone,
                        style: AppTextStyle.labelText2Theme(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textBlack),
                      ),
                    ],
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: OTPScreen(
                    phone: phone,
                    code: code,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
