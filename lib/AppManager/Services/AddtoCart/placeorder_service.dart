import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AddtoCart/placeorder_model.dart';


class PlaceOrderService {
  final String baseUrl = "https://retailer.medrpha.com/api/Cart/PlaceOrder";

  Future<PlaceOrderResponseModel?> placeOrder(
      PlaceOrderRequestModel requestModel) async {
    try {
      final uri = Uri.parse(baseUrl);

      print(" URI: $uri");
      print(" REQUEST BODY: ${jsonEncode(requestModel.toJson())}");

      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestModel.toJson()),
      );

      print(" RESPONSE STATUS: ${response.statusCode}");
      print(" RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        return PlaceOrderResponseModel.fromJson(
            jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(" ERROR: $e");
      return null;
    }
  }
}