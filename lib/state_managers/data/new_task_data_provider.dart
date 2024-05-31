import 'package:Tasky/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newTaskDataProvider = ChangeNotifierProvider<NewTaskDataProvider>(
  (ref) => NewTaskDataProvider(),
);

class NewTaskDataProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  TaskModel _taskModel = defaultTaskModel;
  TaskModel get taskModel => _taskModel;
  set taskModel(TaskModel taskModel) {
    _taskModel = taskModel;
    notifyListeners();
  }

  void init(TaskModel taskModel) {
    _taskModel = taskModel;
    notifyListeners();
  }
}
