import 'package:flutter/material.dart';
import '../../../Models/Project/product_details_model.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final ProductDetailsModel product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductImages(product: product),
        Expanded(
          child: TopRoundedContainer(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                // TopRoundedContainer(
                //   color: const Color(0xFFF6F7F9),
                //   child: Column(
                //     children: [
                //       TopRoundedContainer(
                //         color: Colors.white,
                //         child: Container(
                //           child: Text(""),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
