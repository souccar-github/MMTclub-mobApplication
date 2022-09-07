import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/widgets/custom_text.dart';

import '../Localization/localization.dart';
import 'login_screen.dart';
import 'otp.dart';

class VerifyScreen extends StatelessWidget {
  final String phone;
  const VerifyScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -130.0.h,
            right: 220.0.w,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(250 / 360),
              child: SizedBox(
                width: 300.w,
                //height: 250.h,
                child: Image.asset(
                  "assets/images/leaf.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 150.0.w,
            child: SizedBox(
              width: 400.w,
              //height: 350.h,
              child: Image.asset(
                "assets/images/leaf2.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height - 640.h,
              child: Image.asset(
                "assets/images/background.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: SizedBox(
              height: 325.h,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                      Localization.of(context)
                          .getTranslatedValue("phone_number_ver"),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Wrap(
                      children: [
                        Text(
                          Localization.of(context)
                                  .getTranslatedValue("Enter_the_code") +
                              " ",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          phone,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: SizedBox(
                        height: (MediaQuery.of(context).size.height / 5).h,
                        width: MediaQuery.of(context).size.width,
                        child: OTP(phone: phone)),
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    },
                    text: Localization.of(context).getTranslatedValue("cancel"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
