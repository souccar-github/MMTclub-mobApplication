import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/API/statics.dart';
import 'package:mmt_club/styles/app_text.dart';
import 'package:mmt_club/styles/app_colors.dart';
import '../../Models/Project/product_details_model.dart';
import 'product_details.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductDetailsModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(productDetailsModel: product),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.textWhite,
            boxShadow: [
              BoxShadow(
                color: AppColors.textBlack.withOpacity(0.2),
                blurRadius: 3.0,
              ),
            ],
            border: Border.all(
              width: 2,
              color: AppColors.basicColor.withAlpha(100),
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          //color: const Color.fromARGB(255, 235, 243, 242),
          child: Row(
            children: [
              product.firstImage == null
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 88.w,
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Image.asset(
                          "assets/images/image_gallery.png",
                          fit: BoxFit.contain,
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
                            Statics.baseUrl + product.firstImage!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 230.w,
                    child: Text(
                      product.name,
                      style: AppTextStyle.itemListTextTheme(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        product.point.toString(),
                        style: TextStyle(
                          color: AppColors.textBlack.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Image.asset("assets/images/pcoins.png"),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
