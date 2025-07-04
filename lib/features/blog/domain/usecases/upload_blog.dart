import 'dart:io';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter_blog_app/features/blog/domain/repositories/i_blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecase<BlogEntity, UploadBlogParams> {
  final IBlogRepository _blogRepository;
  const UploadBlog(this._blogRepository);

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await _blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      userId: params.userId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.userId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
