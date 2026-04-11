import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/OrderM/GetOrderDetails_model.dart';

class GetOrderDetailsService {

  Future<GetOrderDetailsModel?> getOrderDetails(int orderId) async {

    final uri = Uri.parse(
        "https://retailer.medrpha.com/api/Cart/GetOrderDetails/$orderId");

    print("------------ API REQUEST ------------");
    print("URI : $uri");
    print("METHOD : GET");
    print("-------------------------------------");

    try {

      final response = await http.get(uri);

      print("------------ API RESPONSE ------------");
      print("STATUS : ${response.statusCode}");
      print("BODY : ${response.body}");
      print("--------------------------------------");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return GetOrderDetailsModel.fromJson(data);
      }

    } catch (e) {
      print("API ERROR : $e");
    }

    return null;
  }
}