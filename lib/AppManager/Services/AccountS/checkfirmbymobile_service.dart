import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AccountM/checkfirmbymobile_model.dart';

class CheckFirmByMobileService {
  Future<CheckFirmByMobileModel> checkFirmByMobile({
    required String mobileNumber,
  }) async {
    final uri = Uri.parse(
      "https://retailer.medrpha.com/api/MasterApi/CheckFirmByMobile?mobileNumber=$mobileNumber",
    );

    print("===== CheckFirmByMobile API =====");
    print("URI: $uri");
    print("Request Method: GET");
    print("Request Query: mobileNumber=$mobileNumber");

    final response = await http.get(uri);

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    print("===================================");

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return CheckFirmByMobileModel.fromJson(jsonData);
    } else {
      throw Exception("Failed to load data");
    }
  }
}