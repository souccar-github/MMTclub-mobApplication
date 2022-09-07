import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/API/statics.dart';
import 'package:mmt_club/constants.dart';
import 'package:mmt_club/styles/app_colors.dart';
import '../../Models/Project/product_details_model.dart';
import 'details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
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
          color: const Color.fromARGB(255, 235, 243, 242),
          child: Row(
            children: [
              product.firstImage == null
                  ? SizedBox(
                      width: 88.w,
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                          //padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 88.w,
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                          //padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.network(
                            Statics.baseUrl + product.firstImage!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: CustomTextStyle.itemListTextTheme(context),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(product.point.toString(),
                          style: TextStyle(
                              color: AppColors.textBlack.withOpacity(0.5))),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/images/pcoins.png")),
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
