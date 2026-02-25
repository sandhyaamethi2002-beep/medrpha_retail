import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/AccountVM/getfirmbyid_view_model.dart';
import '../widgets/order_filter_widget.dart';
import '../widgets/firm_card.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<MyOrderPage> {

  String? selectedFilter;
  bool showFilterOptions = false;
  List orderList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<GetFirmByIdViewModel>(context, listen: false)
            .fetchFirm(6132));
  }

  TextStyle commonTextStyle() {
    return TextStyle(
      fontSize: 16,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<GetFirmByIdViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("My Order", style: TextStyle(color: Colors.white)),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [

          if (viewModel.firmData != null)
            FirmCard(
              firmId: viewModel.firmData!.firmId.toString(),
              firmName: viewModel.firmData!.firmName,
              city: viewModel.firmData!.address,
              phone: viewModel.firmData!.phoneNo,
              fullData: viewModel.firmData,
            ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey.shade600),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OrderFilterWidget(
                  selectedFilter: selectedFilter,
                  showOptions: showFilterOptions,
                  onToggle: () =>
                      setState(() => showFilterOptions = !showFilterOptions),
                  onSelect: (status) {
                    setState(() {
                      selectedFilter = status;
                      showFilterOptions = false;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: orderList.isEmpty
                ? const Center(
              child: Text(
                "No Orders Found",
                style:
                TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
                : ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final item = orderList[index];
                return ListTile(title: Text("Order"));
              },
            ),
          ),
        ],
      ),
    );
  }
}