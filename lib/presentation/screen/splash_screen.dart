import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/riverpod/sign_in_riv.dart';
import '../../theme/colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userLoginState = ref.watch(userLoginProvider);
      print(userLoginState);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor:AppColors.mainThemColor,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  children:[
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
                  ]
              )
              )
            ]
        ),
      ),
    );
  }
}
