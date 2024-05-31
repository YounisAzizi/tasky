import 'dart:async';

import 'package:Tasky/routes/app_router.dart';
import 'package:Tasky/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    runApp(ProviderScope(child: const MyApp()));
  }, (error, stackTrace) async {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final router = AppRouter.createRouter();
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.mainTheme(),
        routerConfig: router,
      ),
    );
  }
}
