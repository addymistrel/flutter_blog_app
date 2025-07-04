import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blog_app/core/common/constants/blog_constants.dart';
import 'package:flutter_blog_app/core/common/constants/user_constants.dart';
import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/utils/image_upload_service.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model/blog_model.dart';

abstract interface class IBlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSource implements IBlogRemoteDataSource {
  final ImageUploadService _imageUploadService;
  final FirebaseFirestore _firebaseFirestore;

  const BlogRemoteDataSource(this._imageUploadService, this._firebaseFirestore);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogCollection = _firebaseFirestore.collection(
        BlogConstants.blogTableName,
      );
      final newBlogRef = blogCollection.doc();
      await newBlogRef.set(blog.copyWith(id: newBlogRef.id).toJson());
      final uploadedBlog = await newBlogRef.get();
      return BlogModel.fromJson(uploadedBlog.data()!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      final String? uploadedImageUrl = await _imageUploadService.uploadImage(
        image,
        blog.id,
      );

      if (uploadedImageUrl != null) {
        return uploadedImageUrl;
      }
      return "";
    } catch (e) {
      throw ServerException("Unable to upload image!");
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    final blogSnapshots = await _firebaseFirestore
        .collection(BlogConstants.blogTableName)
        .get();

    final Map<String, String> userCache = {};

    List<BlogModel> allBlogs = [];

    for (var doc in blogSnapshots.docs) {
      final blogData = doc.data();
      final userId = blogData['userId'] as String;

      String userName;
      if (userCache.containsKey(userId)) {
        userName = userCache[userId]!;
      } else {
        final userDoc = await _firebaseFirestore
            .collection(UserConstants.userTableName)
            .doc(userId)
            .get();
        userName = userDoc.data()?['name'] ?? 'Unknown';
      }

      var blog = BlogModel.fromJson(blogData);
      blog = blog.copyWith(userName: userName);
      allBlogs.add(blog);
    }

    return allBlogs;
  }
}
