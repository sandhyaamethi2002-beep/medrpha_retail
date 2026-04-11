import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AddtoCart/DeleteCartById_model.dart';

class DeleteCartByIdService {

  Future<DeleteCartByIdModel?> deleteCart({
    required int cartId,
    required int userTypeId,
  }) async {

    final Uri uri = Uri.parse(
        "https://retailer.medrpha.com/api/Cart/DeleteCartById/$cartId/$userTypeId");

    try {

      print("DELETE CART API URI => $uri");

      final response = await http.delete(uri);

      print("DELETE CART STATUS CODE => ${response.statusCode}");
      print("DELETE CART RESPONSE => ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return DeleteCartByIdModel.fromJson(jsonData);
      }

      return null;

    } catch (e) {
      print("DELETE CART ERROR => $e");
      return null;
    }
  }
}