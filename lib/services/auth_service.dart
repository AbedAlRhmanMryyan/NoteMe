
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';

class AuthService {
  // REGISTER
  static Future<bool> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}register'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'username': username,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 15));

      debugPrint('REGISTER STATUS: ${response.statusCode}');
      debugPrint('REGISTER RESPONSE: ${response.body}');

      return response.statusCode == 201;
    } catch (error) {
      debugPrint('REGISTER ERROR: $error');
      return false;
    }
  }

  // LOGIN
  static Future<bool> login(
    String username,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}login'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'username': username,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 15));

      debugPrint('LOGIN STATUS: ${response.statusCode}');
      debugPrint('LOGIN RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data['token'];
        final returnedUsername = data['user']['username'];

        if (token == null || returnedUsername == null) {
          debugPrint('LOGIN ERROR: Missing token or username');
          return false;
        }

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('token', token.toString());
        await prefs.setString(
          'username',
          returnedUsername.toString(),
        );

        return true;
      }

      return false;
    } catch (error) {
      debugPrint('LOGIN ERROR: $error');
      return false;
    }
  }

  // LOGOUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
    await prefs.remove('username');
  }

  // GET SAVED TOKEN
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('token');
  }
}
