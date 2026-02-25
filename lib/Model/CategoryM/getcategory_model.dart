class GetCategoryModel {
  final bool success;
  final String message;
  final List<CategoryData> data;

  GetCategoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) {
    return GetCategoryModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List)
          .map((e) => CategoryData.fromJson(e))
          .toList(),
    );
  }
}

class CategoryData {
  final int catId;
  final String categoryName;
  final int status;
  final int subLevelId;
  final int webTypeId;
  final int minimumOrderQuantity;

  CategoryData({
    required this.catId,
    required this.categoryName,
    required this.status,
    required this.subLevelId,
    required this.webTypeId,
    required this.minimumOrderQuantity,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      catId: json['catId'],
      categoryName: json['categoryName'],
      status: json['status'],
      subLevelId: json['subLevelId'],
      webTypeId: json['webTypeId'],
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,
    );
  }
}