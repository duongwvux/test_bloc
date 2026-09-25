import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:prj/features/domain/repositories/user_repository.dart';

import '../../domain/entities/api_user.dart';

class ApiUserRepository implements UserRepository {
  final http.Client _client = http.Client();
  final String _token;
  final Map<String, dynamic>? _requestBody;

  ApiUserRepository({
    required String token,
    Map<String, dynamic>? requestBody,
  }) : _token = token,
       _requestBody = requestBody;

  @override
  Future<List<ApiUser>> loadUsers() async {
    if (_token.trim().isEmpty) {
      throw Exception('Thiếu token');
    }

    final response = await _client.post(
      Uri.parse('https://me.koolsoftelearning.com/api/load-user-by-work-status'),
      headers: {
        'Authorization': 'Bearer ${_token.trim()}',
        'Content-Type': 'application/json',
      },
      body: _requestBody == null ? null : jsonEncode(_requestBody),
    ).timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw Exception('API trả HTTP ${response.statusCode}');
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));

    return decoded.map<ApiUser>((item) {
      return ApiUser.fromJson(item);
    }).toList();
  }
  @override
  void close() {
    _client.close();
  }
}