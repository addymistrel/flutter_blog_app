class BlogConstants {
  static final List<String> blogCategories = [
    "Technology",
    "Business",
    "Programming",
    "Entertainment",
  ];

  static final String blogTableName = "blogs";

  static final String refreshQueryIdentifier = "refresh";

  static String get refreshQuery =>
      "$refreshQueryIdentifier=${DateTime.now().millisecondsSinceEpoch}";

  static final String staticMemeberKey = "static";
}
