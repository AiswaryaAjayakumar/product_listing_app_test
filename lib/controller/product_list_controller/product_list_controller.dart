// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:product_listing_app_test/api_confiq/api_config.dart';
// import 'package:product_listing_app_test/model/api_get_products/api_get_products.dart';

// class ProductListController with ChangeNotifier {
//   ApiGetProducts? products;
//   bool loadingVariable = false;
//   ApiConfig apiUrl = ApiConfig();

//   Future<ApiGetProducts?> getProducts() async {
//     try {
//       loadingVariable = true;
//       notifyListeners();

//       final response = await http.get(
//         Uri.parse(apiUrl.baseUrl + apiUrl.productUrl),
//       );

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);

//         // Log the response body for debugging
//         print('Response Body: $jsonData');

//         // Check if the response is valid and matches the expected structure
//         if (jsonData != null && jsonData is Map<String, dynamic>) {
//           products = ApiGetProducts.fromJson(jsonData);
//           print('Products: ${products?.caption}'); // Log products data for debugging
//         } else {
//           print('Unexpected response format');
//         }
//       } else {
//         print('Failed to fetch products. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching products: $e');
//     } finally {
//       loadingVariable = false;
//       notifyListeners();
//     }

//     return products;
//   }
// }

// product_controller.dart

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:product_listing_app_test/api_confiq/api_config.dart';
import 'package:product_listing_app_test/model/api_get_products/api_get_products.dart';

class ProductListController with ChangeNotifier {
  ApiConfig apiUrl = ApiConfig();
  Future<List<ApiGetProducts>> getProducts() async {
    final response =
        await http.get(Uri.parse(apiUrl.baseUrl + apiUrl.productUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ApiGetProducts.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load products. Status code: ${response.statusCode}');
    }
  }
}
