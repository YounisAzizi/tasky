import 'dart:convert';
import 'dart:io';

import 'package:Tasky/apis/apis.dart';
import 'package:Tasky/const/end_point.dart';
import 'package:Tasky/models/priorities_enum.dart';
import 'package:Tasky/models/task_model.dart';
import 'package:Tasky/models/ui_status_enum.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/screens/loading_notifier_riv.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

final newTaskScreenProvider = ChangeNotifierProvider<NewTaskScreenProvider>(
  (ref) => NewTaskScreenProvider(),
);

class NewTaskScreenProvider extends ChangeNotifier {
  File? _imageFile;
  get imageFile => _imageFile;
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  List<PrioritiesEnum> _priorities = [
    PrioritiesEnum.low,
    PrioritiesEnum.medium,
    PrioritiesEnum.high,
  ];
  List<PrioritiesEnum> get priorities => _priorities;
  set priorities(List<PrioritiesEnum> newPriorities) {
    _priorities = newPriorities;
    notifyListeners();
  }

  List<UiStatus> _statuses = [
    UiStatus.inprogress,
    UiStatus.waiting,
    UiStatus.finished,
  ];
  List<UiStatus> get statuses => _statuses;
  set statuses(List<UiStatus> newStatuses) {
    _statuses = newStatuses;
    notifyListeners();
  }

  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool isEditing) {
    _isEditing = isEditing;
    notifyListeners();
  }

  Future<void> onSavedTask({
    required TaskModel taskModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    debugPrint('Mahdi: onSavedTask: 2: $_imageFile');
    debugPrint('Mahdi: onSavedTask: 3: ${SharedPrefs.getStoreToken()}');
    if (_imageFile != null) {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Uploading image');

      await Api.uploadImage(
        _imageFile!,
        SharedPrefs.getStoreToken() ?? '',
      );

      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);
    }
    if (isEditing) {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Editing todo');

      await editTodoById(
        ref: ref,
        context: context,
        taskModel: taskModel,
      );
    } else {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Adding todo');

      await addTodo(
        context: context,
        ref: ref,
        taskModel: taskModel,
      );
    }

    ref.read(loadingProvider).hideLoading();
    Utils.hideLoadingDialog(context);
    _imageFile = null;
  }

  static Future<void> editTodoById({
    required TaskModel taskModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      final response = await Api.put(
        url: '${Apis.editTodo}${taskModel.id}',
        headers: {
          'Authorization': 'Bearer ${SharedPrefs.getStoreToken()}',
          'Content-Type': 'application/json',
        },
        body: taskModel.toJson(),
      );
      if (response == null) {
        Utils.showSnackBar(context, 'Something went wrong!');
      } else if (response.statusCode == 200) {
        Utils.showSnackBar(context, 'Edit successfully');
        context.go(Routes.mainScreen);

        return json.decode(response.body);
      } else {
        throw Exception('Failed to load todo: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> addTodo({
    required TaskModel taskModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final url = Apis.addTodo;
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Adding todo');
      final response = await Api.post(
        url: url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.getStoreToken()}',
        },
        data: taskModel.toJson(),
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);
      if (response == null) {
        Utils.showSnackBar(context, 'Something went wrong!');
      } else if (response.statusCode == 201) {
        Utils.showSnackBar(context, 'Todo add successfully');
        context.go(Routes.mainScreen);
      } else {
        Utils.showSnackBar(context, '${response.statusCode} ${response.body}');
        context.go(Routes.mainScreen);
      }
    } catch (e) {
      Utils.showSnackBar(context, '$e');
    }
  }
}
