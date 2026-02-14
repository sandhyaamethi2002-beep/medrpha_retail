import 'package:flutter/material.dart';
import 'package:medrpha/Provider/order_provider.dart';
import 'package:medrpha/Screen/order_detail_page.dart';
import 'package:provider/provider.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<MyOrderPage> {
  String? selectedFilter; // null = show all
  bool showFilterOptions = false;

  /// ✅ Common Text Style (Search + Filter + Dropdown same)
  TextStyle commonTextStyle() {
    return TextStyle(
      fontSize: 16,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "My Order",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {

          List filteredList = selectedFilter == null
              ? provider.orderList
              : provider.orderList
              .where((item) => item.status == selectedFilter)
              .toList();

          return Column(
            children: [

              /// 🔎 SEARCH + FILTER
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// SEARCH BOX
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          style: commonTextStyle(),
                          decoration: InputDecoration(
                            hintText: "Search your order here",
                            hintStyle: commonTextStyle(),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade600,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    /// FILTER SECTION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        /// FILTER BUTTON
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showFilterOptions = !showFilterOptions;
                            });
                          },
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
                                Icon(
                                  Icons.filter_list,
                                  size: 18,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  selectedFilter ?? "Filter",
                                  style: commonTextStyle(),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 18,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 🔽 DROPDOWN OPTIONS
                        if (showFilterOptions)
                          Container(
                            width: 120,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                filterItem("Live"),
                                filterItem("Dispatched"),
                                filterItem("Delivered"),
                                filterItem("Return/\nExchange"),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              /// 📦 ORDER LIST
              Expanded(
                child: filteredList.isEmpty
                    ? const Center(child: Text("No Orders Found"))
                    : ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {

                    final item = filteredList[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const OrderDetails(),
                            ),
                          );
                        },
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.shopping_bag),
                        ),
                        title: Text(item.productName),
                        subtitle: Text(
                          "Qty: ${item.qty} | ${item.status}",
                          style: commonTextStyle(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 🔹 FILTER ITEM
  Widget filterItem(String status) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedFilter = status;
          showFilterOptions = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          status,
          style: commonTextStyle(),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
