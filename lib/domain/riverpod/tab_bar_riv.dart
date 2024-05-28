import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Status { all, inProgress, waiting, finished }

class StatusNotifier extends ChangeNotifier {
  Status _selectedStatus = Status.all;

  Status get selectedStatus => _selectedStatus;

  void setSelectedStatus(Status status) {
    _selectedStatus = status;
    notifyListeners();
  }
}


final statusProvider = ChangeNotifierProvider<StatusNotifier>((ref) => StatusNotifier());
