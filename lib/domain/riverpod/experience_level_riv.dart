import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LevelManagerNotifier extends ChangeNotifier {
  String? _selectedLevel;
  String? get selectedLevel => _selectedLevel;
  List<String> _levels = ['fresh', 'junior', 'midLevel', 'senior'];
  List<String> get levels => _levels;


  void setLevel(String? level) {
    _selectedLevel = level;
    notifyListeners();
  }
  void setLevels(List<String> newLevels) {
    _levels = newLevels;
    notifyListeners();
  }

}


final levelManagerNotifierProvider = ChangeNotifierProvider<LevelManagerNotifier>((ref) {
  return LevelManagerNotifier();
});

