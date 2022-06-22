import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/widgets/svg_asset.dart';

import 'icons.dart';

class CustomCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final Function? onTap;
  final String? tag;
  const CustomCard(
      {Key? key,
      this.title,
      this.subtitle,
      this.gradientStartColor,
      this.gradientEndColor,
      this.height,
      this.width,
      this.vectorBottom,
      this.vectorTop,
      this.onTap,
      this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      borderRadius: BorderRadius.circular(26),
      child: Ink(
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black,
              blurRadius: 15.0,
            ),
          ],
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(
            colors: [
              gradientStartColor ?? Color(0xff441DFC),
              gradientEndColor ?? Color(0xff4E81EB),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Container(
          height: 176.w,
          width: 305.w,
          child: Stack(
            children: [
              vectorBottom ??
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: SvgAsset(
                        height: 176.w,
                        width: 305.w,
                        assetName: AssetName.vectorTop),
                  ),
              vectorTop ??
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: SvgAsset(
                        height: 176.w,
                        width: 305.w,
                        assetName: AssetName.vectorBottom),
                  ),
              Padding(
                padding: EdgeInsets.only(left: 24.w, top: 24.h, bottom: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: tag ?? '',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              title!,
                              style: TextStyle(
                                  fontSize: 22.w,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        subtitle != null
                            ? Text(
                                subtitle!,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )
                            : Container(),
                      ],
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
