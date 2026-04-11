import 'package:flutter/material.dart';

class OrderFilterWidget extends StatelessWidget {
  final String? selectedFilter;
  final Function(String) onSelect;

  const OrderFilterWidget({
    super.key,
    required this.selectedFilter,
    required this.onSelect,
  });

  TextStyle commonTextStyle({bool isBold = false, Color? color}) {
    return TextStyle(
      fontSize: 14,
      color: color ?? Colors.grey.shade600, // Matching filter box text color
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.grey.shade200,
        elevation: 2,
        padding: EdgeInsets.zero,

        onSelected: onSelect,

        child: Container(
          width: 110,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.filter_list, size: 18, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  selectedFilter ?? "Filter",
                  style: commonTextStyle(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              Icon(Icons.arrow_drop_down, size: 18, color: Colors.grey.shade600),
            ],
          ),
        ),

        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          _buildPopupItem("Live"),
          _buildPopupItem("Dispatched"),
          _buildPopupItem("Delivered"),
          _buildPopupItem("Return/Exchange"),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 40,
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          value,
          style: commonTextStyle(
            color: selectedFilter == value ? Colors.blue : Colors.grey.shade600,
            isBold: selectedFilter == value,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}