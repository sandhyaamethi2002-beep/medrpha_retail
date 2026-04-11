import 'package:flutter/material.dart';

import '../../AppManager/Services/OrderS/GetOrderDetails_service.dart';
import '../../Model/OrderM/GetOrderDetails_model.dart';


class GetOrderDetailsVM extends ChangeNotifier {

  bool isLoading = false;
  List<OrderDetails> orders = [];

  final GetOrderDetailsService _service = GetOrderDetailsService();

  Future<void> fetchOrderDetails(int orderId) async {

    isLoading = true;
    notifyListeners();

    final response = await _service.getOrderDetails(orderId);

    if (response != null && response.success == true) {
      orders = response.data ?? [];
    }

    isLoading = false;
    notifyListeners();
  }
}