import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/RegistrationM/country_model.dart';

class CountryService {
  final String baseUrl =
      "https://retailer.medrpha.com/api/MasterApi/GetCountries";

  Future<CountryResponse?> getCountries() async {
    try {
      Uri uri = Uri.parse(baseUrl);

      print("📌 URI: $uri");

      print("📤 REQUEST:");
      print("Method: GET");

      final response = await http.get(uri);

      print("📥 RESPONSE STATUS: ${response.statusCode}");
      print("📥 RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return CountryResponse.fromJson(jsonData);
      } else {
        print("❌ Failed to fetch countries");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }
}
