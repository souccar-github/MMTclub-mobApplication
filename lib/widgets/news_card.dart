import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmt_club/API/statics.dart';
import 'package:mmt_club/Models/Project/category_news_model.dart';
import 'package:mmt_club/Models/Project/product_details_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.news,
  }) : super(key: key);

  final double width, aspectRetio;
  final CategoryNewsModel news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: SizedBox(
        width: width,
        child: GestureDetector(
          onTap: () {
            //   return Navigator.pushNamed(
            //   context,
            //   DetailsScreen.routeName,
            //   arguments: ProductDetailsArguments(product: product),
            // );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    //color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: news.image != null
                      ? Image.network(Statics.baseUrl + news.image!)
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                news.name ?? "No name",
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "\$${product.price}",
              //       style: TextStyle(
              //         fontSize: getProportionateScreenWidth(18),
              //         fontWeight: FontWeight.w600,
              //         color: kPrimaryColor,
              //       ),
              //     ),
              //     InkWell(
              //       borderRadius: BorderRadius.circular(50),
              //       onTap: () {},
              //       child: Container(
              //         padding: EdgeInsets.all(getProportionateScreenWidth(8)),
              //         height: getProportionateScreenWidth(28),
              //         width: getProportionateScreenWidth(28),
              //         decoration: BoxDecoration(
              //           color: product.isFavourite
              //               ? kPrimaryColor.withOpacity(0.15)
              //               : kSecondaryColor.withOpacity(0.1),
              //           shape: BoxShape.circle,
              //         ),
              //         child: SvgPicture.asset(
              //           "assets/icons/Heart Icon_2.svg",
              //           color: product.isFavourite
              //               ? Color(0xFFFF4848)
              //               : Color(0xFFDBDEE4),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
