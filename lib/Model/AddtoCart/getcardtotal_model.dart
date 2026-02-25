class GetCartTotalModel {
  final int totalQty;
  final double totalPrice;
  final int totalItems;

  GetCartTotalModel({
    required this.totalQty,
    required this.totalPrice,
    required this.totalItems,
  });

  factory GetCartTotalModel.fromJson(Map<String, dynamic> json) {
    return GetCartTotalModel(
      totalQty: json['totalQty'] ?? 0,
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      totalItems: json['totalItems'] ?? 0,
    );
  }
}