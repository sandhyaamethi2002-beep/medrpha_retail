import 'package:flutter/material.dart';
import '../../AppManager/Services/AddtoCart/placeorder_service.dart';
import '../../Model/AddtoCart/placeorder_model.dart';

class PlaceOrderViewModel extends ChangeNotifier {
  final PlaceOrderService _service = PlaceOrderService();

  bool isLoading = false;
  PlaceOrderResponseModel? responseModel;

  Future<bool> placeOrder({
    required int userId,
    required int userTypeId,
    required int roleId,
    required double orderAmount,
    required String address,
    required String phone,
    required String name,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final requestModel = PlaceOrderRequestModel(
        userId: userId,
        userTypeId: userTypeId,
        roleId: 1,
        orderAmount: orderAmount,
        payModeId: 1,
        transactionId: "TXN${DateTime.now().millisecondsSinceEpoch}",
        paymentStatus: 0,
        address: address,
        country: "India",
        state: "UP",
        city: "Lucknow",
        phone: phone,
        email: "test@gmail.com",
        name: name,
      );

      responseModel = await _service.placeOrder(requestModel);

      isLoading = false;
      notifyListeners();

      return responseModel != null && responseModel!.success == true;
    } catch (e) {
      debugPrint("Error placing order: $e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}