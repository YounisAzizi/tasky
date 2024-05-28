import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriorityManagerNotifier extends ChangeNotifier {
  String _selectedPriority = 'medium';
  List<String> _priorities = ['low', 'medium', 'high'];

  String get selectedPriority => _selectedPriority;
  List<String> get priorities => _priorities;

  void setPriority(String priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  void setPriorities(List<String> newPriorities) {
    _priorities = newPriorities;
    notifyListeners();
  }
}

final priorityManagerProvider = ChangeNotifierProvider<PriorityManagerNotifier>((ref) {
  return PriorityManagerNotifier();
});
