import 'dart:convert';

class OrderItem {
  final int? orderId;
  final String productName;
  final String imageUrl;
  final double price;
  final int qty;
  String status;
  final String? orderDate;
  final double? totalAmount;

  OrderItem({
    this.orderId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.qty,
    required this.status,
    this.orderDate,
    this.totalAmount,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderId: json['orderId'],
      productName: json['productName'] ?? 'Unknown Product',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      qty: json['qty'] ?? 1,
      status: json['status'] ?? 'Pending',
      orderDate: json['orderDate'],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productName': productName,
      'imageUrl': imageUrl,
      'price': price,
      'qty': qty,
      'status': status,
      'orderDate': orderDate,
      'totalAmount': totalAmount,
    };
  }
}

List<OrderItem> orderItemFromJson(String str) =>
    List<OrderItem>.from(json.decode(str).map((x) => OrderItem.fromJson(x)));

String orderItemToJson(List<OrderItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));// TODO Implement this library.