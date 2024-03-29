import 'dart:async';

import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/widgets/qr.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Localization/localization.dart';
import '../screens/home/main_screen.dart';
import '../screens/home/menu_screen.dart';
import '../screens/home/notifications_screen.dart';
import '../screens/home/profile_screen.dart';
import '../styles/app_colors.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  int? indexFCM;
  HomePage({Key? key, this.indexFCM}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late BuildContext bottomBarControllerContext;
  @override
  void initState() {
    super.initState();
    bottomBarControllerContext = context;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.indexFCM != null) {
      setState(() {
        currentIndex = widget.indexFCM!;
      });
    }
    return WillPopScope(
      onWillPop: () async {
        Alert(
          context: context,
          onWillPopActive: false,
          closeIcon: Container(),
          desc: Localization.of(context).getTranslatedValue("close_app"),
          image: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.exit_to_app,
              color: AppColors.basicColor,
            ),
          ),
          buttons: [
            DialogButton(
              color: AppColors.basicColor,
              radius: BorderRadius.circular(25.0),
              child: Text(
                Localization.of(context).getTranslatedValue("OK"),
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            DialogButton(
              color: Colors.white,
              child: Text(
                Localization.of(context).getTranslatedValue("cancel"),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ).show();

        return true;
      },
      child: Scaffold(
        //backgroundColor: Colors.white,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
          onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
          child: FloatingActionButton.extended(
            label: AnimatedBuilder(
              animation: DefaultBottomBarController.of(context).state,
              builder: (contextBar, child) {
                //getValue(context);
                DefaultBottomBarController.of(contextBar).addListener(() {
                  setState(() {
                    bottomBarControllerContext = contextBar;
                  });
                });
                return Row(
                  children: [
                    const Icon(Icons.qr_code),
                    const SizedBox(width: 4.0),
                    AnimatedBuilder(
                      animation:
                          DefaultBottomBarController.of(contextBar).state,
                      builder: (context, child) => Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.diagonal3Values(
                          1,
                          DefaultBottomBarController.of(context).state.value *
                                  2 -
                              1,
                          1,
                        ),
                        child: child,
                      ),
                    ),
                  ],
                );
              },
            ),
            elevation: 2,
            backgroundColor: AppColors.backgroundFloating.withOpacity(0.7),
            foregroundColor: AppColors.floating,
            //
            //Set onPressed event to swap state of bottom bar
            onPressed: () => DefaultBottomBarController.of(context).swap(),
          ),
        ),
        bottomNavigationBar: BottomExpandableAppBar(
          bottomAppBarColor: AppColors.bottomAppBarColor,
          horizontalMargin: 16,
          shape: const AutomaticNotchedShape(
              RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
          expandedBackColor: AppColors.expandedBackColor,
          expandedBody:
              DefaultBottomBarController.of(bottomBarControllerContext).isOpen
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(2.0, 30.0, 2.0, 0.0),
                      child: QRWidget(),
                    )
                  : Container(),
          bottomAppBarBody: Card(
            elevation: 10.0,
            margin: EdgeInsets.zero,
            child: buildNavBottomBar(),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Positioned(
              top: 0.0,
              left: 150.0.w,
              child: SizedBox(
                width: 400.w,
                //color: Colors.red,
                child: Image.asset(
                  "assets/images/leaf2.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned(
              child: Container(
                child: getWidget(currentIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildNavBottomItem(
            icon: FontAwesomeIcons.bars,
            index: 1,
            isPressed: currentIndex == 1,
          ),
          const Spacer(
            flex: 1,
          ),
          buildNavBottomItem(
            icon: FontAwesomeIcons.home,
            index: 0,
            isPressed: currentIndex == 0,
          ),
          const Spacer(
            flex: 3,
          ),
          buildNavBottomItem(
            icon: FontAwesomeIcons.bell,
            index: 2,
            isPressed: currentIndex == 2,
          ),
          const Spacer(
            flex: 1,
          ),
          buildNavBottomItem(
            icon: FontAwesomeIcons.user,
            index: 3,
            isPressed: currentIndex == 3,
          ),
        ],
      ),
    );
  }

  Widget buildNavBottomItem(
      {required IconData icon, required int index, required bool isPressed}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
            widget.indexFCM = null;
          });
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Icon(
            icon,
            color:
                isPressed ? AppColors.selectedItem : AppColors.unSelectedItem,
          ),
        ),
      ),
    );
  }
}

Widget getWidget(int index) {
  switch (index) {
    case 0:
      return const MainScreen();
    case 1:
      return const MenuScreen();
    case 2:
      return const NotificationScreen();
    default:
      return const ProfileScreen();
  }
}
