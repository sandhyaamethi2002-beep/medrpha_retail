import 'dart:convert';
import 'package:http/http.dart' as http;

class GetProductDetailService {

  Future<Map<String, dynamic>> fetchProducts(int categoryId) async {

    final Uri uri = Uri.parse(
        "https://retailer.medrpha.com/api/MasterApi/GetProductDetails"
            "?categoryIds=$categoryId&adminId=1&userTypeId=1&areaId=1"
    );

    print("========== GET PRODUCT DETAILS ==========");
    print("URI: $uri");
    print("Method: GET");

    final response = await http.get(uri);

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    print("=========================================");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }
}