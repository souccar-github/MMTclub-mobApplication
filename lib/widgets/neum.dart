import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../styles/app_colors.dart';

class Neum extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const Neum({Key? key, required this.child, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed ?? () {},
      style: NeumorphicStyle(
        color: AppColors.textGrey,
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0)),
      ),
      child: child,
    );
  }
}
