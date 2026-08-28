class CommentUser {
  final int id;
  final String username;
  final String fullName;

  CommentUser({
    required this.id,
    required this.username,
    required this.fullName,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
    };
  }
}

class Comment {
  final int id;
  final String body;
  final int postId;
  final int likes;
  final CommentUser? user;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    this.likes = 0,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      postId: json['postId'] ?? 0,
      likes: json['likes'] ?? 0,
      user: json['user'] != null ? CommentUser.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'postId': postId,
      'likes': likes,
      'user': user?.toJson(),
    };
  }
}
