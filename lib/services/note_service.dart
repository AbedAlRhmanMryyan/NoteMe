
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/note.dart';
import 'auth_service.dart';

class NoteService {
  // GET AUTHENTICATION HEADERS
  static Future<Map<String, String>> headers() async {
    final token = await AuthService.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Please login first. Authentication token missing.');
    }

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // GET ALL NOTES
  static Future<List<Note>> getNotes() async {
    try {
      final response = await http
          .get(
            Uri.parse('${ApiConfig.baseUrl}notes'),
            headers: await headers(),
          )
          .timeout(const Duration(seconds: 15));

      debugPrint('GET NOTES STATUS: ${response.statusCode}');
      debugPrint('GET NOTES RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is! List) {
          throw Exception('Unexpected notes response format');
        }

        return decoded
            .map((item) => Note.fromJson(item))
            .toList();
      }

      throw Exception(
        'Failed to load notes: ${response.statusCode} ${response.body}',
      );
    } catch (e) {
      debugPrint('GET NOTES ERROR: $e');
      rethrow;
    }
  }

  // CREATE NOTE
  static Future<bool> createNote(
    String title,
    String content,
  ) async {
    final response = await http
        .post(
          Uri.parse('${ApiConfig.baseUrl}notes'),
          headers: await headers(),
          body: jsonEncode({
            'title': title,
            'content': content,
          }),
        )
        .timeout(const Duration(seconds: 15));

    debugPrint('CREATE NOTE STATUS: ${response.statusCode}');
    debugPrint('CREATE NOTE RESPONSE: ${response.body}');

    return response.statusCode == 201;
  }

  // UPDATE NOTE
  static Future<bool> updateNote(
    int id,
    String title,
    String content,
  ) async {
    final response = await http
        .put(
          Uri.parse('${ApiConfig.baseUrl}notes/$id'),
          headers: await headers(),
          body: jsonEncode({
            'title': title,
            'content': content,
          }),
        )
        .timeout(const Duration(seconds: 15));

    debugPrint('UPDATE NOTE STATUS: ${response.statusCode}');
    debugPrint('UPDATE NOTE RESPONSE: ${response.body}');

    return response.statusCode == 200;
  }

  // DELETE NOTE
  static Future<bool> deleteNote(int id) async {
    final response = await http
        .delete(
          Uri.parse('${ApiConfig.baseUrl}notes/$id'),
          headers: await headers(),
        )
        .timeout(const Duration(seconds: 15));

    debugPrint('DELETE NOTE STATUS: ${response.statusCode}');
    debugPrint('DELETE NOTE RESPONSE: ${response.body}');

    return response.statusCode == 200;
  }
}
