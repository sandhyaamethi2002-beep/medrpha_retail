import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/RegistrationM/city_model.dart';


class CityService {
  static Future<List<CityModel>> getCityByState(int stateId) async {
    final Uri uri = Uri.parse(
        "https://retailer.medrpha.com/api/MasterApi/GetCityByState?stateId=$stateId");

    print("---------- CITY API ----------");
    print("Request URI: $uri");
    print("Request Type: GET");

    try {
      final response = await http.get(uri);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("-------------------------------");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['success'] == true) {
          List data = jsonData['data'];

          return data.map((e) => CityModel.fromJson(e)).toList();
        }
      }

      return [];
    } catch (e) {
      print("City API Error: $e");
      return [];
    }
  }
}
