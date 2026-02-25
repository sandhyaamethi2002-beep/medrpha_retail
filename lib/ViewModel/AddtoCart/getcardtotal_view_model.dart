import 'package:flutter/material.dart';

import '../../AppManager/Services/AddtoCart/getcardtotal_service.dart';
import '../../Model/AddtoCart/getcardtotal_model.dart';

class GetCartTotalViewModel extends ChangeNotifier {
  final GetCartTotalService _service = GetCartTotalService();

  GetCartTotalModel? cartTotal;
  bool isLoading = false;

  Future<void> fetchCartTotal({required int firmId, required int userTypeId}) async {
    isLoading = true;
    notifyListeners();

    cartTotal = await _service.getCartTotal(firmId: firmId, userTypeId: userTypeId);

    isLoading = false;
    notifyListeners();
  }

  double get totalPrice => cartTotal?.totalPrice ?? 0.0;
  int get totalQty => cartTotal?.totalQty ?? 0;
  int get totalItems => cartTotal?.totalItems ?? 0;
}