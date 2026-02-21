import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/RegistrationM/state_model.dart';

class StateService {
  static Future<List<StateModel>> getStatesByCountry(int countryId) async {
    final Uri uri = Uri.parse(
        "https://retailer.medrpha.com/api/MasterApi/GetStatesByCountry?countryId=$countryId");

    print("=========== STATE API CALL ===========");
    print("Request URI: $uri");
    print("Request Method: GET");

    final response = await http.get(uri);

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    print("======================================");

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['success'] == true) {
        List data = jsonData['data'];
        return data.map((e) => StateModel.fromJson(e)).toList();
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception("Failed to load states");
    }
  }
}
