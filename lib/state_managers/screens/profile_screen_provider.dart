import 'package:flutter/foundation.dart';
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
}
