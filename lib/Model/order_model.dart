class OrderItem {
  final String productName;
  final String imageUrl;
  final double price;
  final int qty;
  String status;

  OrderItem({
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.qty,
    this.status = "Live",
  });
}
