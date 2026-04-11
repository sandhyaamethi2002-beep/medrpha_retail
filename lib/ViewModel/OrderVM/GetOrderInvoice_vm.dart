import 'package:flutter/material.dart';

import '../../AppManager/Services/OrderS/GetOrderInvoice_service.dart';
import '../../Model/OrderM/GetOrderInvoice_model.dart';

class GetOrderInvoiceVM extends ChangeNotifier {

  final GetOrderInvoiceService _service = GetOrderInvoiceService();

  bool isLoading = false;

  List<OrderInvoiceData> invoiceList = [];

  Future<void> fetchOrderInvoice(int orderId) async {

    try {

      isLoading = true;
      notifyListeners();

      invoiceList = await _service.fetchOrderInvoice(orderId);

    } catch (e) {

      print("Invoice API Error: $e");

    } finally {

      isLoading = false;
      notifyListeners();

    }
  }
}