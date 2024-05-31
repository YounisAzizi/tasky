import 'package:Tasky/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/main_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/welcome_screen.dart';

class SplashWrapper extends ConsumerStatefulWidget {
  const SplashWrapper({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends ConsumerState<SplashWrapper> {
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
