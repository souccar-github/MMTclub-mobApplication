import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/API/statics.dart';
import 'package:mmt_club/Models/Project/category_news_model.dart';
import 'package:mmt_club/widgets/news/news_details.dart';
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
              builder: (context) => NewsDetails(
                news: news,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.textBlack.withOpacity(0.5),
                  blurRadius: 10.0,
                ),
              ],
              color: AppColors.textWhite,
              borderRadius: BorderRadius.circular(15.0)),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              news.image != null
                  ? Container(
                      width: 88.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0)),
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Image.network(Statics.baseUrl + news.image!),
                      ),
                    )
                  : Container(),
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
