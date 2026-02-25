import 'package:flutter/material.dart';

import '../../AppManager/Services/AccountS/getfirmdetail_service.dart';
import '../../Model/AccountM/getfirmbyid_model.dart';


class GetFirmDetailViewModel extends ChangeNotifier {
  final GetFirmDetailService _service = GetFirmDetailService();

  bool isLoading = false;
  FirmData? firmData;

  Future<void> fetchFirm(int firmId) async {
    isLoading = true;
    notifyListeners();

    final result = await _service.getFirmDetail(firmId);

    if (result != null && result.success) {
      firmData = result.data as FirmData?;
    }

    isLoading = false;
    notifyListeners();
  }
}