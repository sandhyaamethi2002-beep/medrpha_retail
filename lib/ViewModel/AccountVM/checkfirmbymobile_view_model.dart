import 'package:flutter/material.dart';

import '../../AppManager/Services/AccountS/checkfirmbymobile_service.dart';
import '../../Model/AccountM/checkfirmbymobile_model.dart';

class CheckFirmByMobileViewModel extends ChangeNotifier {
  final CheckFirmByMobileService _service = CheckFirmByMobileService();

  bool isLoading = false;
  CheckFirmByMobileModel? responseModel;

  Future<CheckFirmByMobileModel?> checkFirm(String mobileNumber) async {
    try {
      isLoading = true;
      notifyListeners();

      responseModel =
      await _service.checkFirmByMobile(mobileNumber: mobileNumber);

      return responseModel;
    } catch (e) {
      print("ViewModel Error: $e");
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}