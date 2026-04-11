import 'package:flutter/material.dart';
import '../../AppManager/Services/OrderS/GetOrdersByFirm_service.dart';
import '../../Model/OrderM/GetOrdersByFirm_model.dart';

class GetOrdersByFirmViewModel extends ChangeNotifier {

  final GetOrdersByFirmService _service = GetOrdersByFirmService();

  bool isLoading = false;

  List<OrderData> orders = [];

  Future<void> fetchOrders({
    required int firmId,
    int? orderId,
    String? fromDate,
    String? toDate,
  }) async {

    try {
      isLoading = true;
      notifyListeners();

      orders = await _service.getOrders(
        firmId: firmId,
        orderId: orderId,
        fromDate: fromDate,
        toDate: toDate,
      );

    } catch (e) {
      print("ERROR FETCHING ORDERS: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}