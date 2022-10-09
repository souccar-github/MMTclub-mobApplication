import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mmt_club/Localization/localization.dart';
import 'package:mmt_club/styles/app_text.dart';
import '../widgets/logo.dart';

class OfflineScreen extends StatelessWidget {
  final Widget child;
  const OfflineScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget _,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Stack(
            children: [
              child,
              if (!connected)
                Scaffold(
                  body: Center(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 25.h,
                            ),
                            SizedBox(
                              // height: MediaQuery.of(context).size.height * 0.12,
                              // width: MediaQuery.of(context).size.width * 0.5,
                              child: AspectRatio(
                                aspectRatio: 3,
                                child: Image.asset(
                                  'assets/images/logommt.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 250.w,
                              height: 250.h,
                              child: Lottie.asset('assets/json/satalitte.json'),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Container(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                Localization.of(context)
                                    .getTranslatedValue("not_connection"),
                                style: AppTextStyle.titeTextTheme(context),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
            ],
          );
        },
        child: Container());
  }
}
