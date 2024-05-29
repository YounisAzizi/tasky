import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    required this.data,
    required this.isSelected,
    required this.onTap,
  });

  final String data;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainThemColor: Color.fromRGBO(240, 236, 255, 1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
          child: Text(
            data,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : Color.fromRGBO(124, 124, 128, 1),
            ),
          ),
        ),
      ),
    );
  }
}
