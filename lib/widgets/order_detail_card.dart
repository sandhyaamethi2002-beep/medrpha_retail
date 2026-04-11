import 'package:flutter/material.dart';

class OrderDetailCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String qty;
  final String batch;
  final String expiry;
  final String mrp;
  final String price;
  final String total;

  const OrderDetailCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.qty,
    required this.batch,
    required this.expiry,
    required this.mrp,
    required this.price,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text(
                    //   "₹$mrp",
                    //   style: const TextStyle(
                    //     decoration: TextDecoration.lineThrough,
                    //     color: Colors.grey,
                    //     fontSize: 12,
                    //   ),
                    // ),
                    Text(
                      "₹$price",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Text("Qty: $qty"),
            Text(
              "Batch: $batch",
              style: const TextStyle(color: Colors.blueGrey, fontSize: 13),
            ),
            Text(
              "Expiry: $expiry",
              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
            ),
            const Divider(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: ₹$total",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}