import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/API/statics.dart';
import 'package:mmt_club/Localization/localization.dart';
import '../Models/Project/category_model.dart';
import 'news/see_more_news.dart';
import 'my_slider.dart';
import 'custom_button.dart';

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
              // default.png
              categoryModel.image == null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.asset(
                        "assets/images/image_gallery.png",
                        fit: BoxFit.contain,
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.network(
                        Statics.baseUrl + categoryModel.image!,
                        fit: BoxFit.contain,
                      ),
                    ),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SeeMoreNews(
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
        if (categoryModel.news!.isNotEmpty)
          MySlider(
            news: categoryModel.news!,
            isGift: false,
            refreshKey: null,
          ),
      ],
    );
  }
}
