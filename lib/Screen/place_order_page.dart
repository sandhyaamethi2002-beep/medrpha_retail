import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/user_controller.dart';
import '../widgets/payment_methods_widget.dart';
import '../widgets/bill_summary_widget.dart';
import 'add_new_address.dart';

class PlaceOrderPage extends StatefulWidget {
  const PlaceOrderPage({super.key});

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  int _selectedPayment = 1;
  int _selectedUPI = 0;

  // Controller finding
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    // Ensure data is loaded from SharedPreferences immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        centerTitle: true,
        title: const Text("PLACE ORDER",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
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

              // Obx for reactive UI update
              Obx(() => _buildAddressCard()),

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

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const SafeArea(
        child: BillSummaryWidget(isPlaceOrderPage: true),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
              backgroundColor: Color(0xFF1976D2),
              radius: 18,
              child: Icon(Icons.location_on, color: Colors.white, size: 18)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userController.firmName.value.isEmpty
                      ? "Name Missing"
                      : userController.firmName.value,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  userController.address.value.isEmpty
                      ? "Address Missing"
                      : userController.address.value,
                  style: const TextStyle(color: Colors.black54, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 14, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      userController.mobileNo.value,
                      style: const TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => showAddAddressBottomSheet(context),
            child: const Text("Edit",
                style: TextStyle(color: Color(0xFF1976D2), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(title,
        style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black87));
  }
}