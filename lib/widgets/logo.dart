import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String imagePath;
  const Logo({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
