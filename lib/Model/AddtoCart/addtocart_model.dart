class AddToCartModel {
  final int totalQty;
  final double totalPrice;
  final int totalItems;

  AddToCartModel({
    required this.totalQty,
    required this.totalPrice,
    required this.totalItems,
  });

  factory AddToCartModel.fromJson(Map<String, dynamic> json) {
    return AddToCartModel(
      totalQty: json['totalQty'] ?? 0,
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      totalItems: json['totalItems'] ?? 0,
    );
  }
}