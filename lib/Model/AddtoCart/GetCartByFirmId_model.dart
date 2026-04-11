class GetCartByFirmIdModel {
  bool? success;
  String? message;
  List<CartItem>? data;

  GetCartByFirmIdModel({this.success, this.message, this.data});

  GetCartByFirmIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    if (json['data'] != null) {
      data = <CartItem>[];
      json['data'].forEach((v) {
        data!.add(CartItem.fromJson(v));
      });
    }
  }
}

class CartItem {
  int? cartId;
  int? productId;
  String? productName;
  int? minOrderQty;
  int? qty;
  int? quantitymin;
  int? quantitymax;
  String? quantityType;
  int? wpid;
  int? priceId;
  double? sellingPrice;
  int? discountId;

  CartItem({
    this.cartId,
    this.productId,
    this.productName,
    this.minOrderQty,
    this.qty,
    this.quantitymin,
    this.quantitymax,
    this.quantityType,
    this.wpid,
    this.priceId,
    this.sellingPrice,
    this.discountId,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    productId = json['productId'];
    productName = json['productName'];
    minOrderQty = json['min_order_qty'];
    qty = json['qty'];
    quantitymin = json['quantitymin'];
    quantitymax = json['quantitymax'];
    quantityType = json['quantity_type'];
    wpid = json['wpid'];
    priceId = json['priceId'];
    sellingPrice = (json['sellingPrice'] as num?)?.toDouble();
    discountId = json['discountId'];
  }
}