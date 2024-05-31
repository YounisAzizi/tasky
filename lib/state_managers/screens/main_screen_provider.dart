import 'dart:convert';

import 'package:Tasky/apis/apis.dart';
import 'package:Tasky/const/end_point.dart';
import 'package:Tasky/models/status_enum.dart';
import 'package:Tasky/models/task_model.dart';
import 'package:Tasky/state_managers/screens/loading_notifier_riv.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/utils/utils.dart';
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

  List<TaskModel> _todos = [];
  List<TaskModel> get todos => _todos;
  set todos(List<TaskModel> newTodos) {
    _todos = newTodos;
    notifyListeners();
  }

  void removeTodoItem(int index) {
    var newTodos = _todos.toList();
    newTodos.removeAt(index);

    _todos = newTodos;
    notifyListeners();
  }

  Future<void> fetchListTodos(
    int page,
    WidgetRef ref,
    BuildContext context,
  ) async {
    final String url = '${Apis.fetchTodos}$page';
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Fetching todos');
      final response = await Api.get(
        url: url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.getStoreRefreshToken()}',
        },
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response == null) {
        Utils.showSnackBar(context, 'Something went wrong!');
      } else if (response.statusCode == 200) {
        final serverItems = json.decode(response.body) as List;
        final newTodos =
            serverItems.map((todo) => TaskModel.fromJson(todo)).toList();

        _todos = newTodos;
      } else {
        print('Failed to fetch todos');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
