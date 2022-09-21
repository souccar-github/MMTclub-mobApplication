import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/Models/Project/product_details_model.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class ProductDetails extends StatelessWidget {
  static String routeName = "/details";
  final ProductDetailsModel productDetailsModel;
  const ProductDetails({Key? key, required this.productDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height.h),
        child: CustomAppBar(points: productDetailsModel.point),
      ),
      body: Body(product: productDetailsModel),
    );
  }
}
