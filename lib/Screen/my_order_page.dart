import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Controllers/user_controller.dart';
import '../ViewModel/AccountVM/getfirmbyid_view_model.dart';
import '../ViewModel/OrderVM/GetOrdersByFirm_vm.dart';
import '../widgets/order_card.dart';
import '../widgets/order_filter_widget.dart';
import '../widgets/firm_card.dart';
import '../widgets/order_date_picker.dart';
import 'order_detail_page.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<MyOrderPage> {
  String? selectedFilter;
  bool showFilterOptions = false;
  TextEditingController searchController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;

  String formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  void fetchOrders() {
    final userController = Get.find<UserController>();
    int firmId = userController.firmId.value;
    final orderVM = Provider.of<GetOrdersByFirmViewModel>(context, listen: false);
    int? searchId = int.tryParse(searchController.text.trim());

    orderVM.fetchOrders(
      firmId: firmId,
      orderId: searchId,
      fromDate: formatDate(fromDate),
      toDate: formatDate(toDate),
    );
  }

  @override
  void initState() {
    super.initState();
    final userController = Get.find<UserController>();
    int currentFirmId = userController.firmId.value;
    if (currentFirmId != 0) {
      Future.microtask(() {
        Provider.of<GetFirmByIdViewModel>(context, listen: false).fetchFirm(currentFirmId);
        fetchOrders();
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) fromDate = picked; else toDate = picked;
      });
      fetchOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GetFirmByIdViewModel>(context);
    final orderVM = Provider.of<GetOrdersByFirmViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("My Orders", style: TextStyle(color: Colors.white)),
      ),
      body: GestureDetector(
        onTap: () {
          if (showFilterOptions) setState(() => showFilterOptions = false);
        },
        child: Stack(
          children: [
            Column(
              children: [
                ///  FIRM CARD
                if (viewModel.isLoading)
                  const LinearProgressIndicator()
                else if (viewModel.firmData != null)
                  FirmCard(
                    firmId: viewModel.firmData!.firmId.toString(),
                    firmName: viewModel.firmData!.firmName,
                    city: viewModel.firmData!.address,
                    phone: viewModel.firmData!.phoneNo,
                    fullData: viewModel.firmData,
                  ),

                /// SEARCH AREA
                const SizedBox(height: 120),

                ///  ORDERS LIST
                Expanded(
                  child: orderVM.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : orderVM.orders.isEmpty
                      ? const Center(child: Text("No Orders Found", style: TextStyle(color: Colors.grey, fontSize: 16)))
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    itemCount: orderVM.orders.length,
                    itemBuilder: (context, index) {
                      final order = orderVM.orders[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => OrderDetailsPage(orderId: order.orderId.toString()));
                          },
                          child: OrderItemCard(
                            orderId: order.orderId.toString(),
                            amount: order.totalAmount.toString(),
                            date: order.placedDate.toString(),
                            status: order.orderStatus ?? "Placed",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            ///  FLOATING HEADER

            Positioned(
              top: viewModel.firmData != null ? 100 : 0,
              left: 0, right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: TextField(
                              controller: searchController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) => fetchOrders(),
                              decoration: InputDecoration(
                                hintText: "Search Order ID...",
                                hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),


                                filled: true,
                                fillColor: Colors.grey.shade200,

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        ///  FILTER DROPDOWN
                        OrderFilterWidget(
                          selectedFilter: selectedFilter,
                          onSelect: (status) {
                            setState(() {
                              selectedFilter = status;
                              showFilterOptions = false;
                            });
                            fetchOrders();
                          },
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: OrderDatePicker(
                            label: "From Date",
                            selectedDate: fromDate,
                            onTap: () => _selectDate(context, true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OrderDatePicker(
                            label: "To Date",
                            selectedDate: toDate,
                            onTap: () => _selectDate(context, false),
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
    );
  }
}