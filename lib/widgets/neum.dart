import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../styles/app_colors.dart';

class Neum extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? background;

  const Neum({Key? key, required this.child, this.onPressed, this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed ?? () {},
      style: NeumorphicStyle(
        color: background ?? AppColors.textGrey,
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0)),
      ),
      child: child,
    );
  }
}
