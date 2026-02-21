import 'package:flutter/material.dart';
import '../../AppManager/Services/CategoryS/getcategory_service.dart';
import '../../Model/CategoryM/getcategory_model.dart';

class GetCategoryViewModel extends ChangeNotifier {

  final GetCategoryService _service = GetCategoryService();

  List<CategoryData> categories = [];
  bool isLoading = false;

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.fetchCategories();

    if (response != null && response.success) {
      categories = response.data;
    }

    isLoading = false;
    notifyListeners();
  }
}