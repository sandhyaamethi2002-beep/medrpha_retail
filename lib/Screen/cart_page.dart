import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Controllers/user_controller.dart';
import '../Provider/cart_provider.dart';
import '../ViewModel/AddtoCart/DeleteCartById_vm.dart';
import '../ViewModel/AddtoCart/GetCartDetailsByFirmId_view_model.dart';
import '../ViewModel/AddtoCart/getcardtotal_view_model.dart';
import '../widgets/bill_summary_widget.dart';
import '../widgets/clear_cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshCartAndTotals();
    });
  }

  Future<void> _refreshCartAndTotals() async {
    final UserController userController = Get.find<UserController>();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartDetailsVM = Provider.of<GetCartDetailsByFirmIdViewModel>(context, listen: false);
    final cartTotalVM = Provider.of<GetCartTotalViewModel>(context, listen: false);

    await cartDetailsVM.fetchCartByFirmId(userController.firmId.value);

    if (cartDetailsVM.cartItems.isNotEmpty) {
      cartProvider.clearCart();
      for (var item in cartDetailsVM.cartItems) {
        cartProvider.addToCart(
          item.cartId,
          item.productName,
          item.productImg,
          item.categoryName,
          item.salePrice,
          item.minQuantity,
          maxQuantity: item.maxQuantity,
          priceId: item.priceId,
          wpid: item.wpid,
          saleType: item.saleType,
          tSalePrice: item.tSalePrice,
          tmrp: item.tmrp,
        );
        int idx = cartProvider.cartList.indexWhere((c) => c.productName == item.productName);
        if (idx != -1) cartProvider.cartList[idx].qty = item.quantity;
      }
    }

    // Fetch Total API
    cartTotalVM.fetchCartTotal(
      firmId: userController.firmId.value,
      userTypeId: userController.userTypeId.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final cartTotalVM = Provider.of<GetCartTotalViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        title: const Text("My Cart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          const ClearCartWidget(),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer2<GetCartDetailsByFirmIdViewModel, CartProvider>(
        builder: (context, cartDetailsVM, cartProvider, child) {
          if (cartDetailsVM.isLoading && cartProvider.cartList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.cartList.isEmpty) {
            return const Center(child: Text("Cart is Empty", style: TextStyle(fontSize: 16)));
          }

          return Column(
            children: [
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
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.imageUrl,
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 75, width: 75, color: Colors.grey.shade200,
                                child: const Icon(Icons.image_not_supported),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.productName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text(item.saleType ?? "N/A", style: const TextStyle(fontSize: 14, color: Colors.grey)),
                                const SizedBox(height: 4),
                                Text("₹${item.price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                                Text("MRP: ₹${item.tmrp.toStringAsFixed(2)}", style: const TextStyle(color: Colors.red, fontSize: 12, decoration: TextDecoration.lineThrough)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete Item"),
                                        content: const Text("Are you want to delete this item?"),
                                        actions: [

                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: const Text("No", style: TextStyle(color: Colors.grey)),
                                          ),

                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();

                                              final deleteVM = Provider.of<DeleteCartByIdViewModel>(context, listen: false);

                                              bool success = await deleteVM.deleteCart(
                                                cartId: item.cartId,
                                                userTypeId: userController.userTypeId.value,
                                              );

                                              if (success) {
                                                cartProvider.removeFromCartByName(item.productName);

                                                cartTotalVM.fetchCartTotal(
                                                  firmId: userController.firmId.value,
                                                  userTypeId: userController.userTypeId.value,
                                                );

                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text("Item cart se delete ho gaya")),
                                                );
                                              }
                                            },
                                            child: const Text("Yes", style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 32,
                                decoration: BoxDecoration(border: Border.all(color: const Color(0xFF1976D2)), borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(Icons.remove, size: 16, color: Color(0xFF1976D2)),
                                      onPressed: () {
                                        cartProvider.decreaseQty(item.productName);
                                        cartTotalVM.fetchCartTotal(firmId: userController.firmId.value, userTypeId: userController.userTypeId.value);
                                      },
                                    ),
                                    Text(item.qty.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(Icons.add, size: 16, color: Color(0xFF1976D2)),
                                      onPressed: () {
                                        cartProvider.increaseQty(item.productName);

                                        cartTotalVM.fetchCartTotal(firmId: userController.firmId.value, userTypeId: userController.userTypeId.value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const BillSummaryWidget(),
            ],
          );
        },
      ),
    );
  }
}