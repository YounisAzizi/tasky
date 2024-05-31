import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.onPressed, required this.child});
  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainThemColor,
        fixedSize: Size(Utils.screenWidth(context), 50),
      ),
      child: child,
    );
  }
}
