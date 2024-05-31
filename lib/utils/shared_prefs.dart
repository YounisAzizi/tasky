import 'dart:convert';

import 'package:Tasky/models/shared_pref_keys_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static String getCompleteNumber() =>
      _instance.getString(SharedPrefKeys.completeNumberKey.name) ?? '';
  static Future<bool> setCompleteNumber(String completeNumber) => _instance
      .setString(SharedPrefKeys.completeNumberKey.name, completeNumber);

  static String? getStoreToken() =>
      _instance.getString(SharedPrefKeys.storeTokenKey.name);
  static Future<bool> setStoreToken(String storeToken) =>
      _instance.setString(SharedPrefKeys.storeTokenKey.name, storeToken);

  static String? getStoreId() =>
      _instance.getString(SharedPrefKeys.storeIdKey.name);
  static Future<bool> setStoreId(String storeId) =>
      _instance.setString(SharedPrefKeys.storeIdKey.name, storeId);

  static String? getStoreRefreshToken() =>
      _instance.getString(SharedPrefKeys.storeRefreshTokenKey.name);
  static Future<bool> setStoreRefreshToken(String refreshToken) => _instance
      .setString(SharedPrefKeys.storeRefreshTokenKey.name, refreshToken);

  static bool getIsUserLoggedIn() =>
      _instance.getBool(SharedPrefKeys.userLoggedInKey.name) ?? false;
  static Future<bool> setIsUserLoggedIn(bool isLoggedIn) =>
      _instance.setBool(SharedPrefKeys.userLoggedInKey.name, isLoggedIn);

  static String? getTodos() =>
      _instance.getString(SharedPrefKeys.todosKey.name);
  static Future<bool> setTodos(List<dynamic> todos) =>
      _instance.setString(SharedPrefKeys.todosKey.name, json.encode(todos));

  static void clear() => _instance.clear();
}
