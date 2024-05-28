import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SelectedDateNotifier extends ChangeNotifier {
  DateTime _selectedDate;

  SelectedDateNotifier(this._selectedDate);

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}

final selectedDateProvider = ChangeNotifierProvider<SelectedDateNotifier>((ref) {
  return SelectedDateNotifier(DateTime.now());
});
