import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AccountM/getfirmbyid_model.dart';

class GetFirmByIdService {

  Future<GetFirmByIdModel?> getFirmById(int id) async {
    final Uri uri = Uri.parse(
        "https://retailer.medrpha.com/api/MasterApi/GetFirmById/$id");

    print("========== API CALL ==========");
    print("URI: $uri");
    print("Request Method: GET");
    print("Request Path Param ID: $id");

    try {
      final response = await http.get(uri);

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return GetFirmByIdModel.fromJson(jsonData);
      } else {
        print("API Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}