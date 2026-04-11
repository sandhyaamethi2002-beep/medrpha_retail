import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/user_controller.dart';
import '../../AppManager/Services/AccountS/getfirmbyid_service.dart';
import '../../Model/AccountM/getfirmbyid_model.dart';

class GetFirmByIdViewModel extends ChangeNotifier {
  final GetFirmByIdService _service = GetFirmByIdService();

  final UserController userController = Get.find<UserController>();

  bool isLoading = false;
  FirmData? firmData;

  Future<void> fetchFirm(int id) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getFirmById(id);

    if (response != null && response.success && response.data != null) {
      firmData = response.data;

      await userController.saveUser({
        'firmId': firmData?.firmId,
        'firmName': firmData?.firmName,
        'address': firmData?.address,
        'phoneNo': firmData?.phoneNo,
        'hdnDrugsyesno':firmData?.hdnDrugsyesno,
        'status': firmData?.status
      });

    }

    isLoading = false;
    notifyListeners();
  }
}