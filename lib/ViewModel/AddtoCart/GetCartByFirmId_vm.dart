import 'package:flutter/material.dart';
import '../../AppManager/Services/AddtoCart/GetCartByFirmId_service.dart';
import '../../Model/AddtoCart/GetCartByFirmId_model.dart';

class GetCartByFirmIdViewModel extends ChangeNotifier {

  final GetCartByFirmIdService _service = GetCartByFirmIdService();

  List<CartItem> cartList = [];

  bool isLoading = false;

  Future<void> fetchCart(
      int firmId,
      int userTypeId,
      ) async {

    isLoading = true;
    notifyListeners();

    final response = await _service.getCartByFirmId(firmId, userTypeId);

    if (response != null && response.success == true) {
      cartList = response.data ?? [];
    }

    isLoading = false;
    notifyListeners();
  }
}