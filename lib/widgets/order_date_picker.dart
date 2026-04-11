import 'package:flutter/material.dart';

class OrderDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const OrderDatePicker({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? label
                  : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            ),
            const Icon(Icons.calendar_month_outlined, color: Colors.blue, size: 20),
          ],
        ),
      ),
    );
  }
}