import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/AccountM/loginwithpassword_model.dart';

class LoginWithPasswordService {
  final String _baseUrl = "https://retailer.medrpha.com/api/Account/login-with-password";

  Future<LoginWithPasswordModel?> login(String mobileNo, String password) async {
    final uri = Uri.parse(_baseUrl);
    final body = jsonEncode({"mobileNo": mobileNo, "password": password});

    print(" Request URL: $uri");
    print(" Request Body: $body");

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return LoginWithPasswordModel.fromJson(jsonDecode(response.body));
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}