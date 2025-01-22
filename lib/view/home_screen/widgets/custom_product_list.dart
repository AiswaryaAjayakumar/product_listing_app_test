import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:product_listing_app_test/controller/wishlist_controller/wishlist_controller.dart';
import 'package:product_listing_app_test/utils/text_constants.dart';
import 'package:provider/provider.dart';
import 'package:product_listing_app_test/model/api_get_products/api_get_products.dart';
import 'package:product_listing_app_test/utils/color_constants.dart';

class CustomProductList extends StatelessWidget {
  final List<ApiGetProducts> products;

  const CustomProductList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistListController>(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 230,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final isFavorite =
            product.id != null && wishlistProvider.isFavorite(product.id!);

        return InkWell(
          onTap: () {
            debugPrint("Tapped on Product with ID: ${product.id}");
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstants.customBorderRadiusShadow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: product.featuredImage ??
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyjidfyUc5wxz5Wcy_gFcDHLiiALXblri48A&s', // Placeholder image URL
                            fit: BoxFit.cover,
                            width: double.infinity,
                            placeholder: (context, url) => Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: ColorConstants.customBluee,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: LikeButton(
                            isLiked: isFavorite,
                            size: 30,
                            circleColor: CircleColor(
                              start: ColorConstants.customBluee,
                              end: ColorConstants.customBluee,
                            ),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: ColorConstants.customBluee,
                              dotSecondaryColor: ColorConstants.customBluee,
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked
                                    ? ColorConstants.customBluee
                                    : ColorConstants.customBluee,
                                size: 30,
                              );
                            },
                            onTap: (bool isLiked) async {
                              if (product.id != null) {
                                wishlistProvider.toggleFavoriteStatus(product);
                              }

                              return !isLiked;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name ?? 'No Name',
                    style: MytextStyle.buttonStyle1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('₹${product.salePrice?.toStringAsFixed(2) ?? '0.00'}',
                      style: MytextStyle.normalText),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      for (int star = 1; star <= 5; star++)
                        Icon(
                          star <= (product.avgRating?.round() ?? 0)
                              ? Icons.star
                              : Icons.star_border,
                          color: ColorConstants.customOrange,
                          size: 16,
                        ),
                      const SizedBox(width: 4),
                      Text('${product.avgRating?.toStringAsFixed(1) ?? '0.0'}',
                          style: MytextStyle.hintStyle1),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
