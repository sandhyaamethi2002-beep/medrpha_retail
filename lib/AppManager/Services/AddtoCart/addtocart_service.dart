import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AddtoCart/addtocart_model.dart';

class AddToCartService {
  final String baseUrl = "https://retailer.medrpha.com/api/Cart/AddToCart";

  Future<AddToCartModel?> addToCart({
    required int productId,
    required int firmId,
    required int userId,
    required int qty,
    required double unitPrice,
    required int wpid,
    required int priceId,
  }) async {
    final body = {
      "productId": productId,
      "firmId": firmId,
      "userId": userId,
      "qty": qty,
      "unitPrice": unitPrice,
      "wpid": wpid,
      "priceId": priceId
    };

    print("📤 Request to AddToCart: $body");

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("📥 Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200) {
        return AddToCartModel.fromJson(jsonDecode(response.body));
      } else {
        print("Error adding to cart: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception adding to cart: $e");
    }
    return null;
  }
}