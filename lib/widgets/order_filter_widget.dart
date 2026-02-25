import 'package:flutter/material.dart';

class OrderFilterWidget extends StatelessWidget {
  final String? selectedFilter;
  final bool showOptions;
  final VoidCallback onToggle;
  final Function(String) onSelect;

  const OrderFilterWidget({
    super.key,
    required this.selectedFilter,
    required this.showOptions,
    required this.onToggle,
    required this.onSelect,
  });

  TextStyle commonTextStyle() {
    return TextStyle(
      fontSize: 16,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        /// FILTER BUTTON
        GestureDetector(
          onTap: onToggle,
          child: Container(
            width: 120,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.filter_list, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    selectedFilter ?? "Filter",
                    style: commonTextStyle(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_drop_down, size: 18, color: Colors.grey.shade600),
              ],
            ),
          ),
        ),

        if (showOptions)
          Container(
            width: 120,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _filterItem("Live"),
                _filterItem("Dispatched"),
                _filterItem("Delivered"),
                _filterItem("Return/\nExchange"),
              ],
            ),
          ),
      ],
    );
  }

  Widget _filterItem(String status) {
    return InkWell(
      onTap: () => onSelect(status),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          status,
          style: commonTextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}