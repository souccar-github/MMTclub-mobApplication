import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mmt_club/qr.dart';
import 'package:mmt_club/screens/menu_screen.dart';
import 'package:mmt_club/screens/mycart_screen.dart';
import 'package:mmt_club/screens/profile_screen.dart';

import 'Screens/main_home_screen.dart';
import 'colors/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    //(DefaultBottomBarController.of(context).state.isDismissed.toString());
    BuildContext bottomBarControllerContext = context;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      //
      // Set [extendBody] to true for bottom app bar overlap body content
      extendBody: true,
      /*
      appBar: AppBar(
        title: const Text("MMT Club"),
        backgroundColor: AppColors.appBarColor,
        elevation: 0.0,
      ),
      */
      //
      // Lets use docked FAB for handling state of sheet
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: GestureDetector(
        //
        // Set onVerticalDrag event to drag handlers of controller for swipe effect
        onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
        onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
        child: FloatingActionButton.extended(
          label: AnimatedBuilder(
            animation: DefaultBottomBarController.of(context).state,
            builder: (context, child) {
              //getValue(context);
              DefaultBottomBarController.of(context).addListener(() {
                setState(() {
                  bottomBarControllerContext = context;
                });
              });
              return Row(
                children: [
                  const Icon(Icons.qr_code),
                  const SizedBox(width: 4.0),
                  AnimatedBuilder(
                    animation: DefaultBottomBarController.of(context).state,
                    builder: (context, child) => Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.diagonal3Values(
                        1,
                        DefaultBottomBarController.of(context).state.value * 2 -
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
      //
      // Actual expandable bottom bar
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
                    child: QRViewExample(),
                  )
                : Container(color: AppColors.expandedBackColor),
        bottomAppBarBody: Card(
          elevation: 10.0,
          margin: EdgeInsets.zero,
          child: buildNavBottomBar(),
        ),
      ),
      body: getWidget(currentIndex),
    );
  }

  Widget buildNavBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildNavBottomItem(
            icon: Icons.home,
            index: 0,
            isPressed: currentIndex == 0,
          ),
          const Spacer(
            flex: 1,
          ),
          buildNavBottomItem(
            icon: Icons.menu_rounded,
            index: 1,
            isPressed: currentIndex == 1,
          ),
          const Spacer(
            flex: 3,
          ),
          buildNavBottomItem(
            icon: Icons.shopping_cart,
            index: 2,
            isPressed: currentIndex == 2,
          ),
          const Spacer(
            flex: 1,
          ),
          buildNavBottomItem(
            icon: Icons.person,
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
          });
        },
        child: Icon(
          icon,
          color: isPressed ? AppColors.selectedItem : AppColors.unSelectedItem,
        ),
      ),
    );
  }
}

Widget getWidget(int index) {
  switch (index) {
    case 0:
      return const MainHomeScreen();
    case 1:
      return const MenuScreen();
    case 2:
      return const MyCartScreen();
    default:
      return const ProfileScreen();
  }
}
