import 'dart:convert';

import 'package:Tasky/apis/apis.dart';
import 'package:Tasky/const/end_point.dart';
import 'package:Tasky/models/level_enum.dart';
import 'package:Tasky/models/sign_up_model.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/screens/loading_notifier_riv.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final signUpScreenProvider = ChangeNotifierProvider<SignUpScreenProvider>(
  (ref) => SignUpScreenProvider(),
);

class SignUpScreenProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  SignUpModel _signUpModel = defaultSignUp;
  SignUpModel get signUpModel => _signUpModel;
  set signUpModel(SignUpModel signUpModel) {
    _signUpModel = signUpModel;
    notifyListeners();
  }

  List<LevelEnum> _levels = LevelEnum.values;
  List<LevelEnum> get levels => _levels;
  set Levels(List<LevelEnum> newLevels) {
    _levels = newLevels;
    notifyListeners();
  }

  Future<void> signUp({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    if (!defaultSignUp.isEqual(_signUpModel)) {
      try {
        ref.read(loadingProvider).showLoading();
        Utils.showLoadingDialog(context, 'SigningUp');
        final response = await Api.post(
          url: Apis.registerUser,
          headers: {'Content-Type': 'application/json'},
          data: _signUpModel.toJson(),
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

          await SharedPrefs.setStoreToken(accessToken!);
          await SharedPrefs.setStoreId(id!);
          await SharedPrefs.setStoreRefreshToken(refreshToken!);
          await SharedPrefs.setIsUserLoggedIn(true);
          context.go(Routes.mainScreen);
        } else {
          Utils.showSnackBar(context, jsonDecode(response.body)['message']);
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}
