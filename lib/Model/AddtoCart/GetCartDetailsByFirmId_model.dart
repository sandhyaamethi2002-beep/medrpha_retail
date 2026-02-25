class CartItemModel {
  final int cartId;
  final int pid;
  final String productName;
  final String productImg;
  final int minOrderQty;
  final String companyName;
  final String categoryName;
  final String saleType;
  final int quantity;
  final double mrp;
  final double companyPrice;
  final double salePrice;
  final double tmrp;
  final double tSalePrice;
  final int minQuantity;
  final int maxQuantity;
  final int priceId;
  final int wpid;
  final double minOrderAmount;

  CartItemModel({
    required this.cartId,
    required this.pid,
    required this.productName,
    required this.productImg,
    required this.minOrderQty,
    required this.companyName,
    required this.categoryName,
    required this.saleType,
    required this.quantity,
    required this.mrp,
    required this.companyPrice,
    required this.salePrice,
    required this.tmrp,
    required this.tSalePrice,
    required this.minQuantity,
    required this.maxQuantity,
    required this.priceId,
    required this.wpid,
    required this.minOrderAmount,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      cartId: json['cartId'],
      pid: json['pid'],
      productName: json['productName'],
      productImg: json['product_img'],
      minOrderQty: json['min_order_qty'],
      companyName: json['companyName'],
      categoryName: json['categoryName'],
      saleType: json['saleType'],
      quantity: json['quantity'],
      mrp: (json['mrp'] ?? 0).toDouble(),
      companyPrice: (json['companyPrice'] ?? 0).toDouble(),
      salePrice: (json['salePrice'] ?? 0).toDouble(),
      tmrp: (json['tmrp'] ?? 0).toDouble(),
      tSalePrice: (json['tSalePrice'] ?? 0).toDouble(),
      minQuantity: json['minQuantity'],
      maxQuantity: json['maxQuantity'],
      priceId: json['priceId'],
      wpid: json['wpid'],
      minOrderAmount: (json['minOrderAmount'] ?? 0).toDouble(),
    );
  }
}