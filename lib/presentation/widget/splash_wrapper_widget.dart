import 'package:Tasky/presentation/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screen/splash_screen.dart';
import '../screen/welcome_screen.dart';

final isUserLoggedInProvider = StateProvider((ref){
  return false;
});
class SplashWrapper extends ConsumerStatefulWidget {
  const SplashWrapper({super.key});

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
          return ref.watch(isUserLoggedInProvider) == true ? const MainScreen() : const WelcomeScreen();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
