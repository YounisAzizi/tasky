import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ImageUploadService {
  final String uploadUrl = 'https://todo.iraqsapp.com/upload/image';
      final ImagePicker picker = ImagePicker();

  Future<void> pickAndUploadImage(BuildContext context) async {
    try {
      print('done 0');
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      print('done 1');

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        print('done 2');
        await uploadImage(imageFile, context);
        print('done 3');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
      print(e);
    }
  }

  Future<void> uploadImage(File imageFile, BuildContext context) async {
    try {
      final mimeType = lookupMimeType(imageFile.path);
      final mimeTypeData = mimeType!.split('/');

      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
        ..files.add(
          await http.MultipartFile.fromPath(
            'image',
            imageFile.path,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
          ),
        );

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image upload failed with status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

}
