import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusManagerNotifier extends ChangeNotifier {
  String _selectedStatus = 'Waiting';
  List<String> _statuses = ['Waiting', 'Inprogress', 'Finished'];

  String get selectedStatus => _selectedStatus;
  List<String> get statuses => _statuses;

  void setStatus(String priority) {
    _selectedStatus = priority;
    notifyListeners();
  }

  void setStatuses(List<String> newPriorities) {
    _statuses = newPriorities;
    notifyListeners();
  }
}

final statusManagerProvider = ChangeNotifierProvider<StatusManagerNotifier>((ref) {
  return StatusManagerNotifier();
});
