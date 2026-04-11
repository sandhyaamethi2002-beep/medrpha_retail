import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceDetailsWidget extends StatelessWidget {
  final String transactionId;
  final String productName;
  final String companyName;
  final String category;
  final String paymentMode;
  final String paymentStatus;

  const InvoiceDetailsWidget({
    super.key,
    required this.transactionId,
    required this.productName,
    required this.companyName,
    required this.category,
    required this.paymentMode,
    required this.paymentStatus,
  });

  String _valueOrNA(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "N/A";
    }
    return value;
  }

  Color _statusBgColor() {
    String status = paymentStatus.toLowerCase();
    if (status == "pending") return Colors.orange.withOpacity(0.1);
    if (status == "paid" || status == "success") return Colors.green.withOpacity(0.1);
    return Colors.grey.withOpacity(0.1);
  }

  Color _statusTextColor() {
    String status = paymentStatus.toLowerCase();
    if (status == "pending") return Colors.orange.shade800;
    if (status == "paid" || status == "success") return Colors.green.shade800;
    return Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Title with a small indicator
        Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 4),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Invoice Details",
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        /// Main Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.blue.withOpacity(0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction ID",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "#${_valueOrNA(transactionId)}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _rowItem(Icons.inventory_2_outlined, "Product", _valueOrNA(productName), isBold: true),
                      _rowItem(Icons.business_outlined, "Company", _valueOrNA(companyName)),
                      _rowItem(Icons.category_outlined, "Category", _valueOrNA(category)),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
                      ),

                      _rowItem(Icons.payments_outlined, "Payment Mode", _valueOrNA(paymentMode)),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, size: 18, color: Colors.grey.shade500),
                            const SizedBox(width: 10),
                            Text(
                              "Status",
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: _statusBgColor(),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                paymentStatus.toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _statusTextColor(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Improved Row Widget with Icons
  Widget _rowItem(IconData icon, String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade500),
          const SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}