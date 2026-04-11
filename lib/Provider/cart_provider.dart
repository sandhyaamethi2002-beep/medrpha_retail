import 'package:flutter/material.dart';

class CartItem {
  final int cartId;
  final String productName;
  final String companyName;
  final String imageUrl;
  final String available;
  double price;
  final int minQuantity;
  final int maxQuantity;
  final int priceId;
  final int wpid;
  final String saleType;
  int qty;
   double tSalePrice;
   double tmrp;

  CartItem({
    required this.cartId,
    required this.productName,
    required this.companyName,
    required this.imageUrl,
    required this.available,
    required this.price,
    required this.minQuantity,
    this.maxQuantity = 999,
    this.priceId = 0,
    this.wpid = 0,
    this.saleType = "N/A",
    this.qty = 1,
    required this.tSalePrice,
    required this.tmrp,
  });
}

class CartProvider with ChangeNotifier {
  List<CartItem> cartList = [];

  void addToCart(
       int cartId,
      String productName,
      String imageUrl,
      String available,
      double price,
      int minQuantity, {
        String companyName = "Unknown Company",
        int maxQuantity = 999,
        int priceId = 0,
        int wpid = 0,
        String saleType = "N/A",
        required double tSalePrice,
        required double tmrp,
      }) {
    int index = cartList.indexWhere((item) => item.productName == productName);

    if (index != -1) {
      increaseQty(productName);
    } else {
      int initialQty = minQuantity > 0 ? minQuantity : 1;

      cartList.add(CartItem(
        cartId: cartId,
        productName: productName,
        companyName: companyName,
        imageUrl: imageUrl,
        available: available,
        price: price,
        minQuantity: minQuantity,
        maxQuantity: maxQuantity,
        priceId: priceId,
        wpid: wpid,
        saleType: saleType,
        qty: initialQty,
        tSalePrice: tSalePrice,
        tmrp: tmrp,
      ));
      notifyListeners();
    }
  }

  void increaseQty(String productName) {
    int index = cartList.indexWhere((item) => item.productName == productName);
    if (index != -1) {
      var item = cartList[index];
      double unitPrice = item.price / item.qty;
      double unitMrp = item.tmrp / item.qty;

      int step = item.minQuantity > 0 ? item.minQuantity : 1;

      if (item.qty + step <= item.maxQuantity) {
        item.qty += step;

        item.price = unitPrice * item.qty;
        item.tmrp = unitMrp * item.qty;

        item.tSalePrice = item.price;
      }
      notifyListeners();
    }
  }

  void decreaseQty(String productName) {
    int index = cartList.indexWhere((item) => item.productName == productName);
    if (index != -1) {
      var item = cartList[index];

      double unitPrice = item.price / item.qty;
      double unitMrp = item.tmrp / item.qty;
      int step = item.minQuantity > 0 ? item.minQuantity : 1;

      if (item.qty > step) {
        item.qty -= step;
        item.price = unitPrice * item.qty;
        item.tmrp = unitMrp * item.qty;
        item.tSalePrice = item.price;

        notifyListeners();
      } else {
        cartList.removeAt(index);

      }
      notifyListeners();
    }
  }


  double get itemTotal {
    double total = 0;
    for (var item in cartList) {
      total += item.price;
    }
    return total;
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

  void clearCart() {
    cartList.clear();
    notifyListeners();
  }

}