import 'package:flutter/material.dart';
import 'package:mmt_club/API/statics.dart';
import 'package:mmt_club/styles/app_colors.dart';
import '../../Models/Project/product_details_model.dart';
import 'details_screen.dart';

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
            builder: (context) => DetailsScreen(productDetailsModel: product),
          ),
        ),
        child: Container(
          color: const Color.fromARGB(255, 235, 243, 242),
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    //padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(
                      Statics.baseUrl + product.firstImage,
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
                    style: TextStyle(
                        color: AppColors.textBlack.withOpacity(0.7),
                        fontSize: 16),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: "${product.point} points",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack.withOpacity(0.5)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
