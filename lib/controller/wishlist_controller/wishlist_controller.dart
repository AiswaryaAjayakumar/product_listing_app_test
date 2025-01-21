import 'package:flutter/material.dart';
import 'package:product_listing_app_test/model/api_get_products/api_get_products.dart';

class WishlistListController with ChangeNotifier {
  final Set<int> _favoriteProductIds = {};
  List<ApiGetProducts> _allProducts = [];

  // Getter to retrieve favorite product IDs
  Set<int> get favoriteProductIds => _favoriteProductIds;

  // Getter to retrieve all products
  List<ApiGetProducts> get allProducts => _allProducts;

  // Method to set all products
  void setAllProducts(List<ApiGetProducts> products) {
    _allProducts = products;
    notifyListeners();
  }

  // Method to toggle favorite status
  void toggleFavoriteStatus(ApiGetProducts product) {
    if (product.id == null) return;

    if (_favoriteProductIds.contains(product.id)) {
      _favoriteProductIds.remove(product.id);
      debugPrint("Removed from wishlist: ${product.id}");
    } else {
      _favoriteProductIds.add(product.id!);
      debugPrint("Added to wishlist: ${product.id}");
    }
    notifyListeners();
  }

  // Method to check if a product is favorite
  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId);
  }

  // Method to retrieve favorite products
  List<ApiGetProducts> getFavoriteProducts() {
    return _allProducts
        .where((product) =>
            product.id != null && _favoriteProductIds.contains(product.id))
        .toList();
  }



  
}
