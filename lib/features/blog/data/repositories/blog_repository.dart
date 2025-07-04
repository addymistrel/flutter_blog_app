import 'dart:io';

import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/utils/time_service.dart';
import 'package:flutter_blog_app/features/blog/data/datasource/blog_remote_data_source.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model/blog_model.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter_blog_app/features/blog/domain/repositories/i_blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class BlogRepository implements IBlogRepository {
  final IBlogRemoteDataSource _blogRemoteDataSource;
  final TimeService _timeService;
  const BlogRepository(this._blogRemoteDataSource, this._timeService);

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: "",
        userId: userId,
        title: title,
        content: content,
        imageUrl: null,
        topics: topics,
        createdAt: _timeService.getAccurateNow(),
        updatedAt: _timeService.getAccurateNow(),
      );

      final imageUrl = await _blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await _blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final allBlogsList = await _blogRemoteDataSource.getAllBlogs();
      return right(allBlogsList);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
