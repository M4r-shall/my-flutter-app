import 'dart:convert';
import 'package:http/http.dart';
import '../models/comment.dart';

class CommentService {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<Comment>> getCommentsByPost(int postId) async {
    final uri = Uri.parse('$baseUrl/comments/post/$postId');
    final response = await get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List commentsJson = data['comments'] ?? [];
      return commentsJson.map((c) => Comment.fromJson(c)).toList();
    } else {
      throw Exception('Failed to load comments for post: ${response.statusCode}');
    }
  }

  Future<Comment> addComment(String body, int postId, int userId) async {
    final uri = Uri.parse('$baseUrl/comments/add');
    final response = await post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'body': body,
        'postId': postId,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Comment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add comment: ${response.statusCode}');
    }
  }
}
