import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Widget child;
  final int? seconds;
  final String logo;

  const SplashScreen(
      {Key? key, this.seconds, required this.logo, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: seconds ?? 5), () {
          return true;
        }),
        builder: (context, s) {
          return s.data == true
              ? child
              : Scaffold(
                  body: Center(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Image.asset(
                      logo,
                      fit: BoxFit.contain,
                    ),
                  )),
                );
        });
  }
}
