import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodosNotifier extends ChangeNotifier {
  List<dynamic> _todos = [];

  List<dynamic> get todos => _todos;

  TodosNotifier() {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosString = prefs.getString('todos');
    if (todosString != null) {
      _todos = json.decode(todosString);
    }
    notifyListeners();
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('todos', json.encode(_todos));
  }

  void setTodos(List<dynamic> newTodos) {
    _todos = newTodos;
    _saveTodos();
    notifyListeners();
  }

  void addTodoItem(dynamic value) {
    _todos.add(value);
    _saveTodos();
    notifyListeners();
  }

  void removeTodoItem(int index) {
    _todos.removeAt(index);
    _saveTodos();
    notifyListeners();
  }
}

final todosProvider = ChangeNotifierProvider<TodosNotifier>((ref) {
  return TodosNotifier();
});
