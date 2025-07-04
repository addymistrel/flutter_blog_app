import 'package:flutter_blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_model.g.dart';

@JsonSerializable()
class BlogModel extends BlogEntity {
  BlogModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.createdAt,
    required super.updatedAt,
    super.userName,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogModelToJson(this);

  factory BlogModel.fromEntity(BlogEntity entity) => BlogModel(
    id: entity.id,
    userId: entity.userId,
    title: entity.title,
    content: entity.content,
    imageUrl: entity.imageUrl,
    topics: entity.topics,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );

  BlogModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userName: userName ?? this.userName,
    );
  }
}
