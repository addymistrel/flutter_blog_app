import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
    : _uploadBlog = uploadBlog,
      _getAllBlogs = getAllBlogs,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onUploadBlog);
    on<BlogsGetAll>(_onGetAllBlogs);
  }

  void _onUploadBlog(BlogUpload event, Emitter emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        userId: event.userId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (success) => emit(BlogSuccess()),
    );
  }

  void _onGetAllBlogs(BlogsGetAll event, Emitter emit) async {
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (success) => emit(BlogDisplaySuccess(success)),
    );
  }
}
