import 'package:flutter/material.dart';

import '../../AppManager/Services/AccountS/getfirmbyid_service.dart';
import '../../Model/AccountM/getfirmbyid_model.dart';

class GetFirmByIdViewModel extends ChangeNotifier {

  final GetFirmByIdService _service = GetFirmByIdService();

  bool isLoading = false;
  FirmData? firmData;

  Future<void> fetchFirm(int id) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getFirmById(id);

    if (response != null && response.success) {
      firmData = response.data;
    }

    isLoading = false;
    notifyListeners();
  }
}