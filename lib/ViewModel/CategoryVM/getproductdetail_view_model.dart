import 'package:flutter/material.dart';
import '../../AppManager/Services/CategoryS/getproductdetail_service.dart';
import '../../Model/CategoryM/getproductdetail_model.dart';

class GetProductDetailViewModel extends ChangeNotifier {

  final GetProductDetailService _service =
  GetProductDetailService();

  bool isLoading = false;
  String errorMessage = "";
  List<ProductData> productList = [];

  Future<void> getProducts(int categoryId) async {

    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      print("=========== API CALL START ===========");
      print("Category ID: $categoryId");

      final response = await _service.fetchProducts(categoryId);

      print("RAW RESPONSE: $response");

      if (response == null) {
        errorMessage = "Response is null";
        print("ERROR: Response is null");
        return;
      }

      final model =
      GetProductDetailModel.fromJson(response);

      print("Model Success: ${model.success}");
      print("Total Products From API: ${model.data.length}");

      if (model.success == true) {
        productList = model.data;

        print("Product List Assigned: ${productList.length}");
      } else {
        errorMessage = "Failed to fetch products";
        print("ERROR: API success = false");
      }

    } catch (e, stackTrace) {
      errorMessage = e.toString();
      print("=========== API ERROR ===========");
      print("Error: $e");
      print("StackTrace: $stackTrace");
    } finally {
      isLoading = false;
      notifyListeners();
      print("=========== API CALL END ===========");
    }
  }
}