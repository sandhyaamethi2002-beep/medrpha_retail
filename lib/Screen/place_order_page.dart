import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/cart_provider.dart';
import '../../ViewModel/AddtoCart/getcardtotal_view_model.dart';
import '../Model/AddtoCart/placeorder_model.dart';
import '../ViewModel/AddtoCart/placeorder_view_model.dart';
import '../widgets/payment_methods_widget.dart';
import 'add_new_address.dart';

class PlaceOrderPage extends StatefulWidget {
  const PlaceOrderPage({super.key});

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  int _selectedPayment = 1;
  int _selectedUPI = 0;

  String currentName = "XYZ";
  String currentAddress = "H.No 45, Near City Mall, Gomti Nagar, Lucknow - 226010";

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartTotalProvider = Provider.of<GetCartTotalViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text("Confirm Order", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _sectionHeader("Delivery Address"),
              const SizedBox(height: 12),
              _buildAddressCard(),

              const SizedBox(height: 25),

              _sectionHeader("Payment Method"),
              const SizedBox(height: 12),
              PaymentMethodsWidget(
                selectedPayment: _selectedPayment,
                selectedUPI: _selectedUPI,
                onPaymentSelected: (val) {
                  setState(() {
                    _selectedPayment = val;
                    if (val == 1) _selectedUPI = 0;
                  });
                },
                onUPISelected: (val) {
                  setState(() => _selectedUPI = val);
                },
              ),

              const SizedBox(height: 25),
              _sectionHeader("Bill Summary"),
              const SizedBox(height: 12),
              _buildBillSummaryCard(cartProvider, cartTotalProvider),
              const SizedBox(height: 130),
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomButton(cartProvider.totalPay),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(backgroundColor: Colors.blue, radius: 18, child: Icon(Icons.location_on, color: Colors.white, size: 18)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currentName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(currentAddress, style: const TextStyle(color: Colors.black54, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
          TextButton(
            onPressed: () => showAddAddressBottomSheet(context),
            child: const Text("Edit", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildBillSummaryCard(CartProvider cart, GetCartTotalViewModel cartTotal) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey[200]!)),
      child: Column(
        children: [
          _billRow("Item Total", cartTotal.totalPrice),
          _billRow("Delivery Fee", cart.deliveryFee, isFree: cart.deliveryFee == 0),
          _billRow("Handling Fee", cart.handlingFee),
          _billRow("GST (5%)", cart.gst),
          const Divider(height: 24, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("To Pay", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("₹${cart.totalPay.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _billRow(String title, double value, {bool isFree = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.black54, fontSize: 14)),
          Text(isFree ? "FREE" : "₹${value.toStringAsFixed(2)}", style: TextStyle(color: isFree ? Colors.green : Colors.black87, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildBottomButton(double totalPay) {
    return Consumer<PlaceOrderViewModel>(
      builder: (context, orderVM, child) {
        return Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, -4))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total Amount",
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                  Text("₹${totalPay.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                ],
              ),
              SizedBox(
                width: 160,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: orderVM.isLoading
                      ? null
                      : () async {
                    final request = PlaceOrderRequestModel(
                      userId: 1,
                      userTypeId: 1,
                      roleId: 1,
                      orderAmount: totalPay,
                      payModeId: _selectedPayment,
                      transactionId: "1234",
                      paymentStatus: 23,
                      address: currentAddress,
                      country: "India",
                      state: "uttar pradesh",
                      city: "lucknow",
                      phone: "9793944622",
                      email: "abc@gmail.com",
                      name: currentName,
                    );

                    await orderVM.placeOrder(request);

                    if (orderVM.responseModel != null &&
                        orderVM.responseModel!.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              orderVM.responseModel!.message),
                          backgroundColor: Colors.green,
                        ),
                      );

                      print(" Order ID: ${orderVM.responseModel!.orderId}");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Order Failed"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: orderVM.isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                      : const Text(
                    "CONFIRM",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionHeader(String title) {
    return Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87));
  }
}