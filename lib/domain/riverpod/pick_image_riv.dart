

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PickImageNotifier extends ChangeNotifier{
  File? _imageFile;

  File? get imageFile=> _imageFile;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        print('pickImage');
        print(_imageFile);
        notifyListeners();
    }
  }
}
final pickImageProvider = ChangeNotifierProvider((ref) {
  return PickImageNotifier();
},);