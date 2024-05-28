import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/riverpod/sign_in_riv.dart';
import '../screen/main_screen.dart';
import '../screen/splash_screen.dart';
import '../screen/welcome_screen.dart';


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
          final userLoginState = ref.watch(userLoginProvider);
          return userLoginState.isUserLoggedIn ? const MainScreen() : const WelcomeScreen();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
