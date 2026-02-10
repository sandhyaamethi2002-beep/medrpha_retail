import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Order Details",
          style: GoogleFonts.poppins(
              color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ORDER CARD
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Order ORD-2026-0016",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.assignment_outlined,
                            color: Colors.blue)
                      ],
                    ),

                    const Divider(height: 25),

                    _infoRow("Status:", "Ordered", Colors.green),
                    _infoRow("Order Date:", "Feb 06, 2026", Colors.black),
                    _infoRow("Total Amount:", "₹550.00", Colors.blue),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ITEMS
            const Text(
              "Items (3)",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _itemTile("8", "85027", "2 x ₹350.00", "₹700.00"),
            _itemTile("F", "Full Body Test", "1 x ₹200.00", "₹200.00"),
            _itemTile("H", "HB001", "1 x ₹350.00", "₹350.00"),

            const SizedBox(height: 20),

            /// PRICING
            const Text(
              "Pricing",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _priceRow("Subtotal (Approx)", "₹550.00"),
            _priceRow("Discount", "₹0.00", color: Colors.red),

            const Divider(height: 25),

            _priceRow("Total Paid", "₹550.00",
                isBold: true, color: Colors.blue),

          ],
        ),
      ),
    );
  }

  /// INFO ROW
  static Widget _infoRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.grey, fontSize: 15)),
          Text(value,
              style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  /// ITEM TILE
  static Widget _itemTile(
      String letter, String title, String subtitle, String price) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(letter)),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Text(price,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15)),
    );
  }

  /// PRICE ROW
  static Widget _priceRow(String title, String value,
      {bool isBold = false, Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                  isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                  isBold ? FontWeight.bold : FontWeight.normal,
                  color: color)),
        ],
      ),
    );
  }
}
