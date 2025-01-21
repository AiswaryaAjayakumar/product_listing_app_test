import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:product_listing_app_test/api_confiq/api_config.dart';
import 'package:product_listing_app_test/model/api_get_products/api_get_products.dart';

class SearchProductController with ChangeNotifier {
  ApiConfig apiUrl = ApiConfig();

  Future<List<ApiGetProducts>> searchProduct(String qry) async {
    try {
      final Map<String, dynamic> dataToSend = {"query": qry};

      final response = await http.post(
        Uri.parse(apiUrl.baseUrl + apiUrl.searchPrdct),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(dataToSend),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<ApiGetProducts> products = jsonData
            .map((productJson) => ApiGetProducts.fromJson(productJson))
            .toList();
        return products;
      } else {
        throw Exception('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while searching for products: $e');
    }
  }
}
