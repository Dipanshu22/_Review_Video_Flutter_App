import 'package:flutter/material.dart';
import '../models/comment.dart';

class VideoProvider with ChangeNotifier {
  List<Comment> _comments = [];
  Duration _currentVideoTime = Duration.zero;

  List<Comment> get comments => _comments;
  Duration get currentVideoTime => _currentVideoTime;

  // Add a new comment
  void addComment(String content, String userRole) {
    _comments.add(Comment(
      userRole: userRole,
      content: content,
      timestamp: _currentVideoTime,
    ));
    notifyListeners(); // Notify listeners to rebuild UI
  }

  // Add a reply to a specific comment
 void addReply(int commentIndex, String replyContent) {
  if (commentIndex < _comments.length) {
    // Get the existing comment
    final comment = _comments[commentIndex];

    //  a new modifiable list of replies
    final updatedReplies = List<Comment>.from(comment.replies)
      ..add(Comment(
        userRole: "Artist",
        content: replyContent,
        timestamp: _currentVideoTime,
      ));

    // Replace the comment with the updated comment
    _comments[commentIndex] = Comment(
      userRole: comment.userRole,
      content: comment.content,
      timestamp: comment.timestamp,
      replies: updatedReplies,
    );

    notifyListeners(); 
  }
}

  // Update the current video time
  void setCurrentVideoTime(Duration time) {
    _currentVideoTime = time;
    notifyListeners();
  }
}


