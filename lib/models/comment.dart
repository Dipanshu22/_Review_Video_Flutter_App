class Comment {
  final String userRole;
  final String content;
  final Duration timestamp;
  final List<Comment> replies;

  Comment({
    required this.userRole,
    required this.content,
    required this.timestamp,
    this.replies = const [],
  });
}
