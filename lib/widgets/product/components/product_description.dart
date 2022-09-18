import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/Models/Project/product_details_model.dart';
import 'package:mmt_club/styles/app_text.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final ProductDetailsModel product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
            child: Text(
              product.name,
              style: AppTextStyle.titeTextTheme(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 10.0),
            child: Text(product.category!.name,
                style: AppTextStyle.caption(context)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.description ?? "",
                maxLines: 3, style: AppTextStyle.decTextTheme(context)),
          ),
        ],
      ),
    );
  }
}
