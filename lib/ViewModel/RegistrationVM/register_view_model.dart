import 'package:get/get.dart';
import '../../AppManager/Services/RegistrationS/register_service.dart';
import '../../Model/RegistrationM/pincode_model.dart';
import '../../Model/RegistrationM/register_model.dart';
import '../../Model/RegistrationM/country_model.dart';
import '../../Model/RegistrationM/state_model.dart';
import '../../Model/RegistrationM/city_model.dart';

class RegisterViewModel extends GetxController {

  final RegisterService _service = RegisterService();

  RxBool isLoading = false.obs;


  // ================= REGISTER =================
  Future<bool> register(RegisterRequestModel model) async {
    try {
      isLoading.value = true;
      return await _service.registerFirm(model);
    } catch (e) {
      print("Register Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ================= COUNTRY =================
  Future<List<Country>> getCountries() async {
    try {
      return await _service.getCountries();
    } catch (e) {
      print("Country API Error: $e");
      return [];
    }
  }

  // ================= STATE =================
  Future<List<StateModel>> getStates(int countryId) async {
    try {
      return await _service.getStates(countryId);
    } catch (e) {
      print("State API Error: $e");
      return [];
    }
  }

  // ================= CITY =================
  Future<List<CityModel>> getCities(int stateId) async {
    try {
      return await _service.getCities(stateId);
    } catch (e) {
      print("City API Error: $e");
      return [];
    }
  }

  // ================= PINCODES =================
  Future<List<PincodeModel>> getPincodes(int cityId) async {
    try {
      return await _service.getPincodes(cityId);
    } catch (e) {
      print("Pincode API Error: $e");
      return [];
    }
  }
}