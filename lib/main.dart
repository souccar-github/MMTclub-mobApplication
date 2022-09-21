import 'dart:io';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/pages/home_page.dart';
import 'package:mmt_club/pages/login_page.dart';
import 'package:mmt_club/styles/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Localization/localization.dart';

void main() async {
  //setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    Future.delayed(const Duration(milliseconds: 0), () async {
      state?.setLocale(locale);
    });
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(Platform.localeName.substring(0, 2));

  int? indexFromNotification;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    checkIfLogin();
    configureFirebaseMessaging();
    //initialization();
  }

  Future checkIfLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> configureFirebaseMessaging() async {
    final FirebaseMessaging fm = FirebaseMessaging.instance;
    await fm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message?.notification != null) {
        setState(() {
          indexFromNotification = 2;
        });
      }
    });

    // // onMessage: When the app is open and it receives a push notification
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   if (message.notification != null) {
    //     setState(() {
    //       indexFromNotification = 2;
    //     });
    //   }
    // });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        setState(() {
          indexFromNotification = 2;
        });
      }
    });
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    //FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        title: 'MMT CLUB',
        theme: ThemeData(
          fontFamily: _locale.languageCode == 'ar' ? "Cairo" : "Gotham",
          colorScheme: ColorScheme.light(
            primary: AppColors.basicColor,
          ),
        ),
        // : ThemeData(
        //     fontFamily: "Gotham",
        //     colorScheme: ColorScheme.light(
        //       primary: AppColors.basicColor,
        //     ),
        //   ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLoacales) {
          for (var locale in supportedLoacales) {
            if (locale.languageCode == deviceLocale?.languageCode) {
              return deviceLocale;
            }
          }
          return supportedLoacales.first;
        },
        locale: _locale,
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        home: FutureBuilder(
          future: checkIfLogin(),
          builder: (context, snapshot) {
            return (snapshot.data != null)
                ? DefaultBottomBarController(
                    child: HomePage(
                    indexFCM: indexFromNotification,
                  ))
                : const LoginPage();
          },
        ),
      ),
    );
  }
}
