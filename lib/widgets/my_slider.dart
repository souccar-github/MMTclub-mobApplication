import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/styles/app_colors.dart';
import 'package:mmt_club/widgets/news/news_details.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../API/statics.dart';
import '../Models/Project/category_news_model.dart';
import '../Models/Project/gifts_model.dart';
import 'gift/gift_details.dart';
import 'neum.dart';
import 'shimmer_news.dart';

class MySlider extends StatefulWidget {
  final List<GiftsModel>? gifts;
  final List<CategoryNewsModel>? news;
  final bool isGift;
  const MySlider({Key? key, this.gifts, this.news, required this.isGift})
      : super(key: key);

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  @override
  Widget build(BuildContext context) {
    List<GiftsModel>? gifts = widget.gifts;
    List<CategoryNewsModel>? news = widget.news;
    final pages = widget.isGift
        ? List.generate(
            gifts!.length,
            (index) => Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
                  child: gifts[index].image != null
                      ? Neum(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GiftDetailes(gift: gifts[index])));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              Statics.baseUrl + gifts[index].image!,
                            ),
                          ),
                        )
                      : const ShimmerNews(),
                ))
        : List.generate(
            news!.length,
            (index) => Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
                  child: news[index].image != null
                      ? Neum(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDetails(
                                          news: news[index],
                                        )));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              Statics.baseUrl + news[index].image!,
                            ),
                          ),
                        )
                      : const ShimmerNews(),
                ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 200.h,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            controller: controller,

            // itemCount: pages.length,
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
          ),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: pages.length,
          effect: WormEffect(
            dotHeight: 5.h,
            dotWidth: 13.w,
            type: WormType.thin,
            activeDotColor: AppColors.basicColor,
            // strokeWidth: 5,
          ),
        ),
      ],
    );
  }
}