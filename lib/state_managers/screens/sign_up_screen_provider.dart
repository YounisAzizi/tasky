import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpScreenProvider = ChangeNotifierProvider<SignUpScreenProvider>(
  (ref) => SignUpScreenProvider(),
);

class SignUpScreenProvider extends ChangeNotifier {
  String? _selectedLevel;
  String? get selectedLevel => _selectedLevel;
  set selectedLevel(String? level) {
    _selectedLevel = level;
    notifyListeners();
  }

  List<String> _levels = ['fresh', 'junior', 'midLevel', 'senior'];
  List<String> get levels => _levels;
  set Levels(List<String> newLevels) {
    _levels = newLevels;
    notifyListeners();
  }
}
