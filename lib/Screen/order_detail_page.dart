import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../ViewModel/OrderVM/GetOrderDetails_vm.dart';
import '../ViewModel/OrderVM/GetOrderInvoice_vm.dart';
import '../widgets/invoice_details_widget.dart';
import '../widgets/order_detail_card.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;
  const OrderDetailsPage({super.key, this.orderId = "7725"});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "N/A";
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('MMMM-yyyy').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<GetOrderDetailsVM>(context, listen: false)
          .fetchOrderDetails(int.parse(widget.orderId));
      Provider.of<GetOrderInvoiceVM>(context, listen: false)
          .fetchOrderInvoice(int.parse(widget.orderId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Order #${widget.orderId}",
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<GetOrderDetailsVM>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final filteredItems = vm.orders.where((item) {
            final productName = (item.productName ?? "").toLowerCase();
            final companyName = (item.compnayName ?? "").toLowerCase();
            final query = _searchQuery.toLowerCase();

            return productName.contains(query) || companyName.contains(query);
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(),

                const SizedBox(height: 20),
                _sectionTitle("Order Products"),

                if (filteredItems.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text("No products found matching your search"),
                    ),
                  )
                else
                  ListView.builder(
                    itemCount: filteredItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];

                      return OrderDetailCard(
                        name: item.productName ?? "",
                        subtitle: "${item.compnayName ?? 'N/A'} | ${item.categoryName ?? ''}",
                        qty: "${item.orderedQty} ${item.unitType ?? ''}",
                        batch: item.batchNumber ?? "",
                        expiry: _formatDate(item.dtExpiryDate),
                        mrp: item.unitMrp.toString(),
                        price: item.companyPrice.toString(),
                        total: item.totalPrice.toString(),
                      );
                    },
                  ),

                const SizedBox(height: 20),

                Consumer<GetOrderInvoiceVM>(
                  builder: (context, invoiceVM, child) {
                    if (invoiceVM.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (invoiceVM.invoiceList.isEmpty) {
                      return const Text("No Invoice Data");
                    }

                    final invoice = invoiceVM.invoiceList.first;
                    return InvoiceDetailsWidget(
                      transactionId: invoice.transactionId ?? "",
                      productName: invoice.productName ?? "",
                      companyName: invoice.compnayName ?? "",
                      category: invoice.compnayName ?? "",
                      paymentMode: invoice.paymentStatusMode ?? "",
                      paymentStatus: invoice.paymentStatusText ?? "",
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // Search Bar UI design
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: "Search product or company...",
          hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.blue),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
              icon: const Icon(Icons.clear, size: 20),
              onPressed: () {
                _searchController.clear();
                setState(() { _searchQuery = ""; });
              })
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}