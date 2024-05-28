import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDataNotifier extends ChangeNotifier {
  Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  void setUserData(Map<String, dynamic> newData) {
    _userData = newData;
    notifyListeners();
  }

  void updateUserData(String key, dynamic value) {
    _userData[key] = value;
    notifyListeners();
  }
}

final userDataProvider = ChangeNotifierProvider<UserDataNotifier>((ref) {
  return UserDataNotifier();
});
