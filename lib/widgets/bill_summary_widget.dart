import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/cart_provider.dart';
import '../../ViewModel/AddtoCart/getcardtotal_view_model.dart';
import '../Screen/place_order_page.dart';

class BillSummaryWidget extends StatelessWidget {
  const BillSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartTotalProvider = Provider.of<GetCartTotalViewModel>(context);

    return Container(
      padding: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decorative Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // Header
          Row(
            children: const [
              Icon(CupertinoIcons.doc_plaintext, size: 18, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                "Bill Summary",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 15),

          cartTotalProvider.isLoading
              ? const Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          )
              : Column(
            children: [
              // Bill Details
              _buildDataRow("Item Total", cartTotalProvider.totalPrice),
              _buildDataRow("Total Quantity", cartTotalProvider.totalQty.toDouble(), isUnit: false),
              _buildDataRow("Total Items", cartTotalProvider.totalItems.toDouble(), isUnit: false),
              _buildDataRow("Delivery Fee", cartProvider.deliveryFee, isFree: cartProvider.deliveryFee == 0),
              _buildDataRow("Handling Fee", cartProvider.handlingFee),
              _buildDataRow("GST (5%)", cartProvider.gst),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: Color(0xFFF5F5F5), thickness: 1.5),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Pay", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(
                        "₹${cartProvider.totalPay.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),

                  // Matched Checkout Button (Same as Confirm Button)
                  SizedBox(
                    width: 160, // Width fixed to 160
                    height: 48, // Height fixed to 48
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shadowColor: Colors.blue.withOpacity(0.3),
                        padding: EdgeInsets.zero, // Padding reset for exact sizing
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PlaceOrderPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "CHECKOUT",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_ios, size: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String title, double value, {bool isFree = false, bool isUnit = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Text(
            isFree ? "FREE" : isUnit ? "₹${value.toStringAsFixed(2)}" : value.toInt().toString(),
            style: TextStyle(
              color: isFree ? Colors.green : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}