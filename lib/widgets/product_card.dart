import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:provider/provider.dart';
import '../Controllers/user_controller.dart';
import '../Provider/cart_provider.dart';
import '../Provider/wishlist_provider.dart';
import '../Product_Categories/product_detail_page.dart';
import '../ViewModel/AddtoCart/addtocart_view_model.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productsname;
  final String status;
  final String available;
  final double price;
  final double mrp;
  final int minQuantity;
  final int availableQty;
  final int productId;
  final int priceId;
  final double discountPercentage;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productsname,
    required this.status,
    required this.available,
    required this.price,
    required this.mrp,
    required this.minQuantity,
    required this.availableQty,
    required this.productId,
    required this.priceId,
    required this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {

    final UserController userController = Get.find<UserController>();

    return Consumer2<CartProvider, WishlistProvider>(
      builder: (context, cartProvider, wishlistProvider, child) {
        final cartItemIndex = cartProvider.cartList.indexWhere((item) => item.productName == productsname);
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
                  mrp: mrp,
                  price: price,
                  discount: discountPercentage,
                  availableQuantity: availableQty.toString(),
                  minQuantity: minQuantity,
                  productId: productId,
                  priceId: priceId,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 14, left: 10, right: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Product Image ---
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: 85,
                    width: 85,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 85,
                      width: 85,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // --- Details ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              productsname,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          InkWell(
                            onTap: () => wishlistProvider.toggleWishlist(
                              WishlistItem(
                                productName: productsname,
                                imageUrl: imageUrl,
                                available: available,
                                status: status,
                                price: price,
                                minQuantity: minQuantity,
                              ),
                            ),
                            child: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border,
                              size: 22,
                              color: isSaved ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text("By $available", style: const TextStyle(fontSize: 13, color: Colors.grey)),

                      const SizedBox(height: 6),

                      // --- Badges ---
                      Row(
                        children: [
                          _buildBadge("Min: $minQuantity", Colors.orange.shade100, Colors.orange.shade900),
                          const SizedBox(width: 8),
                          _buildBadge("Available: $availableQty", Colors.green.shade50, Colors.green.shade900),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹${price.toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),

                          // --- Action Button / Counter ---
                          SizedBox(
                            width: 100,
                            height: 38,
                            child: isInCart && qty > 0
                                ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => cartProvider.decreaseQty(productsname),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Icon(Icons.remove, color: Colors.blue, size: 18),
                                    ),
                                  ),
                                  Text('$qty',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                                  ),
                                  InkWell(
                                    onTap: () => cartProvider.increaseQty(productsname),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Icon(Icons.add, color: Colors.blue, size: 18),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : ElevatedButton(
                              onPressed: () async {

                                int initialQty = minQuantity > 0 ? minQuantity : 1;
                                double initialTotalSale = price * initialQty;
                                double initialTotalMrp = mrp * initialQty;

                                final addToCartVM = context.read<AddToCartViewModel>();

                                await addToCartVM.addToCart(
                                    productId: productId,
                                    firmId: userController.firmId.value,
                                    userId: userController.userId.value,
                                    qty: initialQty,
                                    unitPrice: price,
                                    wpid: 1,
                                    priceId: priceId);

                                cartProvider.addToCart(
                                  0,
                                  productsname,
                                  imageUrl,
                                  available,
                                  price,
                                  minQuantity,
                                  maxQuantity: availableQty,
                                  priceId: priceId,
                                  tSalePrice: initialTotalSale,
                                  tmrp: initialTotalMrp,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 18),
                                  SizedBox(width: 4),
                                  Text("Add", style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
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

  // Badge Widget
  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}