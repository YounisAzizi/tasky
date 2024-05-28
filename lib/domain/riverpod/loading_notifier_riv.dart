import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void showLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
final loadingProvider = ChangeNotifierProvider((_) => LoadingNotifier());

