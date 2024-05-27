import 'dart:convert';
import 'package:Tasky/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart'as http;
import '../domain/riverpod/profile_data_riv.dart';
import '../domain/riverpod/sign_in_riv.dart';
import '../domain/riverpod/todos_riv.dart';

class AuthServices {
  final String baseUrl = 'https://todo.iraqsapp.com/auth';
  Future<void> signUp({
    required String phone,
    required String password,
    required String displayName,
    required int experienceYears,
    required String address,
    required String level,
    required BuildContext context,
    required WidgetRef ref
  }) async {
    try {
      print('step 1');
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "phone": phone,
          "password": password,
          "displayName": displayName,
          "experienceYears": '${experienceYears}',
          "address": address,
          "level": level
        }),
      );
      print('step 2');

      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        print('account created');
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access_token'] as String?;
        final id = responseBody['_id'] as String?;
        final refreshToken = responseBody['refresh_token'] as String?;

        ref.read(storeTokenProvider.notifier).state = accessToken!;
        ref.read(storeIdProvider.notifier).state = id!;
        ref.read(storeRefreshTokenProvider.notifier).state = refreshToken!;
        context.go(Routes.mainScreen);
      }else if(response.statusCode == 422){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('رقم الهاتف مستخدم بالفعل'))
        );
      } else {
        print('failed');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> signIn({
    required String phone,
    required String password,
    required BuildContext context,
    required WidgetRef ref
  }) async {
    try {
      print('step 1');
      print(phone);
      print(password);

      final uri = Uri.parse('https://todo.iraqsapp.com/auth/login');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phone': phone, 'password': password}),
      );

      print('step 2');
      if (response.statusCode == 201) {
        print('Login successful');
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access_token'] as String?;
        final id = responseBody['_id'] as String?;
        final refreshToken = responseBody['refresh_token'] as String?;

        ref.read(storeTokenProvider.notifier).state = accessToken!;
        ref.read(storeIdProvider.notifier).state = id!;
        ref.read(storeRefreshTokenProvider.notifier).state = refreshToken!;
        print('jooooooooooooooon');
        print(accessToken);
        context.go(Routes.mainScreen);
      }else if(response.statusCode == 401){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('يوجد خطأ في رقم الهاتف أو كلمة المرور'))
        );

      } else {
        print('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
    }

   
  }
  Future<void> refreshToken(String token) async {
    final url = Uri.parse('${baseUrl}/refresh-token?token=$token');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Token refresh successful');
      } else {
        print('Token refresh failed: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error refreshing token: $e');
    }
  }
  Future<void> logOut(String accessToken,BuildContext context) async {
    final String url = '${baseUrl}/logout';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          "token": accessToken
        }),
      );

      if (response.statusCode == 201) {
        print('Logout successful');
        context.go(Routes.signInScreen);
      } else {
        print('Logout failed');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }  Future<void> getProfile(String accessToken,WidgetRef ref) async {
    final String url = '${baseUrl}/profile';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final profileData = json.decode(response.body);
        print('Profile data: $profileData');
        ref.read(userDataProvider.notifier).state = profileData;
      } else {
        print('Failed to get profile data');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> fetchTodos(int page, String accessToken,WidgetRef ref) async {
    final String url = 'https://todo.iraqsapp.com/todos?page=$page';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List todos = json.decode(response.body);
        print('Todos fetched successfully');
        print(todos);
        ref.read(todosProvider.notifier).state= todos;
      } else {
        print('Failed to fetch todos');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>> editTodoById(String todoId,WidgetRef ref,BuildContext context) async {

    final response = await http.get(
      Uri.parse('https://todo.iraqsapp.com/todos/$todoId'),
      headers: {
        'Authorization': 'Bearer ${ref.watch(storeTokenProvider)}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Edit successfully'))
      );
      // Decode the response body
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load todo: ${response.statusCode}');
    }
  }


}

