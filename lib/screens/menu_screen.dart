import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/screens/complaint.dart';
import 'package:mmt_club/screens/product_list.dart';
import '../Localization/localization.dart';
import '../widgets/logo.dart';
import 'contactus.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

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
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Column(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .apply(fontWeightDelta: 3)),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .apply(fontWeightDelta: 3)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //const ContactsUS(),
                    const SizedBox(
                      child: ContactsUS(),
                      height: 125,
                    )
                  ],
                );
              }, childCount: 1))
            ],
          )),
    );
  }
}
