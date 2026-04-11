import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/OrderM/GetOrdersByFirm_model.dart';

class GetOrdersByFirmService {

  Future<List<OrderData>> getOrders({
    required int firmId,
    int? orderId,
    String? fromDate,
    String? toDate,
  }) async {

    final uri = Uri.parse(
        "https://retailer.medrpha.com/api/Cart/GetOrdersByFirm/$firmId"
            "?orderId=${orderId ?? ""}"
            "&fromDate=${Uri.encodeComponent(fromDate ?? "")}"
            "&toDate=${Uri.encodeComponent(toDate ?? "")}"
    );

    print("----------- API REQUEST -----------");
    print("URI: $uri");

    final response = await http.get(uri);

    print("----------- API RESPONSE -----------");
    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final result = GetOrdersByFirmResponse.fromJson(jsonData);

      return result.data;
    } else {
      throw Exception("Failed to load orders");
    }
  }
}