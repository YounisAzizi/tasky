import 'package:flutter/material.dart';

class Utils{
  Utils._();
static double screenHeight(BuildContext context){
final screenHeight = MediaQuery.of(context).size.height;
return screenHeight;
}

  static double screenWidth(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }
}