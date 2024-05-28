import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDataNotifier extends ChangeNotifier {
  String _completeNumber = '';
  String _storeToken = 'token';
  String _storeId = 'id';
  String _storeRefreshToken = 'refreshToken';

  String get completeNumber => _completeNumber;
  String get storeToken => _storeToken;
  String get storeId => _storeId;
  String get storeRefreshToken => _storeRefreshToken;

  AppDataNotifier() {
    _loadData();
  }

  Future<void> _loadData() async {
    print('completeNumber _loadData ');
    final prefs = await SharedPreferences.getInstance();
    print('completeNumber _loadData 1');
    _completeNumber = prefs.getString('completeNumber') ?? '';
    _storeToken = prefs.getString('storeToken') ?? 'token';
    _storeId = prefs.getString('storeId') ?? 'id';
    _storeRefreshToken = prefs.getString('storeRefreshToken') ?? 'refreshToken';
    notifyListeners();
  }

  Future<void> _saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void setCompleteNumber(String value) {
    _completeNumber = value;
    _saveData('completeNumber', value);
    notifyListeners();
  }

  void setStoreToken(String value) {
    _storeToken = value;
    _saveData('storeToken', value);
    notifyListeners();
  }

  void setStoreId(String value) {
    _storeId = value;
    _saveData('storeId', value);
    notifyListeners();
  }

  void setStoreRefreshToken(String value) {
    _storeRefreshToken = value;
    _saveData('storeRefreshToken', value);
    notifyListeners();
  }
}

final appDataProvider = ChangeNotifierProvider<AppDataNotifier>((ref) {
  return AppDataNotifier();
});

class UserLoginNotifier extends ChangeNotifier {
  static const _keyUserLoggedIn = 'userLoggedIn';

  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

  // Constructor to initialize SharedPreferences and retrieve user login state
  UserLoginNotifier() {
    _loadFromPrefs();
  }

  // Method to load user login state from SharedPreferences
  Future<void> _loadFromPrefs() async {
    try {
      print('_loadFromPrefs');
      final prefs = await SharedPreferences.getInstance();
      print('_loadFromPrefs1');

      _isUserLoggedIn = prefs.getBool(_keyUserLoggedIn)!;
      notifyListeners();
    }catch (e){
      print('_loadFromPrefs error: $e');
    }
  }

  // Method to update user login state and save it to SharedPreferences
  Future<void> updateUserLoginState(bool isLoggedIn) async {
    print('isLoggedIn');
    print('isLoggedIn');
    print('isLoggedIn1');
    print(isLoggedIn);
    _isUserLoggedIn = isLoggedIn;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyUserLoggedIn, isLoggedIn);
    print('User login state updated: $isLoggedIn');
    notifyListeners();
  }
}

// Define a ChangeNotifierProvider for UserLoginNotifier
final userLoginProvider = ChangeNotifierProvider<UserLoginNotifier>((ref) {
  return UserLoginNotifier();
});
