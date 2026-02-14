import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';
import '../Provider/order_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {

          if (cartProvider.cartList.isEmpty) {
            return const Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Column(
            children: [

              /// ================= CART LIST =================
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cartProvider.cartList.length,
                  itemBuilder: (context, index) {

                    final item = cartProvider.cartList[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [

                          /// PRODUCT IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.imageUrl,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Container(
                                  height: 70,
                                  width: 70,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.image_not_supported,
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 12),

                          /// NAME + PRICE
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName,
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "₹${item.price}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// QTY CONTROLLER
                          Container(
                            height: 36,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blue),
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize:
                              MainAxisSize.min,
                              children: [

                                /// DECREASE
                                IconButton(
                                  padding:
                                  EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    final orderProvider =
                                    Provider.of<OrderProvider>(context, listen: false);

                                    final cartProvider =
                                    Provider.of<CartProvider>(context, listen: false);

                                    orderProvider.placeOrder(cartProvider.cartList);

                                    cartProvider.clearCart();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Order Placed Successfully")),
                                    );
                                  },

                                ),

                                Text(
                                  item.qty.toString(),
                                  style:
                                  const TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                /// INCREASE
                                IconButton(
                                  padding:
                                  EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    cartProvider
                                        .increaseQty(
                                        item.productName);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// ================= BILLING SECTION =================
              _billingSection(cartProvider),
            ],
          );
        },
      ),
    );
  }

  /// ================= BILLING UI =================
  Widget _billingSection(CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Bill Summary Title with proper padding
            Row(
              children: const [
                Icon(
                  CupertinoIcons.doc_text,
                  size: 20,
                  color: Colors.blue,
                ),
                SizedBox(width: 8),
                Text(
                  "Bill Summary",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            const Divider(thickness: 1),
            const SizedBox(height: 12),

            _row("Item Total", cartProvider.itemTotal),
            _row("Delivery Fee", cartProvider.deliveryFee),
            _row("Handling Fee", cartProvider.handlingFee),
            _row("GST (5%)", cartProvider.gst),

            const Divider(height: 20),

            _row("To Pay", cartProvider.totalPay, isBold: true),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Proceed to Checkout",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  /// BILL ROW
  Widget _row(String title, double value,
      {bool isBold = false}) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight:
              isBold ? FontWeight.bold : null,
            ),
          ),
          Text(
            "₹${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight:
              isBold ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }
}
