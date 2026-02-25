import 'package:flutter/material.dart';

import '../../AppManager/Services/AddtoCart/addtocart_service.dart';
import '../../Model/AddtoCart/addtocart_model.dart';


class AddToCartViewModel with ChangeNotifier {
  final AddToCartService _service = AddToCartService();
  AddToCartModel? cartData;
  bool isLoading = false;

  Future<void> addToCart({
    required int productId,
    required int firmId,
    required int userId,
    required int qty,
    required double unitPrice,
    required int wpid,
    required int priceId,
  }) async {
    isLoading = true;
    notifyListeners();

    cartData = await _service.addToCart(
      productId: productId,
      firmId: firmId,
      userId: userId,
      qty: qty,
      unitPrice: unitPrice,
      wpid: wpid,
      priceId: priceId,
    );

    isLoading = false;
    notifyListeners();
  }
}