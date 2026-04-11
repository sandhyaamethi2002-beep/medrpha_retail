class GetOrderInvoiceModel {
  bool? success;
  List<OrderInvoiceData>? data;

  GetOrderInvoiceModel({this.success, this.data});

  GetOrderInvoiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <OrderInvoiceData>[];
      json['data'].forEach((v) {
        data!.add(OrderInvoiceData.fromJson(v));
      });
    }
  }
}

class OrderInvoiceData {
  int? orderId;
  String? transactionId;
  String? orderDatetime;
  double? orderAmount;
  String? paymentStatusText;
  String? paymentStatusMode;
  String? orderStatusText;
  String? productName;
  String? compnayName;
  String? batchNumber;
  String? dtExpiryDate;
  String? hsnValue;
  double? mrp;
  double? companyPrice;
  int? quantity;
  String? personName;
  String? personNumber;
  String? countryName;
  String? stateName;
  String? cityName;
  String? areaName;
  double? sgst;
  double? cgst;
  String? gstno;

  OrderInvoiceData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    transactionId = json['transaction_id'];
    orderDatetime = json['order_datetime'];
    orderAmount = (json['order_amount'] ?? 0).toDouble();
    paymentStatusText = json['payment_status_text'];
    paymentStatusMode = json['payment_status_mode'];
    orderStatusText = json['order_status_text'];
    productName = json['product_name'];
    compnayName = json['compnay_name'];
    batchNumber = json['batchNumber'];
    dtExpiryDate = json['dtExpiryDate'];
    hsnValue = json['hsn_value'];
    mrp = (json['mrp'] ?? 0).toDouble();
    companyPrice = (json['company_price'] ?? 0).toDouble();
    quantity = json['quantity'];
    personName = json['personName'];
    personNumber = json['personNumber'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    areaName = json['area_name'];
    sgst = (json['sgst'] ?? 0).toDouble();
    cgst = (json['cgst'] ?? 0).toDouble();
    gstno = json['gstno'];
  }
}