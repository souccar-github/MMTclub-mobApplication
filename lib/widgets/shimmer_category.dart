import 'package:flutter/material.dart';
import 'package:mmt_club/widgets/shimmer_news.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_circular_slider.dart';
import 'dart:math';

class ShimmerCategory extends StatelessWidget {
  const ShimmerCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const CustomCircularSlider(),

            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 4.h, 0.0, 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w, left: 8.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w, left: 8.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const ShimmerNews(),
            // Expanded(
            //   child: Shimmer.fromColors(
            //     baseColor: Colors.grey.shade300,
            //     highlightColor: Colors.grey.shade100,
            //     enabled: true,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (_, __) => const ShimmerNews(),
            //       itemCount: 6,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key? key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      pi,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
