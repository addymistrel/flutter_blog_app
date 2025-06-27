class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.profileImageUrl = '',
    required this.createdAt,
    required this.updatedAt,
  });
}
