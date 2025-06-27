import 'package:flutter_blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.profileImageUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
    uid: entity.uid,
    name: entity.name,
    email: entity.email,
    profileImageUrl: entity.profileImageUrl,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );
}
