import 'dart:convert';

import 'package:Tasky/apis/apis.dart';
import 'package:Tasky/const/end_point.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/screens/loading_notifier_riv.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final signInDataProvider = ChangeNotifierProvider<SignInDataProvider>(
  (ref) => SignInDataProvider(),
);

class SignInDataProvider extends ChangeNotifier {
  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> signIn({
    required String phone,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'SigningIn');

      final response = await Api.post(
        url: Apis.loginUser,
        headers: {'Content-Type': 'application/json'},
        data: {'phone': phone, 'password': password},
      );

      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response == null) {
        Utils.showSnackBar(context, 'Something went wrong!');
      } else if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access_token'] as String?;
        final id = responseBody['_id'] as String?;
        final refreshToken = responseBody['refresh_token'] as String?;

        SharedPrefs.setStoreToken(accessToken!);
        SharedPrefs.setStoreId(id!);
        SharedPrefs.setStoreRefreshToken(refreshToken!);
        SharedPrefs.setIsUserLoggedIn(true);
        context.go(Routes.mainScreen);
      } else if (response.statusCode == 401) {
        Utils.showSnackBar(context, 'يوجد خطأ في رقم الهاتف أو كلمة المرور');
        print('${response.body}');
        print('${response.statusCode}');
      } else {
        print('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }
}
