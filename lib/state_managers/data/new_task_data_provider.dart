import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newTaskDataProvider = ChangeNotifierProvider<NewTaskDataProvider>(
  (ref) => NewTaskDataProvider(),
);

class NewTaskDataProvider extends ChangeNotifier {}
