import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/CategoryM/getcategory_model.dart';

class GetCategoryService {

  Future<GetCategoryModel?> fetchCategories() async {

    final Uri uri = Uri.parse(
        "https://retailer.medrpha.com/api/MasterApi/GetCategories");

    print("URI: $uri");

    try {

      print("REQUEST: GET");
      print("HEADERS: {Content-Type: application/json}");

      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        return GetCategoryModel.fromJson(jsonDecode(response.body));
      } else {
        print("ERROR: ${response.statusCode}");
        return null;
      }

    } catch (e) {
      print("EXCEPTION: $e");
      return null;
    }
  }
}