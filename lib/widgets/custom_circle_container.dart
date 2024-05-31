import 'package:flutter/material.dart';

class CustomCircleContainer extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  const CustomCircleContainer({
    super.key,
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(32),
        ),
      );
}
