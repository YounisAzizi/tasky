import 'dart:convert';

import 'package:Tasky/apis/apis.dart';
import 'package:Tasky/const/end_point.dart';
import 'package:Tasky/models/task_model.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/screens/loading_notifier_riv.dart';
import 'package:Tasky/state_managers/screens/main_screen_provider.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthServices {
  const AuthServices();

  static Future<void> refreshToken(
    String token,
    WidgetRef ref,
    BuildContext context,
  ) async {
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Refreshing Token');
      final response = await Api.get(
        url: '${Apis.refreshToken}${SharedPrefs.getStoreToken()}',
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);
      if (response == null) {
        Utils.showSnackBar(context, 'Something went wrong!');
      } else if (response.statusCode == 200) {
        print('Token refresh successful');
      } else {
        print('Token refresh failed: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error refreshing token: $e');
    }
  }

  static Future<void> logOut(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final url = Apis.logOutUser;

    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Logging out');
      final response = await Api.post(
        url: url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.getStoreToken()}'
        },
        data: {"token": SharedPrefs.getStoreToken()},
      );

      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response == null) {
        Utils.showSnackBar(context, 'Something went wrong!');
      } else if (response.statusCode == 201) {
        SharedPrefs.clear();

        context.go(Routes.signInScreen);
      } else {
        print('Logout failed');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> fetchOneTodo(
    int taskId,
    String accessToken,
    WidgetRef ref,
    BuildContext context,
  ) async {
    final String url = '${Apis.getOneTodo}$taskId';
    print(accessToken);
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Fetching todo');

      final response = await Api.get(
        url: url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response == null) {
        Utils.showSnackBar(context, 'Something went wrong!');
      } else if (response.statusCode == 200) {
        final serverItems = json.decode(response.body) as List;
        final todos =
            serverItems.map((todo) => TaskModel.fromJson(todo)).toList();

        ref.read(mainScreenProvider).todos = todos;
      } else {
        print('Failed to fetch todos');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
