import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/OrderM/GetOrderInvoice_model.dart';

class GetOrderInvoiceService {

  Future<List<OrderInvoiceData>> fetchOrderInvoice(int orderId) async {

    final uri = Uri.parse(
        "https://retailer.medrpha.com/api/Cart/GetOrderInvoice/$orderId");

    print("----------- API CALL -----------");
    print("URI: $uri");
    print("Request Method: GET");
    print("Request Body: orderId = $orderId");

    final response = await http.get(uri);

    print("Status Code: ${response.statusCode}");
    print("Response: ${response.body}");
    print("--------------------------------");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final model = GetOrderInvoiceModel.fromJson(jsonData);
      return model.data ?? [];
    } else {
      throw Exception("Failed to load invoice");
    }
  }
}