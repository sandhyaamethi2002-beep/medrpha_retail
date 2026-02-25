import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';
import '../Provider/wishlist_provider.dart';
import '../Product_Categories/product_detail_page.dart';
import '../ViewModel/AddtoCart/addtocart_view_model.dart';

class CategoryDetailCard extends StatelessWidget {
  final String imageUrl;
  final String productsname;
  final String status;
  final String available;
  final double price;
  final int minQuantity;
  final int productId;
  final int priceId;

  const CategoryDetailCard({
    super.key,
    required this.imageUrl,
    required this.productsname,
    required this.status,
    required this.available,
    required this.price,
    required this.minQuantity,
    required this.productId,
    required this.priceId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, WishlistProvider>(
      builder: (context, cartProvider, wishlistProvider, child) {
        final cartItemIndex =
        cartProvider.cartList.indexWhere((item) => item.productName == productsname);
        final bool isInCart = cartItemIndex != -1;
        final int qty = isInCart ? cartProvider.cartList[cartItemIndex].qty : 0;

        final bool isSaved = wishlistProvider.isSaved(productsname);

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(
                  productName: productsname,
                  productImg: imageUrl,
                  companyName: available,
                  description: status,
                  mrp: price + 100,
                  price: price,
                  discount: 10,
                  availableQuantity: available,
                  minQuantity: minQuantity,
                  productId: productId,
                  priceId: priceId,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.18),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: 72,
                    width: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 72,
                      width: 72,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              productsname,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              wishlistProvider.toggleWishlist(
                                WishlistItem(
                                  productName: productsname,
                                  imageUrl: imageUrl,
                                  available: available,
                                  status: status,
                                  price: price,
                                  minQuantity: minQuantity,
                                ),
                              );
                            },
                            child: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border,
                              size: 22,
                              color: isSaved ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),
                      Text(status, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      Text(
                        "Min Quantity: $minQuantity",
                        style: const TextStyle(
                            fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 14),

                      // Price + Add / Qty
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "By ",
                                    style: TextStyle(fontSize: 13, color: Colors.grey),
                                  ),
                                  TextSpan(
                                    text: available,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Add / Qty buttons
                          isInCart
                              ? Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, color: Colors.blue),
                                  onPressed: () {
                                    cartProvider.decreaseQty(productsname, minQuantity);
                                  },
                                ),
                                Text('$qty',
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.add, color: Colors.blue),
                                  onPressed: () {
                                    cartProvider.increaseQty(productsname);
                                  },
                                ),
                              ],
                            ),
                          )
                              : Container(
                            height: 40,
                            width: 95,
                            decoration: BoxDecoration(
                              color: minQuantity > 0 ? Colors.blue : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton.icon(
                              onPressed: minQuantity > 0
                                  ? () async {
                                final addToCartVM = context.read<AddToCartViewModel>();
                                await addToCartVM.addToCart(
                                  productId: productId,
                                  firmId: 1,
                                  userId: 1,
                                  qty: minQuantity,
                                  unitPrice: price,
                                  wpid: 1,
                                  priceId: priceId,
                                );

                                cartProvider.addToCart(
                                  productsname,
                                  imageUrl,
                                  available,
                                  price,
                                  minQuantity,
                                );
                              }
                                  : null,
                              icon: const Icon(Icons.add, color: Colors.white, size: 18),
                              label: const Text(
                                "Add",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}