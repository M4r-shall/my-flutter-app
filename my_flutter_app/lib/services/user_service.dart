import 'dart:convert';
import 'package:http/http.dart';
import '../models/user.dart';

class UserService {
  final String baseUrl = 'https://dummyjson.com';

  Future<User?> login(String username, String password) async {
    final uri = Uri.parse('$baseUrl/auth/login');
    final response = await post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 60, // optional
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
