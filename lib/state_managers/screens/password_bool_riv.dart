import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordBoolNotifier extends ChangeNotifier {
  bool _beSecure = true;
  bool get beSecure => _beSecure;
  void toggleSecure() {
    _beSecure = !_beSecure;
    notifyListeners();
  }
}

final passwordBoolProvider =
    ChangeNotifierProvider((ref) => PasswordBoolNotifier());
