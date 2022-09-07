import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:mmt_club/Localization/localization.dart';
import 'package:mmt_club/screens/verify_screen.dart';
import 'package:mmt_club/styles/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    Future<String?> _authUser(LoginData data) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        //_verifyUser(data.name);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyScreen(phone: data.name)));
        return null;
      }

      return Localization.of(context)
          .getTranslatedValue("check_your_connection");
    }

    Future<String> _recoverPassword(String name) {
      //print('Name: $name');
      return Future.delayed(loginTime).then((_) {
        return "null";
      });
    }

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
          return Localization.of(context)
              .getTranslatedValue("Invalid_phone_number");
        }
        return null;
      },
      onSubmitAnimationCompleted: () {},
      onRecoverPassword: _recoverPassword,
    );
  }
}