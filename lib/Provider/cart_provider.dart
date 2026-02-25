import 'package:flutter/material.dart';

class CartItem {
  final String productName;
  final String imageUrl;
  final String available;
  final double price;
  final int minQuantity;
  final int maxQuantity;
  final int priceId;
  final int wpid;
  final String saleType;
  int qty;

  CartItem({
    required this.productName,
    required this.imageUrl,
    required this.available,
    required this.price,
    required this.minQuantity,
    this.maxQuantity = 999,
    this.priceId = 0,
    this.wpid = 0,
    this.saleType = "N/A",
    this.qty = 1,
  });
}

class CartProvider with ChangeNotifier {
  List<CartItem> cartList = [];

  void addToCart(
      String productName,
      String imageUrl,
      String available,
      double price,
      int minQuantity, {
        int maxQuantity = 999,
        int priceId = 0,
        int wpid = 0,
        String saleType = "N/A",
      }) {
    int index = cartList.indexWhere((item) => item.productName == productName);

    if (index != -1) {
      cartList[index].qty += 1;
      if (cartList[index].qty > cartList[index].maxQuantity) {
        cartList[index].qty = cartList[index].maxQuantity;
      }
    } else {
      cartList.add(CartItem(
        productName: productName,
        imageUrl: imageUrl,
        available: available,
        price: price,
        minQuantity: minQuantity,
        maxQuantity: maxQuantity,
        priceId: priceId,
        wpid: wpid,
        saleType: saleType,
        qty: minQuantity,
      ));
    }

    notifyListeners();
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < cartList.length) {
      cartList.removeAt(index);
      notifyListeners();
    }
  }

  void removeFromCartByName(String productName) {
    cartList.removeWhere((item) => item.productName == productName);
    notifyListeners();
  }

  void increaseQty(String productName) {
    int index = cartList.indexWhere((item) => item.productName == productName);
    if (index != -1) {
      if (cartList[index].qty < cartList[index].maxQuantity) {
        cartList[index].qty += 1;
        notifyListeners();
      }
    }
  }

  void decreaseQty(String productName, int minQuantity) {
    int index = cartList.indexWhere((item) => item.productName == productName);
    if (index != -1) {
      if (cartList[index].qty > minQuantity) {
        cartList[index].qty -= 1;
      } else {
        cartList.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Clear entire cart
  void clearCart() {
    cartList.clear();
    notifyListeners();
  }

  double get itemTotal {
    double total = 0;
    for (var item in cartList) {
      total += item.price * item.qty;
    }
    return total;
  }

  double get deliveryFee => itemTotal > 80 ? 0 : 30;

  double get handlingFee => 20;

  double get gst => itemTotal * 0.05;

  double get totalPay => itemTotal + deliveryFee + handlingFee + gst;

  int get totalItems {
    int total = 0;
    for (var item in cartList) {
      total += item.qty;
    }
    return total;
  }

  int get totalQty => totalItems;
}