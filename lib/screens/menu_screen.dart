import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/screens/contactus.dart';
import 'package:mmt_club/screens/complaint.dart';
import 'package:mmt_club/screens/product_list.dart';
import 'package:mmt_club/screens/profile_screen.dart';

import '../Localization/Localization.dart';
import '../styles/app_colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/logo.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                expandedHeight: 200.h,
                pinned: true,
                flexibleSpace: const FlexibleSpaceBar(
                  expandedTitleScale: 1.5,
                  //titlePadding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                  centerTitle: true,
                  title: Logo(imagePath: 'assets/images/logommt.png'),
                ),
              ),
              SliverFillRemaining(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductList()),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          Localization.of(context)
                              .getTranslatedValue("products"),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.list,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Complaint()),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          Localization.of(context)
                              .getTranslatedValue("FeedBack"),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactsUS()),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          Localization.of(context)
                              .getTranslatedValue("contactUs"),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
