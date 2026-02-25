import 'package:flutter/material.dart';

import '../../AppManager/Services/AddtoCart/placeorder_service.dart';
import '../../Model/AddtoCart/placeorder_model.dart';


class PlaceOrderViewModel extends ChangeNotifier {
  final PlaceOrderService _service = PlaceOrderService();

  bool isLoading = false;
  PlaceOrderResponseModel? responseModel;

  Future<void> placeOrder(PlaceOrderRequestModel requestModel) async {
    isLoading = true;
    notifyListeners();

    responseModel = await _service.placeOrder(requestModel);

    isLoading = false;
    notifyListeners();
  }
}