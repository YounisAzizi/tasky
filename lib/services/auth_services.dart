import 'dart:convert';
import 'dart:io';
import 'package:Tasky/apis/end_point.dart';
import 'package:Tasky/core/utils/utils.dart';
import 'package:Tasky/domain/riverpod/loading_notifier_riv.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../domain/riverpod/profile_data_riv.dart';
import '../domain/riverpod/sign_in_riv.dart';
import '../domain/riverpod/todos_riv.dart';

class AuthServices {
  // Future<Map<String, dynamic>?> sendRequest({
  //   required String method,
  //   required String path,
  //   required Map<String, String> headers,
  //   dynamic body,
  // }) async {
  //   final Uri uri = Uri.parse('${Apis.basic}$path');
  //
  //   try {
  //     final response = await http.Client().post(
  //       uri,
  //       headers: headers,
  //       body: body != null ? json.encode(body) : null,
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return json.decode(response.body);
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error sending $method request: $e');
  //     return null;
  //   }
  // }

  Future<void> signUp(
      {required String phone,
      required String password,
      required String displayName,
      required int experienceYears,
      required String address,
      required String level,
      required BuildContext context,
      required WidgetRef ref}) async {
    try {
      print('step 1');
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'SigningUp');
      final response = await http.post(
        Uri.parse(Apis.registerUser),
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
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);
      if (response.statusCode == 201) {
        print('account created');
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access_token'] as String?;
        final id = responseBody['_id'] as String?;
        final refreshToken = responseBody['refresh_token'] as String?;

        ref.read(appDataProvider.notifier).setStoreToken(accessToken!);
        ref.read(appDataProvider.notifier).setStoreId(id!);
        ref.read(appDataProvider.notifier).setStoreRefreshToken(refreshToken!);
        ref.read(userLoginProvider).updateUserLoginState(true);
        context.go(Routes.mainScreen);
      } else if (response.statusCode == 422) {
        Utils.showSnackBar(context,'رقم الهاتف مستخدم بالفعل' );
      } else {
        print('failed');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> signIn(
      {required String phone,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    try {
      print('step 1');
      print(phone);
      print(password);

      final uri = Uri.parse(Apis.loginUser);
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'SigningIn');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phone': phone, 'password': password}),
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);
      print('step 2');
      if (response.statusCode == 201) {
        print('Login successful');
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access_token'] as String?;
        final id = responseBody['_id'] as String?;
        final refreshToken = responseBody['refresh_token'] as String?;

        ref.read(appDataProvider.notifier).setStoreToken(accessToken!);
        ref.read(appDataProvider.notifier).setStoreId(id!);
        ref.read(appDataProvider.notifier).setStoreRefreshToken(refreshToken!);
        ref.read(userLoginProvider).updateUserLoginState(true);
        print('jooooooooooooooon');
        print(accessToken);
        context.go(Routes.mainScreen);
      } else if (response.statusCode == 401) {
        Utils.showSnackBar(context,'يوجد خطأ في رقم الهاتف أو كلمة المرور' );
        print('${response.body}');
        print('${response.statusCode}');
      } else {
        print('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }


  Future<void> refreshToken(String token,WidgetRef ref,BuildContext context) async {
    final url = Uri.parse('${Apis.refreshToken}$token');

    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'Refreshing Token');
      final response = await http.get(url);
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);
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


  Future<void> logOut(
      String accessToken, BuildContext context, WidgetRef ref) async {
    final String url = Apis.logOutUser;

    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'Logging out');
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: json.encode({"token": accessToken}),
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response.statusCode == 201) {
        print('Logout successful');
        ref.read(appDataProvider).setStoreRefreshToken('refreshToken');
        ref.read(appDataProvider).setStoreId('id');
        ref.read(appDataProvider).setStoreToken('token');
        ref.read(appDataProvider).setCompleteNumber('');
        ref.read(userLoginProvider).updateUserLoginState(false);
        context.go(Routes.signInScreen);
      } else {
        print('Logout failed');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getProfile(String accessToken, WidgetRef ref,BuildContext context) async {
    final String url = Apis.profile;

    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'Getting profile data');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response.statusCode == 200) {
        final profileData = json.decode(response.body);
        print('Profile data: $profileData');
        ref.read(userDataProvider.notifier).setUserData(profileData);
      } else {
        print('Failed to get profile data');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addTodo(
      {required String accessToken,
      required String imageUrl,
      required String title,
      required String desc,
      required String priority,
      required String dueDate,
      required BuildContext context,
      required WidgetRef ref}) async {
    final url = Apis.addTodo;
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'Adding todo');
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          "image": imageUrl,
          "title": title,
          "desc": desc,
          "priority": priority, //low , medium , high
          "dueDate": dueDate
        }),
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);
      if (response.statusCode == 201) {
        Utils.showSnackBar(context,'Todo add successfully' );
        context.go(Routes.mainScreen);
      } else {
        Utils.showSnackBar(context,'${response.statusCode} ${response.body}' );
        context.go(Routes.mainScreen);
      }
    } catch (e) {
      Utils.showSnackBar(context,'$e' );
    }
  }

  Future<void> fetchListTodos(int page, String accessToken, WidgetRef ref,BuildContext context) async {
    final String url = '${Apis.fetchTodos}$page';
    print(accessToken);
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'Fetching todos');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response.statusCode == 200) {
        final List todos = json.decode(response.body);
        print('Todos fetched successfully');
        print(todos);
        ref.read(todosProvider.notifier).setTodos(todos);
      } else {
        print('Failed to fetch todos');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  //not completed
  Future<void> fetchOneTodo(int taskId, String accessToken, WidgetRef ref,BuildContext context) async {
    final String url = '${Apis.fetchTodos}$taskId';
    print(accessToken);
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'Fetching todo');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response.statusCode == 200) {
        final List todos = json.decode(response.body);
        print('Todos fetched successfully');
        print(todos);
        ref.read(todosProvider.notifier).setTodos(todos);
      } else {
        print('Failed to fetch todos');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteTodo(String todoId, String accessToken,BuildContext context,WidgetRef ref, int index) async {
    final String url = '${Apis.deleteTodo}$todoId';
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'Deleting todo');
      final response =await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);
      if(response.statusCode == 200){
        context.go(Routes.mainScreen);
        ref.read(todosProvider).removeTodoItem(index);
        Utils.showSnackBar(context,'${response.statusCode}' );

      }else{
        Utils.showSnackBar(context,'${response.statusCode}' );

        context.go(Routes.mainScreen);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> editTodoById(
      {required String todoId,
      required WidgetRef ref,
      required BuildContext context,
      required String imageUrl,
      required String title,
      required String desc,
      required String priority,
      required String status,
      required String userId}) async {
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context,'Editing todo');
      final response = await http.put(
        Uri.parse('${Apis.editTodo}$todoId'),
        headers: {
          'Authorization': 'Bearer ${ref.watch(appDataProvider).storeToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "image": imageUrl,
          "title": title,
          "desc": desc,
          "priority": priority, // low, medium, high
          "status": status,
          "user": userId
        }),
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);

      if (response.statusCode == 200) {
        Utils.showSnackBar(context,'Edit successfully' );
        context.go(Routes.mainScreen);
        print('edited todo');
        print(response.body);
        // Decode the response body
        return json.decode(response.body);
      } else {
        print(response.body);
        throw Exception('Failed to load todo: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> uploadImage(File imageFile, String token) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://todo.iraqsapp.com/upload/image'));
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Image uploaded successfully, parse response body
        return await response.stream.bytesToString();
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
