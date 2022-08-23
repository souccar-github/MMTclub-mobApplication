import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/API/statics.dart';
import 'package:mmt_club/Localization/Localization.dart';
import 'package:mmt_club/screens/all_news_screen.dart';
import 'package:mmt_club/widgets/shimmer_news.dart';
import '../Models/Project/category_model.dart';
import 'custom_text.dart';
import 'neum.dart';

class Category extends StatelessWidget {
  const Category({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.network(
                  Statics.baseUrl + categoryModel.image,
                  fit: BoxFit.contain,
                ),
              ),
              CustomText(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllNeswScreen(
                              catId: categoryModel.id,
                            )),
                  );
                },
                text: Localization.of(context).getTranslatedValue("seeMore"),
                icon: FontAwesomeIcons.list,
              ),
            ],
          ),
        ),
        categoryModel.news!.isEmpty
            ? Container()
            : CarouselSlider.builder(
                options: CarouselOptions(
                  //autoPlay: true,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  //aspectRatio: 2.0,
                  initialPage: 0,
                  enlargeCenterPage: true,
                ),
                itemCount: categoryModel.news!.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Neum(
                      onPressed: () {},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: (categoryModel.news![itemIndex].image != null)
                            ? InteractiveViewer(
                                clipBehavior: Clip.none,
                                minScale: 1,
                                maxScale: 4,
                                child: Image.network(
                                  Statics.baseUrl +
                                      categoryModel.news![itemIndex].image!,
                                ),
                              )
                            : const ShimmerNews(),
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
