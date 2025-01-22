import 'package:flutter/material.dart';
import 'package:product_listing_app_test/controller/product_list_controller/product_list_controller.dart';
import 'package:product_listing_app_test/controller/register_controller/register_controller.dart';
import 'package:product_listing_app_test/controller/slider_controller/slider_controller.dart';
import 'package:product_listing_app_test/controller/user_details_controller/user_details_controller.dart';
import 'package:product_listing_app_test/controller/verify_user_controller/verify_user_controller.dart';
import 'package:product_listing_app_test/controller/wishlist_controller/wishlist_controller.dart';
import 'package:product_listing_app_test/view/Login_screen/Login_screen.dart';

import 'package:product_listing_app_test/view/home_screen/home_screen.dart';
import 'package:product_listing_app_test/view/otp_screen/otp_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const ProductListingApp());
}

class ProductListingApp extends StatelessWidget {
  const ProductListingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterController(),
        ),
        ChangeNotifierProvider(
          create: (context) => VerifyUserController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductListController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDetailsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SliderController(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistListController(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
