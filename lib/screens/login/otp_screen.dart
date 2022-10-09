import 'dart:developer';

import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mmt_club/Localization/localization.dart';
import 'package:mmt_club/bloc/authBloc/auth_bloc.dart';
import 'package:mmt_club/styles/app_colors.dart';
import 'package:mmt_club/widgets/my_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../pages/home_page.dart';
import '../../pages/login_page.dart';
import '../../styles/app_text.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String code;
  const OTPScreen({Key? key, required this.phone, required this.code})
      : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final int _otpCodeLength = 5;
  String? _otpCode;
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");
  final AuthBloc authBloc = AuthBloc();
  bool isVerfiy = false;
  get data => null;

  @override
  void initState() {
    log(widget.code);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: AppColors.textWhite,
      border: Border.all(color: AppColors.basicColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      _otpCode = otpCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) async {
        if (state is AuthenticateSuccessfully) {
          MyToast.show(
            context: context,
            text: "Verification OTP Code $_otpCode Success",
            toastState: ToastState.SUCCESS,
          );
          final prefs = await SharedPreferences.getInstance();
          final String? token = prefs.getString('token');
          bool navToHome = token != null && token.isNotEmpty;

          if (navToHome) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DefaultBottomBarController(
                  child: HomePage(),
                ),
              ),
            );
          }
        } else if (state is AuthenticateError) {
          MyToast.show(
            context: context,
            text:
                Localization.of(context).getTranslatedValue("try_again_later"),
            toastState: ToastState.ERROR,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50.h,
            child: TextFieldPin(
              textController: textEditingController,
              autoFocus: true,
              codeLength: _otpCodeLength,
              alignment: MainAxisAlignment.center,
              defaultBoxSize: (MediaQuery.of(context).size.width / 10).w,
              margin: 2,
              selectedBoxSize: (MediaQuery.of(context).size.width / 10).w,
              textStyle: const TextStyle(
                fontSize: 18,
              ),
              defaultDecoration: _pinPutDecoration.copyWith(
                  border:
                      Border.all(color: AppColors.basicColor.withOpacity(0.6))),
              selectedDecoration: _pinPutDecoration,
              onChange: (code) {
                _onOtpCallBack(code, false);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<AuthBloc, AuthState>(
              bloc: authBloc,
              builder: (context, state) {
                if (state is AuthenticateWaiting) {
                  return SpinKitPouringHourGlassRefined(
                    color: AppColors.basicColor.withOpacity(0.7),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      // authBloc.add(AuthenticateEvent(widget.phone));
                      if (_otpCode != null) {
                        if (_otpCode!.length < _otpCodeLength) {
                        } else if (widget.code != _otpCode) {
                          authBloc.add(AuthenticateEvent(widget.phone));
                        } else {
                          MyToast.show(
                            context: context,
                            text: "Verification OTP Code $_otpCode Failed",
                            toastState: ToastState.ERROR,
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Localization.of(context).getTranslatedValue("Verify"),
                        style: AppTextStyle.labelText2Theme(context).copyWith(
                          color: AppColors.basicColor,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
