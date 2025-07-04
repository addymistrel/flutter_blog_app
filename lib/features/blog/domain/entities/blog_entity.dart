class BlogEntity {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String? imageUrl;
  final List<String> topics;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userName;

  BlogEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.createdAt,
    required this.updatedAt,
    this.userName,
  });
}
