import 'dart:io';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';

class ImageUploadService {
  final Cloudinary _cloudinary;
  ImageUploadService(this._cloudinary);

  Future<String?> uploadImage(File file, String fileName) async {
    try {
      final uploadResult = await _cloudinary.uploader().upload(file);

      if (uploadResult != null) {
        if (uploadResult.data != null) {
          var imageUrl = uploadResult.data?.secureUrl;
          return imageUrl;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
