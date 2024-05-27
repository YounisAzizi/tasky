import 'package:flutter/material.dart';
import 'package:Tasky/core/utils/utils.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key,required this.onPressed, required this.child});
  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
    style:ElevatedButton.styleFrom(

      backgroundColor: const Color(0xFF5F33E1)
        ,
      fixedSize: Size(Utils.screenWidth(context)/1.1, Utils.screenHeight(context)*0.07)
    ), child: child,);
  }
}
