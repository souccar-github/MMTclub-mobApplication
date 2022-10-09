import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/API/statics.dart';
import 'package:mmt_club/Models/Project/category_news_model.dart';
import 'news_screen.dart';
import '../../styles/app_colors.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  final CategoryNewsModel news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsScreen(
                news: news,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.textBlack.withOpacity(0.2),
                  blurRadius: 3.0,
                ),
              ],
              border: Border.all(
                  width: 2, color: AppColors.basicColor.withAlpha(150)),
              color: AppColors.textWhite,
              borderRadius: BorderRadius.circular(15.0)),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              news.image == null
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 88.w,
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                          //padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 88.w,
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                            //padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Image.network(
                              Statics.baseUrl + news.image!,
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title ?? "",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      news.description ?? "",
                      style: Theme.of(context).textTheme.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
