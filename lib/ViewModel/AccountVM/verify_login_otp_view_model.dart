import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../AppManager/Services/AccountS/verify_login_otp_service.dart';
import '../../Controllers/user_controller.dart';
import '../../Model/AccountM/verify_login_otp_model.dart';
import '../../Screen/home_page.dart'; // Apna home page path dein
import 'getfirmbyid_view_model.dart';

class VerifyLoginOtpViewModel extends ChangeNotifier {
  final VerifyLoginOtpService _service = VerifyLoginOtpService();

  bool isLoading = false;
  VerifyLoginOtpModel? verifyOtpResponse;

  Future<VerifyLoginOtpModel> verifyOtp({
    required String mobileNumber,
    required String otp,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      verifyOtpResponse = await _service.verifyLoginOtp(
        mobileNumber: mobileNumber,
        otp: otp,
      );

      if (verifyOtpResponse != null && verifyOtpResponse!.status == true) {

        final userController = Get.find<UserController>();

        if (verifyOtpResponse!.data != null) {
          await userController.saveUser(verifyOtpResponse!.data!);

          print(" Login Success for Firm ID: ${userController.firmId.value}");

          final firmVM = Provider.of<GetFirmByIdViewModel>(context, listen: false);
          await firmVM.fetchFirm(userController.firmId.value);

          Get.offAll(() => HomePage(
            mobileNumber: userController.mobileNo.value,
            selectedIndex: 0,
          ));
        }
      }

      return verifyOtpResponse!;
    } catch (e) {
      print(" VerifyOtp Error: $e");
      return VerifyLoginOtpModel(
        status: false,
        message: "Error: $e",
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}