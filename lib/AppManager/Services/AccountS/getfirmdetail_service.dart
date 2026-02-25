import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AccountM/getfirmdetail_model.dart';

class GetFirmDetailService {
  Future<GetFirmDetailModel?> getFirmDetail(int firmId) async {
    try {
      final uri = Uri.parse(
          "https://retailer.medrpha.com/api/MasterApi/GetFirmDetail/$firmId");

      print("REQUEST URI: $uri");

      print("REQUEST METHOD: GET");
      print("REQUEST BODY: firmId = $firmId");

      final response = await http.get(uri);

      print("RESPONSE STATUS CODE: ${response.statusCode}");

      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return GetFirmDetailModel.fromJson(jsonData);
      } else {
        print("API ERROR");
        return null;
      }
    } catch (e) {
      print("EXCEPTION: $e");
      return null;
    }
  }
}