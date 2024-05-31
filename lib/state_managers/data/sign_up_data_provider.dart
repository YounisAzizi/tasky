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

final signUpDataProvider = ChangeNotifierProvider<SignUpDataProvider>(
  (ref) => SignUpDataProvider(),
);

class SignUpDataProvider extends ChangeNotifier {
  static Future<void> signUp(
      {required String phone,
      required String password,
      required String displayName,
      required int experienceYears,
      required String address,
      required String level,
      required BuildContext context,
      required WidgetRef ref}) async {
    try {
      print('step 1');
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'SigningUp');
      final response = await Api.post(
        url: Apis.registerUser,
        headers: {'Content-Type': 'application/json'},
        data: {
          "phone": phone,
          "password": password,
          "displayName": displayName,
          "experienceYears": '${experienceYears}',
          "address": address,
          "level": level
        },
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
      } else if (response.statusCode == 422) {
        Utils.showSnackBar(context, 'رقم الهاتف مستخدم بالفعل');
      } else {
        print('failed');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
