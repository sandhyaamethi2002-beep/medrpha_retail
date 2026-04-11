import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AddtoCart/GetCartByFirmId_model.dart';

class GetCartByFirmIdService {

  Future<GetCartByFirmIdModel?> getCartByFirmId(
      int firmId,
      int userTypeId,
      ) async {

    final uri = Uri.parse(
        "https://retailer.medrpha.com/api/Cart/GetCartByFirmId/$firmId/$userTypeId");

    print("GET CART API URI -> $uri");

    try {

      final response = await http.get(uri);

      print("REQUEST -> firmId: $firmId , userTypeId: $userTypeId");
      print("RESPONSE STATUS -> ${response.statusCode}");
      print("RESPONSE BODY -> ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return GetCartByFirmIdModel.fromJson(jsonData);
      }

    } catch (e) {
      print("GET CART ERROR -> $e");
    }

    return null;
  }
}