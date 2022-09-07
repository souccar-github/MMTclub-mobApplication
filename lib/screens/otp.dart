import 'dart:developer';

import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_club/Localization/localization.dart';
import 'package:mmt_club/bloc/authBloc/auth_bloc.dart';
import 'package:mmt_club/screens/login_screen.dart';
import 'package:mmt_club/styles/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';

class OTP extends StatefulWidget {
  final String phone;

  const OTP({Key? key, required this.phone}) : super(key: key);
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final int _otpCodeLength = 5;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");
  final AuthBloc authBloc = AuthBloc();

  get data => null;

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    _startListeningSms();
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

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    log("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onClickRetry() {
    _startListeningSms();
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      _otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      _scaffoldKey.currentState?.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) async {
        if (state is AuthenticateSuccessfully) {
          final prefs = await SharedPreferences.getInstance();
          final String? token = prefs.getString('token');
          if (token != null && token.isNotEmpty) {
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
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
                        border: Border.all(
                            color: AppColors.basicColor.withOpacity(0.6))),
                    selectedDecoration: _pinPutDecoration,
                    onChange: (code) {
                      _onOtpCallBack(code, false);
                    }),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                bloc: authBloc,
                builder: (context, state) {
                  if (state is AuthenticateWaiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return Expanded(
                      child: TextButton(
                        onPressed: () {
                          authBloc.add(AuthenticateEvent(widget.phone));
                        },
                        child: Text(Localization.of(context)
                            .getTranslatedValue("Verify")),
                      ),
                    );
                  }
                },
              ),
              TextButton(
                onPressed: _onClickRetry,
                child: Text(
                  Localization.of(context).getTranslatedValue("Retry"),
                  style: TextStyle(
                    color: AppColors.textBlack,
                    textBaseline: TextBaseline.ideographic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _setUpButtonChild() {
    return Text(Localization.of(context).getTranslatedValue("Verify"));
    // if (_isLoadingButton) {
    //   return const SizedBox(
    //     width: 19,
    //     height: 19,
    //     child: CircularProgressIndicator(
    //       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    //     ),
    //   );
    // } else {
    //   return Text(Localization.of(context).getTranslatedValue("Verify"));
    // }
  }
}
