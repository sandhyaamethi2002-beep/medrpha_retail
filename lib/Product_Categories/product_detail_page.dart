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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "PRODUCT DETAIL",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Product Image Section ---
                  Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey.shade50,
                    child: Hero(
                      tag: productId.toString(),
                      child: productImg.isNotEmpty
                          ? Image.network(
                        productImg,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => _imageErrorWidget(),
                      )
                          : _imageErrorWidget(),
                    ),
                  ),

                  const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 2),

                        // Company Name
                        Text(
                          companyName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Price Section
                        if (mrp > price)
                          Text(
                            "MRP: ₹ ${mrp.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),

                        const SizedBox(height: 2),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "₹ ${price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 15),

                            if (discount > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.green.shade200),
                                ),
                                child: Text(
                                  "${discount.toStringAsFixed(2)}% OFF",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // Description Section
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          description.isNotEmpty
                              ? description
                              : "No description available for this product.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Bottom Add to Cart Button Section ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final cartIndex = cartProvider.cartList
                    .indexWhere((item) => item.productName == productName);

                final bool isInCart = cartIndex != -1;
                final int qty = isInCart ? cartProvider.cartList[cartIndex].qty : 0;

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

  /// Image Error Placeholder
  Widget _imageErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported_outlined, size: 80, color: Colors.grey.shade300),
        ],
      ),
    );
  }

  /// Counter Widget (Step-wise logic enabled)
  Widget _quantityWidget(CartProvider cartProvider, int qty) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.blue, size: 28),
            onPressed: () => cartProvider.decreaseQty(productName),
          ),
          Text(
            "$qty",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blue, size: 28),
            onPressed: () => cartProvider.increaseQty(productName),
          ),
        ],
      ),
    );
  }

  /// Add Button
  Widget _addButton(CartProvider cartProvider) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          double initialTotalSale = price * (minQuantity > 0 ? minQuantity : 1);
          double initialTotalMrp = mrp * (minQuantity > 0 ? minQuantity : 1);

          cartProvider.addToCart(
            0,
            productName,
            productImg,
            availableQuantity,
            price,
            minQuantity,
            companyName: companyName,
            priceId: priceId,
            maxQuantity: int.tryParse(availableQuantity) ?? 999,
            tSalePrice: initialTotalSale,
            tmrp: initialTotalMrp,
          );
        },
        child: const Text(
          "Add to Cart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}