import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/API/statics.dart';
import 'package:mmt_club/styles/app_colors.dart';

import '../../../Models/Project/product_details_model.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductDetailsModel product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    var images = [
      widget.product.firstImage,
      widget.product.secondImage,
      widget.product.thirdImage
    ];
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          width: MediaQuery.of(context).size.width,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id.toString(),
              child: Image.network(
                Statics.baseUrl + images[selectedImage]!,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(images.length,
                  (index) => buildSmallProductPreview(index, images)),
            ],
          ),
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index, images) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        margin: EdgeInsets.only(right: 15.w),
        padding: EdgeInsets.all(8.w),
        height: 50.h,
        width: 50.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: AppColors.basicColor
                  .withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(Statics.baseUrl + images[index]),
      ),
    );
  }
}
