import 'package:flutter/material.dart';
import '../../AppManager/Services/AccountS/loginwithpassword_service.dart';

class LoginWithPasswordViewModel extends ChangeNotifier {
  final LoginWithPasswordService _service = LoginWithPasswordService();

  bool isLoading = false;
  String message = '';

  Future<bool> login(String mobile, String password) async {
    isLoading = true;
    notifyListeners();

    final result = await _service.login(mobile, password);

    isLoading = false;
    if (result != null) {
      message = result.message;
      notifyListeners();
      return result.status;
    } else {
      message = "Something went wrong";
      notifyListeners();
      return false;
    }
  }
}