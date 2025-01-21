// lib/controller/user_details_controller/user_details_controller.dart

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:product_listing_app_test/api_confiq/api_config.dart';
import 'package:product_listing_app_test/model/api_get_user_details/api_get_user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsController with ChangeNotifier {
  final ApiConfig apiUrl = ApiConfig();

 Future<ApiGetUserDetails> fetchUserData() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found. Please log in.');
    }

    debugPrint('Retrieved token: $token'); // Debug statement

    final response = await http.get(
      Uri.parse(apiUrl.baseUrl + apiUrl.UserDetails),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response status: ${response.statusCode}'); // Debug statement
    debugPrint('Response body: ${response.body}'); // Debug statement

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ApiGetUserDetails.fromJson(data);
    } else {
      throw Exception('Failed to fetch user details: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching user details: $e');
  }
}

}
