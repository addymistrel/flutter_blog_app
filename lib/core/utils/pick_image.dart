import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  static Future<File?> pickImage() async {
    try {
      final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        return File(xFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
