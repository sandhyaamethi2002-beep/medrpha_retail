class GetOrdersByFirmResponse {
  final bool success;
  final List<OrderData> data;

  GetOrdersByFirmResponse({
    required this.success,
    required this.data,
  });

  factory GetOrdersByFirmResponse.fromJson(Map<String, dynamic> json) {
    return GetOrdersByFirmResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map((e) => OrderData.fromJson(e))
          .toList(),
    );
  }
}

class OrderData {
  final int orderId;
  final String? orderNo;
  final String orderBy;
  final double totalAmount;
  final String paymentStatusMode;
  final String paymentStatusText;
  final String firmName;
  final String address;
  final String phoneNo;
  final String city;
  final String state;
  final String country;
  final String placedDate;
  final String placedTime;
  final String orderStatus;

  OrderData({
    required this.orderId,
    this.orderNo,
    required this.orderBy,
    required this.totalAmount,
    required this.paymentStatusMode,
    required this.paymentStatusText,
    required this.firmName,
    required this.address,
    required this.phoneNo,
    required this.city,
    required this.state,
    required this.country,
    required this.placedDate,
    required this.placedTime,
    required this.orderStatus,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['order_id'],
      orderNo: json['order_no'],
      orderBy: json['order_by'] ?? "",
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      paymentStatusMode: json['payment_status_mode'] ?? "",
      paymentStatusText: json['payment_status_text'] ?? "",
      firmName: json['firm_name'] ?? "",
      address: json['address'] ?? "",
      phoneNo: json['phoneno'] ?? "",
      city: json['citynameadmin'] ?? "",
      state: json['statenameadmin'] ?? "",
      country: json['countrynameadmin'] ?? "",
      placedDate: json['placed_date'] ?? "",
      placedTime: json['placed_time'] ?? "",
      orderStatus: json['order_status_text'] ?? "",
    );
  }
}