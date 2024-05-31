import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.mainThemColor,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: 'Task',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Phosphate',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              TextSpan(
                text: 'y',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 40,
                  fontFamily: 'Phosphate',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              )
            ]))
          ]),
        ),
      );
}
