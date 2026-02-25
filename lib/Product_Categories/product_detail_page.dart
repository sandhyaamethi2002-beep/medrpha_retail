import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final String productName;
  final String productImg;
  final String companyName;
  final String description;
  final double mrp;
  final double price;
  final double discount;
  final String availableQuantity;
  final int minQuantity;
  final int productId;
  final int priceId;

  const ProductDetailPage({
    super.key,
    required this.productName,
    required this.productImg,
    required this.companyName,
    required this.description,
    required this.mrp,
    required this.price,
    required this.discount,
    required this.availableQuantity,
    required this.minQuantity,
    required this.productId,
    required this.priceId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Product Detail",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Product Image
                productImg.isNotEmpty
                    ? Image.network(
                  productImg,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _imageErrorWidget(),
                )
                    : _imageErrorWidget(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        companyName,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 20),
                      if (mrp > 0)
                        Text(
                          "₹ ${mrp.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "₹ ${price.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (discount > 0)
                            Text(
                              "${discount.toStringAsFixed(0)}% OFF",
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description.isNotEmpty
                            ? description
                            : "No description available",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Add To Cart Section
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final cartIndex = cartProvider.cartList
                    .indexWhere((item) => item.productName == productName);

                final bool isInCart = cartIndex != -1;
                final int qty =
                isInCart ? cartProvider.cartList[cartIndex].qty : 0;

                return isInCart
                    ? _quantityWidget(cartProvider, qty)
                    : _addButton(cartProvider);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Image Error Widget
  Widget _imageErrorWidget() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.grey.shade200,
      child: const Icon(Icons.image_not_supported, size: 50),
    );
  }

  /// Quantity Widget
  Widget _quantityWidget(CartProvider cartProvider, int qty) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              if (qty > minQuantity) {
                cartProvider.decreaseQty(productName, minQuantity);
              } else {
                cartProvider.removeFromCartByName(productName);
              }
            },
          ),
          Text(
            "$qty",
            style:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              cartProvider.increaseQty(productName);
            },
          ),
        ],
      ),
    );
  }

  /// Add Button
  Widget _addButton(CartProvider cartProvider) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: minQuantity > 0 ? Colors.blue : Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: minQuantity > 0
            ? () {
          cartProvider.addToCart(
            productName,
            productImg,
            availableQuantity,
            price,
            minQuantity,
          );
        }
            : null,
        child: const Text(
          "Add to Cart",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}