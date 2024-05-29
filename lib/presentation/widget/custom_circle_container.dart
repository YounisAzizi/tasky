import 'package:flutter/material.dart';

class CustomCircleContainer extends StatelessWidget {
  const CustomCircleContainer({super.key,
  required this.color,
  required this.width,
  required this.height});
  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height ,
      width:width ,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32)
      ),
    );
  }
}
