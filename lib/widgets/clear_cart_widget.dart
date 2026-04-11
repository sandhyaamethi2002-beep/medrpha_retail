import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';

class ClearCartWidget extends StatelessWidget {
  const ClearCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_sweep_outlined, color: Colors.white, size: 28),
      tooltip: "Clear Cart",
      onPressed: () {
        _showClearCartDialog(context);
      },
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Clear Cart?"),
          content: const Text("Are you want to clear cart?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).clearCart();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Cart cleared successfully!"),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              child: const Text("Yes", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}