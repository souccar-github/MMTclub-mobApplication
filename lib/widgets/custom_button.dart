import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/styles/app_text.dart';

import '../styles/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Widget? child;
  final double? size;
  final Color? textColor;
  final Color? iconColor;
  final Color? background;
  const CustomButton({
    Key? key,
    this.text,
    this.onPressed,
    this.icon,
    this.size,
    this.textColor,
    this.background,
    this.iconColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: NeumorphicButton(
        onPressed: onPressed ?? () {},
        style: NeumorphicStyle(
            color: background ?? AppColors.textGrey,
            shape: NeumorphicShape.concave,
            boxShape:
                NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text != null
                ? Text(
                    text!,
                    style:
                        AppTextStyle.customButtonTextTheme(context, textColor),
                  )
                : Container(),
            SizedBox(width: 5.w),
            child ??
                Icon(
                  icon,
                  color: iconColor ?? Colors.black.withOpacity(0.65),
                  size: size ?? 10.h,
                ),
          ],
        ),
      ),
    );
  }
}
