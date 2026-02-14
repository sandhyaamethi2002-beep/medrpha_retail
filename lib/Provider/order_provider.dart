import 'package:flutter/material.dart';
import '../Model/order_model.dart';

class OrderProvider with ChangeNotifier {

  List<OrderItem> orderList = [];

  void placeOrder(List cartItems) {
    for (var item in cartItems) {
      orderList.add(
        OrderItem(
          productName: item.productName,
          imageUrl: item.imageUrl,
          price: item.price,
          qty: item.qty,
          status: "Live",
        ),
      );
    }
    notifyListeners();
  }

  void updateStatus(String productName, String newStatus) {
    int index = orderList.indexWhere(
            (item) => item.productName == productName);

    if (index != -1) {
      orderList[index].status = newStatus;
      notifyListeners();
    }
  }
}
