import 'package:flutter/material.dart';
import 'package:product_listing_app_test/utils/text_constants.dart';
import 'package:product_listing_app_test/view/home_screen/widgets/custom_product_list.dart';
import 'package:provider/provider.dart';
import 'package:product_listing_app_test/controller/wishlist_controller/wishlist_controller.dart';
import 'package:product_listing_app_test/model/api_get_products/api_get_products.dart';

class WishlistScreen extends StatelessWidget {
  final List<ApiGetProducts>
      allProducts; 

  const WishlistScreen({Key? key, required this.allProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: MytextStyle.headingText,
        ),
      ),
      body: Consumer<WishlistListController>(
        builder: (context, wishlistProvider, child) {
          final wishlistProducts = allProducts
              .where((product) =>
                  product.id != null &&
                  wishlistProvider.isFavorite(product.id!))
              .toList();

          if (wishlistProducts.isEmpty) {
            return const Center(
              child: Text(
                'Your wishlist is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return CustomProductList(products: wishlistProducts);
        },
      ),
    );
  }
}
