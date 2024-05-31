import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  static Future<String?> uploadImage(File imageFile, String token) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://todo.iraqsapp.com/upload/image'));
      request.headers['Authorization'] = 'Bearer $token';
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));

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
