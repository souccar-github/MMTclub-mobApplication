import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Localization/Localization.dart';
import '../colors/app_colors.dart';
import '../widgets/customCard.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int currentIndex = 0;
  List<String> tabs = [];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          elevation: 0.0,
          expandedHeight: 320,
          pinned: true,
          backgroundColor: AppColors.backgroundColor,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1.5,
            titlePadding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            centerTitle: true,
            title: SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Image.asset(
                'assets/images/logommt.png',
                fit: BoxFit.contain,
              ),
            ),
          ), //FlexibleSpaceBar
        ),
        MySliverList(
          child: Category(),
        )
      ],
    );
  }
}

class MySliverList extends StatelessWidget {
  final Widget child;
  const MySliverList({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(Localization.of(context).getTranslatedValue("NATURE"),
                  style: GoogleFonts.tajawal(
                    fontSize: 22,
                    color: AppColors.darkGreen,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
              child: Text(
                  Localization.of(context)
                      .getTranslatedValue("isourinspiration"),
                  style: GoogleFonts.tajawal(
                    fontSize: 22,
                    color: AppColors.darkGreen,
                  )),
            ),
            child,
            SizedBox(height: MediaQuery.of(context).size.height * 0.5),
          ],
        );
      },
      childCount: 1,
    ));
  }
}

class Category extends StatelessWidget {
  const Category({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.4,
            child: Image.asset(
              'assets/images/logommt.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 20.0),
                child: CustomCard(
                  title: "MMT",
                  subtitle: "news",
                  height: MediaQuery.of(context).size.height * 0.15,
                  gradientStartColor: AppColors.darkGreen,
                  gradientEndColor: AppColors.lightGreen,
                  onTap: () {},
                ),
              )
            ]),
      ],
    );
  }
}
