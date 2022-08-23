import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:mmt_club/Localization/Localization.dart';
import 'package:mmt_club/styles/theme.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => const Duration(milliseconds: 2250);
  bool isVerfied = false;

  Future<String?> _authUser(LoginData data) async {
    _verifyUser(data.name);
    return null;
  }

  Future<dynamic> _verifyUser(String phone) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return VerifyDialog(
          phone: phone,
        );
      },
    );
  }

  Future<String> _recoverPassword(String name) {
    //print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return "null";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: loginTheme,
      userType: LoginUserType.phone,
      logo: 'assets/images/logommt.png',
      onLogin: _authUser,
      hideForgotPasswordButton: true,
      loginAfterSignUp: false,
      passwordValidator: (v) {
        return null;
      },
      userValidator: (value) {
        if (value!.isEmpty || !(value.startsWith("09") && value.length == 10)) {
          return "Invalid phone number";
        }
        return null;
      },
      onSubmitAnimationCompleted: () {},
      onRecoverPassword: _recoverPassword,
    );
  }
}

class VerifyDialog extends StatelessWidget {
  final String phone;
  const VerifyDialog({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Column(
        children: [
          Text(Localization.of(context).getTranslatedValue("phone_number_ver"),
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Gotham-Light',
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
          SizedBox(
              height: (MediaQuery.of(context).size.height / 5).h,
              width: MediaQuery.of(context).size.width,
              child: OTP(phone: phone)),
        ],
      ),
    );
  }
}
