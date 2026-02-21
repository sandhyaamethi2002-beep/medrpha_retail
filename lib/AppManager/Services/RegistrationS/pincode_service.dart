import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/RegistrationM/pincode_model.dart';

class PincodeService {

  Future<List<PincodeModel>> getPincodeByCity(int cityId) async {

    final Uri uri = Uri.parse(
        "https://retailer.medrpha.com/api/MasterApi/GetAreaByCity?cityId=$cityId");

    print("REQUEST URI: $uri");

    final response = await http.get(uri);

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {

      final jsonData = jsonDecode(response.body);

      print("SUCCESS VALUE: ${jsonData['success']}");
      print("SUCCESS TYPE: ${jsonData['success'].runtimeType}");

      if (jsonData['success'] == true ||
          jsonData['success'].toString() == "true") {

        List data = jsonData['data'] ?? [];

        print("DATA LENGTH: ${data.length}");

        return data
            .map((e) => PincodeModel.fromJson(e))
            .toList();
      }
    }

    return [];
  }
}