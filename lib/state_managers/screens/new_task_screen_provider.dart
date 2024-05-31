import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final newTaskScreenProvider = ChangeNotifierProvider<NewTaskScreenProvider>(
  (ref) => NewTaskScreenProvider(),
);

class NewTaskScreenProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  set selectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

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

  List<String> _priorities = ['low', 'medium', 'high'];
  List<String> get priorities => _priorities;
  set priorities(List<String> newPriorities) {
    _priorities = newPriorities;
    notifyListeners();
  }

  String _selectedPriority = 'medium';
  String get selectedPriority => _selectedPriority;
  set selectedPriority(String priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  String _selectedStatus = 'waiting';
  String get selectedStatus => _selectedStatus;
  set selectedStatus(String status) {
    _selectedStatus = status;
    notifyListeners();
  }

  List<String> _statuses = ['waiting', 'inprogress', 'finished'];
  List<String> get statuses => _statuses;
  set statuses(List<String> newStatuses) {
    _statuses = newStatuses;
    notifyListeners();
  }

  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool isEditing) {
    _isEditing = isEditing;
    notifyListeners();
  }
}
