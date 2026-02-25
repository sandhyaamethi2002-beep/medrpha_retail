import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AddtoCart/GetCartDetailsByFirmId_model.dart';


class GetCartDetailsByFirmIdService {
  final String baseUrl = "https://retailer.medrpha.com/api/Cart";

  Future<List<CartItemModel>> fetchCartByFirmId(int firmId) async {
    final uri = Uri.parse("$baseUrl/GetCartDetailsByFirmId/$firmId");
    print("API URI: $uri");

    try {
      final response = await http.get(uri);
      print("Request: GET $uri");
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((e) => CartItemModel.fromJson(e)).toList();
        } else {
          throw Exception(jsonResponse['message']);
        }
      } else {
        throw Exception("Failed to fetch cart items");
      }
    } catch (e) {
      print("Error fetching cart: $e");
      rethrow;
    }
  }
}