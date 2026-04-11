import 'package:flutter/material.dart';
import '../../AppManager/Services/AddtoCart/DeleteCartById_service.dart';


class DeleteCartByIdViewModel extends ChangeNotifier {

  bool isLoading = false;

  Future<bool> deleteCart({
    required int cartId,
    required int userTypeId,
  }) async {

    isLoading = true;
    notifyListeners();

    final response = await DeleteCartByIdService().deleteCart(
      cartId: cartId,
      userTypeId: userTypeId,
    );

    isLoading = false;
    notifyListeners();

    if (response != null && response.success) {
      print("DELETE SUCCESS => ${response.message}");
      return true;
    }

    return false;
  }
}