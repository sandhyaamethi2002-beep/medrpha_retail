class GetOrderDetailsModel {
  bool? success;
  List<OrderDetails>? data;

  GetOrderDetailsModel({this.success, this.data});

  GetOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <OrderDetails>[];
      json['data'].forEach((v) {
        data!.add(OrderDetails.fromJson(v));
      });
    }
  }
}

class OrderDetails {
  int? orderDetailsId;
  int? orderId;
  int? pid;
  String? productName;
  String? productImg;
  String? compnayName;
  String? categoryName;
  double? companyPrice;
  double? unitMrp;
  int? orderedQty;
  String? unitType;
  String? quantityType;
  String? unitQuantity;
  String? batchNumber;
  String? dtExpiryDate;
  double? totalPrice;
  String? orderDate;

  OrderDetails({
    this.orderDetailsId,
    this.orderId,
    this.pid,
    this.productName,
    this.productImg,
    this.compnayName,
    this.categoryName,
    this.companyPrice,
    this.unitMrp,
    this.orderedQty,
    this.unitType,
    this.quantityType,
    this.unitQuantity,
    this.batchNumber,
    this.dtExpiryDate,
    this.totalPrice,
    this.orderDate,
  });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderDetailsId = json['order_details_id'];
    orderId = json['order_id'];
    pid = json['pid'];
    productName = json['product_name'];
    productImg = json['product_img'];
    compnayName = json['compnay_name'];
    categoryName = json['category_name'];
    companyPrice = (json['company_price'] as num?)?.toDouble();
    unitMrp = (json['unitMrp'] as num?)?.toDouble();
    orderedQty = json['orderedQty'];
    unitType = json['unit_type'];
    quantityType = json['quantity_type'];
    unitQuantity = json['unit_quantity'];
    batchNumber = json['batchNumber'];
    dtExpiryDate = json['dtExpiryDate'];
    totalPrice = (json['totalPrice'] as num?)?.toDouble();
    orderDate = json['orderDate'];
  }
}