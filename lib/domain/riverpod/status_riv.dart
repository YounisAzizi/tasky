import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusManagerNotifier extends ChangeNotifier {
  String _selectedStatus = 'waiting';
  List<String> _statuses = ['waiting', 'inprogress', 'finished'];

  String get selectedStatus => _selectedStatus;
  List<String> get statuses => _statuses;

  void setStatus(String status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void setStatuses(List<String> newStatuses) {
    _statuses = newStatuses;
    notifyListeners();
  }
}

final statusManagerProvider = ChangeNotifierProvider<StatusManagerNotifier>((ref) {
  return StatusManagerNotifier();
});
