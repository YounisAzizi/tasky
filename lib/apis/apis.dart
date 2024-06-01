import 'dart:convert';
import 'dart:io';

import 'package:Tasky/const/end_point.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class Api {
  static Future<http.Response?> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      return await http.get(
        Uri.parse(url),
        headers: headers,
      );
    } catch (e) {
      debugPrint('GET: Error: $e');

      return null;
    }
  }

  static Future<http.Response?> post({
    required String url,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    try {
      return await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
      );
    } catch (e) {
      debugPrint('POST: Error: $e');

      return null;
    }
  }

  static Future<http.Response?> delete({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      return await http.delete(
        Uri.parse(url),
        headers: headers,
      );
    } catch (e) {
      debugPrint('DELETE: Error: $e');

      return null;
    }
  }

  static Future<http.Response?> put({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      return await http.put(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
    } catch (e) {
      debugPrint('PUT: Error: $e');
      return null;
    }
  }

  static Future<void> uploadImage(File imageFile, String token) async {
    try {
      var url = Uri.parse(Apis.uploadImage);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(
        http.MultipartFile(
          'image',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: p.basename(imageFile.path),
        ),
      );
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        print('Image uploaded successfully ${responseBody}');
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to upload image: ${e}');
    }
  }
}
