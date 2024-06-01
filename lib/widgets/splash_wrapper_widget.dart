import 'package:Tasky/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

import '../screens/main_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/welcome_screen.dart';

class SplashWrapper extends StatefulWidget {
  const SplashWrapper();

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SharedPrefs.init();
      SharedPrefs.setIsUserLoggedIn(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SharedPrefs.getIsUserLoggedIn()
              ? const MainScreen()
              : const WelcomeScreen();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
