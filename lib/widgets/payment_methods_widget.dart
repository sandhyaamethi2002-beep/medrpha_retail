import 'package:flutter/material.dart';

class PaymentMethodsWidget extends StatelessWidget {
  final int selectedPayment;
  final int selectedUPI;
  final Function(int) onPaymentSelected;
  final Function(int) onUPISelected;

  const PaymentMethodsWidget({
    super.key,
    required this.selectedPayment,
    required this.selectedUPI,
    required this.onPaymentSelected,
    required this.onUPISelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paymentOption(
            1,
            "Cash on Delivery",
            Icons.payments_outlined,
            "Pay when you receive"
        ),
        _paymentOption(
            2,
            "Online UPI / Wallet",
            Icons.account_balance_wallet_outlined,
            "Secure & Instant"
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: selectedPayment == 2
              ? _buildUPIOptions()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildUPIOptions() {
    return Container(
      key: const ValueKey(2),
      margin: const EdgeInsets.only(top: 8, bottom: 15),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.blue.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _upiAppCard(1, "G-Pay", "assets/UPI/gpay.jpeg"),
          _upiAppCard(2, "PhonePe", "assets/UPI/phonepe.png"),
          _upiAppCard(3, "Paytm", "assets/UPI/paytm.png"),
        ],
      ),
    );
  }

  Widget _upiAppCard(int value, String title, String assetPath) {
    bool isSelected = selectedUPI == value;
    return GestureDetector(
      onTap: () => onUPISelected(value),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 68,
            width: 68,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.1),
                  width: isSelected ? 2.5 : 1.5
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.payment, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.blue : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // --- Main Payment Option Tile ---
  Widget _paymentOption(int value, String title, IconData icon, String sub) {
    bool isSelected = selectedPayment == value;
    return GestureDetector(
      onTap: () => onPaymentSelected(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade200,
              width: isSelected ? 2 : 1.2
          ),
          color: isSelected ? Colors.blue.withOpacity(0.02) : Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.blue : Colors.grey,
                size: 22,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                  ),
                  Text(
                      sub,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: isSelected ? Colors.blue : Colors.grey.shade300,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}