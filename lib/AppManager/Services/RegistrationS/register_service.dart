import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medrpha/Model/RegistrationM/city_model.dart';
import 'package:medrpha/Model/RegistrationM/country_model.dart';
import 'package:medrpha/Model/RegistrationM/state_model.dart';
import '../../../Model/RegistrationM/pincode_model.dart';
import '../../../Model/RegistrationM/register_model.dart';

class RegisterService {

  static const String registerUrl =
      "https://retailer.medrpha.com/api/MasterApi/AddFirm";

  static const String countryUrl =
      "https://retailer.medrpha.com/api/MasterApi/GetCountries";

  static const String stateUrl =
      "https://retailer.medrpha.com/api/MasterApi/GetStatesByCountry";

  static const String cityUrl =
      "https://retailer.medrpha.com/api/MasterApi/GetCityByState";

  static const String pincodeUrl =
      "https://retailer.medrpha.com/api/MasterApi/GetAreaByCity";


  // ================= REGISTER =================
  Future<bool> registerFirm(RegisterRequestModel model) async {
    final uri = Uri.parse(registerUrl);

    try {
      final response = await http.post(
        uri,
        body: model.toMap(),
      );

      print("REGISTER API RESPONSE: ${response.body}");

      final decoded = jsonDecode(response.body);

      print("REGISTER API SUCCESS: ${decoded['success']}");
      print("REGISTER API MESSAGE: ${decoded['message']}");

      return decoded["success"] == true;

    } catch (e) {
      print("Register ERROR: $e");
      return false;
    }
  }

  // ================= COUNTRIES =================
  Future<List<Country>> getCountries() async {
    final uri = Uri.parse(countryUrl);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final countryResponse = CountryResponse.fromJson(decoded);
        if (countryResponse.success) {
          return countryResponse.data;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print("Country ERROR: $e");
      return [];
    }
  }

  // ================= STATES =================
  Future<List<StateModel>> getStates(int countryId) async {
    final uri = Uri.parse("$stateUrl?countryId=$countryId");

    try {
      final response = await http.get(uri);

      print(uri);

      print("STATE API STATUS: ${response.statusCode}");
      print("STATE API RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded['success'] == true) {
          List data = decoded['data'];

          return data
              .map((e) => StateModel.fromJson(e))
              .toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print("State ERROR: $e");
      return [];
    }
  }

  // ================= CITIES =================
  Future<List<CityModel>> getCities(int stateId) async {
    final uri = Uri.parse("$cityUrl?stateId=$stateId");

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['success'] == true) {
          final List data = decoded['data'];
          return data.map((e) => CityModel.fromJson(e)).toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print("City ERROR: $e");
      return [];
    }
  }

  // ================= PINCODES =================
  Future<List<PincodeModel>> getPincodes(int cityId) async {

    final uri = Uri.parse("$pincodeUrl?cityid=$cityId");

    try {
      final response = await http.get(uri);

      print(uri);
      print("PINCODE API STATUS: ${response.statusCode}");
      print("PINCODE API RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);  // Map
        if (decoded['success'] == true) {
          final List data = decoded['data'];       // List inside Map
          return data.map((e) => PincodeModel.fromJson(e)).toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print("Pincode ERROR: $e");
      return [];
    }
  }

}