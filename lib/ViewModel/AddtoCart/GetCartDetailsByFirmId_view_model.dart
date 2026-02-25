import 'package:flutter/material.dart';
import '../../AppManager/Services/AddtoCart/GetCartDetailsByFirmId_service.dart';
import '../../Model/AddtoCart/GetCartDetailsByFirmId_model.dart';

class GetCartDetailsByFirmIdViewModel extends ChangeNotifier {
  final GetCartDetailsByFirmIdService _service = GetCartDetailsByFirmIdService();

  bool isLoading = false;
  List<CartItemModel> cartItems = [];
  String error = '';

  Future<void> fetchCartByFirmId(int firmId) async {
    isLoading = true;
    notifyListeners();

    try {
      final items = await _service.fetchCartByFirmId(firmId);
      cartItems = items;
      error = '';
    } catch (e) {
      error = e.toString();
      cartItems = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}