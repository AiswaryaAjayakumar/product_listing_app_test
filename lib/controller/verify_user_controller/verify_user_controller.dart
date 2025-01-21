import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_listing_app_test/api_confiq/api_config.dart';

class VerifyUserController with ChangeNotifier {
  ApiConfig apiUrl = ApiConfig();

  Future<bool?> verifyUser(String phn) async {
    try {
      final Map<String, dynamic> dataToSend = {"phone_number": phn};

      final response = await http.post(
        Uri.parse(apiUrl.baseUrl + apiUrl.verifyUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(dataToSend),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final bool userExists = responseData["user"];
        final String otp = responseData["otp"];
        final String accessToken = responseData["token"]["access"];

        print('OTP: $otp');
        print('Access Token: $accessToken');
        print('User Exists: $userExists');

        return userExists; // Return user existence status
      } else {
        print('Failed to verify user: ${response.statusCode}');
        return null; // Indicate an error with `null`
      }
    } catch (e) {
      print('Error during verification: $e');
      return null; // Indicate an error with `null`
    }
  }
}
