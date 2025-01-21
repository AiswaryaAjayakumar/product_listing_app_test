import 'package:flutter/material.dart';
import 'package:product_listing_app_test/controller/wishlist_controller/wishlist_controller.dart';
import 'package:product_listing_app_test/utils/text_constants.dart';
import 'package:provider/provider.dart';
import 'package:product_listing_app_test/controller/product_list_controller/product_list_controller.dart';
import 'package:product_listing_app_test/controller/search_product_controller/serach_product_controller.dart';
import 'package:product_listing_app_test/controller/slider_controller/slider_controller.dart';
import 'package:product_listing_app_test/model/api_get_products/api_get_products.dart';
import 'package:product_listing_app_test/utils/color_constants.dart';
import 'package:product_listing_app_test/view/home_screen/widgets/carousel_screen.dart';
import 'package:product_listing_app_test/view/home_screen/widgets/custom_product_list.dart';
import 'package:product_listing_app_test/view/profile_screen/profile_screen.dart';
import 'package:product_listing_app_test/view/wish_list_screen/wish_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductListController productController = ProductListController();
  final SliderController sliderController = SliderController();
  final SearchProductController searchController = SearchProductController();

  late Future<List<ApiGetProducts>> _futureProducts;
  late Future<List<String>> _futureImageUrls;

  final TextEditingController _searchTextController = TextEditingController();

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _futureProducts = productController.getProducts();
    _futureImageUrls = sliderController.fetchImageUrls();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _futureProducts = productController.getProducts();
      } else {
        _futureProducts = searchController.searchProduct(query);
      }
    });
  }

  void _resetSearch() {
    setState(() {
      _searchQuery = '';
      _searchTextController.clear();
      _futureProducts = productController.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider =
        Provider.of<WishlistListController>(context, listen: false);

    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                color: ColorConstants.customBlue,
                child: TabBar(
                  indicatorColor: ColorConstants.customBluee,
                  labelColor: ColorConstants.customWhite,
                  unselectedLabelColor: ColorConstants.customWhite1,
                  tabs: const [
                    Tab(
                      icon: Image(
                        image: AssetImage("assets/images/home (1).png"),
                        height: 25,
                      ),
                      text: "Home",
                    ),
                    Tab(
                      icon: Image(
                        image: AssetImage("assets/images/order.png"),
                        height: 30,
                      ),
                      text: "Products",
                    ),
                    Tab(
                      icon: Image(
                        image: AssetImage("assets/images/profile (2).png"),
                        height: 25,
                      ),
                      text: "Profile",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: TextField(
                                    controller: _searchTextController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.search),
                                      hintText: "Search...",
                                      hintStyle: MytextStyle.hintStyle,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: _performSearch,
                                  ),
                                ),
                              ),
                              if (_searchQuery.isNotEmpty)
                                IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: _resetSearch,
                                ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  List<ApiGetProducts> allProducts =
                                      await _futureProducts;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WishlistScreen(
                                          allProducts: allProducts),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  "assets/images/add-to-favorites.png",
                                  height: 30,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          FutureBuilder<List<String>>(
                            future: _futureImageUrls,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  height: 200,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No banner images found.'));
                              } else {
                                return CarouselWidgets(
                                    imageUrls: snapshot.data!);
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          FutureBuilder<List<ApiGetProducts>>(
                            future: _futureProducts,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: ColorConstants.customBluee,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No products found.'));
                              } else {
                                final products = snapshot.data!;

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  wishlistProvider.setAllProducts(products);
                                });

                                return CustomProductList(products: products);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<List<ApiGetProducts>>(
                      future: _futureProducts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.customBluee,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No products found.'));
                        } else {
                          final products = snapshot.data!;
                          return SingleChildScrollView(
                            child: CustomProductList(products: products),
                          );
                        }
                      },
                    ),
                    const ProfileScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
