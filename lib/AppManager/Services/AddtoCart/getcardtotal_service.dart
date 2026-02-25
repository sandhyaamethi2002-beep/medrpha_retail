import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Model/AddtoCart/getcardtotal_model.dart';


class GetCartTotalService {
  final String baseUrl = "https://retailer.medrpha.com/api/Cart";

  Future<GetCartTotalModel?> getCartTotal({
    required int firmId,
    required int userTypeId,
  }) async {
    final uri = Uri.parse("$baseUrl/GetCartTotals/$firmId/$userTypeId");
    print("📌 Request URI: $uri");

    try {
      final response = await http.get(uri);
      print("📌 Request Body: firmId=$firmId, userTypeId=$userTypeId");
      print("📌 Response Code: ${response.statusCode}");
      print("📌 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return GetCartTotalModel.fromJson(data);
      } else {
        print("❌ Failed to fetch cart total.");
        return null;
      }
    } catch (e) {
      print("❌ Error: $e");
      return null;
    }
  }
}