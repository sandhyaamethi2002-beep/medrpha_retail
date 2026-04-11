import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha/Screen/my_order_page.dart';
import 'package:provider/provider.dart';
import '../../Controllers/user_controller.dart';
import '../../Provider/cart_provider.dart';
import '../../ViewModel/AddtoCart/placeorder_view_model.dart';
import '../Screen/home_page.dart';
import '../Screen/place_order_page.dart';

class BillSummaryWidget extends StatelessWidget {
  final bool isPlaceOrderPage;

  const BillSummaryWidget({
    super.key,
    this.isPlaceOrderPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderVM = Provider.of<PlaceOrderViewModel>(context);

    double totalMRP = 0;
    double totalSalePrice = 0;

    for (var item in cartProvider.cartList) {
      totalMRP += item.tmrp;
      totalSalePrice += item.price;
    }

    double totalDiscount = totalMRP - totalSalePrice;
    const double minimumOrderAmount = 1500.00;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              _buildRow("MRP Total :", "Rs. ${totalMRP.toStringAsFixed(2)}"),
              _buildRow("Price Discount :", "Rs. ${totalDiscount.toStringAsFixed(2)}", isDiscount: true),
              _buildRow("Shipping Charges :", "As per delivery address"),
              if (!isPlaceOrderPage)
                _buildRow("Minimum Order Amount :", "Rs. ${minimumOrderAmount.toStringAsFixed(2)}", isWarning: true),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: Colors.grey, thickness: 0.5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Amount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  Text(
                    "Rs. ${totalSalePrice.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1976D2)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (!isPlaceOrderPage) ...[
                _buildButton(
                  text: "CONTINUE SHOPPING",
                  isOutlined: true,
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 12),
                _buildButton(
                  text: "CHECK OUT",
                  onPressed: totalSalePrice < minimumOrderAmount
                      ? null
                      : () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PlaceOrderPage()));
                  },
                ),
              ] else ...[
                _buildButton(
                  text: orderVM.isLoading ? "PLACING..." : "PLACE ORDER",
                  onPressed: orderVM.isLoading
                      ? null
                      : () async {
                    final userController = Get.find<UserController>();

                    int finalUserId = int.tryParse(userController.firmId.value.toString()) ?? 0;

                    int finalRoleId = 1;

                    bool success = await orderVM.placeOrder(
                      userId: finalUserId,
                      userTypeId: int.tryParse(userController.userTypeId.value.toString()) ?? 0,
                      roleId: finalRoleId,
                      orderAmount: totalSalePrice,
                      address: "Sample Address",
                      phone: userController.mobileNo.value,
                      name: userController.firmName.value,
                    );

                    if (success) {
                      cartProvider.clearCart();

                      Get.snackbar(
                        "Success",
                        "Your order has been placed successfully!",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 2),
                      );

                      Future.delayed(const Duration(seconds: 1), () {
                        Get.offAll(() => const MyOrderPage(
                        ));
                      });
                    } else {
                      Get.snackbar(
                        "Order Failed",
                        "Something went wrong. Please try again later.",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback? onPressed, bool isOutlined = false}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: isOutlined
          ? OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.grey, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      )
          : ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isWarning = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: isWarning ? Colors.red : Colors.grey[700])),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isWarning ? Colors.red : (isDiscount ? Colors.green : Colors.black))),
        ],
      ),
    );
  }
}