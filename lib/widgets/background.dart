import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
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
        child,
      ],
    );
  }
}
