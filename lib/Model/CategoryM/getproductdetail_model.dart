class GetProductDetailModel {
  final bool success;
  final List<ProductData> data;

  GetProductDetailModel({
    required this.success,
    required this.data,
  });

  factory GetProductDetailModel.fromJson(Map<String, dynamic> json) {
    return GetProductDetailModel(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map((e) => ProductData.fromJson(e))
          .toList(),
    );
  }
}

class ProductData {
  final int pid;
  final String productName;
  final String categoryName;
  final String companyName;
  final String productImg;
  final String productType;
  final String unitType;
  final String quantityType;
  final double mrp;
  final double finalCompanyPrice;
  final double discountPercentage;
  final String description;
  final int availableQuantity;
  final int minOrderQty;

  ProductData({
    required this.pid,
    required this.productName,
    required this.categoryName,
    required this.companyName,
    required this.productImg,
    required this.productType,
    required this.unitType,
    required this.quantityType,
    required this.mrp,
    required this.finalCompanyPrice,
    required this.discountPercentage,
    required this.description,
    required this.availableQuantity,
    required this.minOrderQty,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      pid: json['pid'] ?? 0,
      productName: json['product_name'] ?? '',
      categoryName: json['category_name'] ?? '',
      companyName: json['company_name'] ?? '',
      productImg: json['product_img'] ?? '',
      productType: json['product_type'] ?? '',
      unitType: json['unit_type'] ?? '',
      quantityType: json['quantity_type'] ?? '',
      mrp: (json['mrp'] ?? 0).toDouble(),
      finalCompanyPrice: (json['finalCompanyPrice'] ?? 0).toDouble(),
      discountPercentage:
      (json['discountPercentage'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      availableQuantity: json['available_quantity'] ?? 0,
      minOrderQty: json['min_order_qty'] ?? 0,
    );
  }

  get priceId => null;
}
