import 'package:get/get.dart';
import '../../AppManager/Services/RegistrationS/pincode_service.dart';
import '../../Model/RegistrationM/pincode_model.dart';

class PincodeViewModel extends GetxController {

  final PincodeService _service = PincodeService();

  var pincodeList = <PincodeModel>[].obs;
  var selectedPincode = Rxn<PincodeModel>();
  var isLoading = false.obs;

  Future<void> fetchPincode(int cityId) async {
    try {
      isLoading.value = true;

      print("Fetching Pincode for City ID: $cityId");

      final result = await _service.getPincodeByCity(cityId);

      print("Pincode API Result Length: ${result.length}");

      selectedPincode.value = null;

      pincodeList.assignAll(result);

    } catch (e) {
      print("Pincode Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onPincodeSelected(PincodeModel? pincode) {
    selectedPincode.value = pincode;
    print("Selected Pincode: ${pincode?.areaName}");
  }
}