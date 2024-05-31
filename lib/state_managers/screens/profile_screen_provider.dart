import 'dart:convert';

import 'package:Tasky/apis/apis.dart';
import 'package:Tasky/const/end_point.dart';
import 'package:Tasky/state_managers/screens/loading_notifier_riv.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider =
    ChangeNotifierProvider<UserDataNotifier>((ref) => UserDataNotifier());

class UserDataNotifier extends ChangeNotifier {
  Map<String, dynamic> _userData = {};
  Map<String, dynamic> get userData => _userData;
  set userData(Map<String, dynamic> newData) {
    _userData = newData;
    notifyListeners();
  }

  void updateUserData(String key, dynamic value) {
    _userData[key] = value;
    notifyListeners();
  }

  Future<void> getProfile(WidgetRef ref, BuildContext context) async {
    final url = Apis.profile;

    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Getting profile data');
      final response = await Api.get(
        url: url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.getStoreToken()}',
        },
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response == null) {
        Utils.showSnackBar(context, 'Something went wrong!');
      } else if (response.statusCode == 200) {
        final profileData = json.decode(response.body);
        ref.read(userDataProvider).userData = profileData;
      } else {
        print('Failed to get profile data');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
