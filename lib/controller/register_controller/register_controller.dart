import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_listing_app_test/api_confiq/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _message;

  ApiConfig apiUrl = ApiConfig();

  String? get token => _token;
  String? get userId => _userId;
  String? get message => _message;

  Future<void> login(String name, String phoneNumber, VoidCallback onSuccess,
      Function(String) onError) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl.baseUrl + apiUrl.registerUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _token = data['token']['access'];
        _userId = data['user_id'];
        _message = data['message'];
        notifyListeners();

        if (_token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', _token!);
          debugPrint('Token saved to SharedPreferences: $_token');
        }
        
        onSuccess(); // Trigger success callback
      } else {
        onError('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      onError('Login failed: $e');
    }
  }
}
