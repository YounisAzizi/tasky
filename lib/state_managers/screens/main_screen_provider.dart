import 'package:Tasky/models/status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainScreenProvider =
    ChangeNotifierProvider<MainScreenProvider>((ref) => MainScreenProvider());

class MainScreenProvider extends ChangeNotifier {
  Status _selectedStatus = Status.all;
  Status get selectedStatus => _selectedStatus;
  void setSelectedStatus(Status status) {
    _selectedStatus = status;
    notifyListeners();
  }

  List<dynamic> _todos = [];
  List<dynamic> get todos => _todos;
  set todos(List<dynamic> newTodos) {
    _todos = newTodos;
    notifyListeners();
  }

  void removeTodoItem(int index) {
    final newTodos = _todos.toList().removeAt(index);

    _todos = newTodos;
    notifyListeners();
  }
}
