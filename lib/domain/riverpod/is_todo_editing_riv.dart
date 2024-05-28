import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoEditingNotifier extends ChangeNotifier {
  bool _isEditing = false;

  bool get isEditing => _isEditing;

  void setEditing(bool isEditing) {
    _isEditing = isEditing;
    notifyListeners();
  }
}
final isTodoEditingProvider = ChangeNotifierProvider((ref) {
  return TodoEditingNotifier();
});
