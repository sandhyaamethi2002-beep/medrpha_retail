import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../Model/RegistrationM/country_model.dart';
import '../Model/RegistrationM/register_model.dart';
import '../Model/RegistrationM/state_model.dart';
import '../Model/RegistrationM/city_model.dart';
import '../Model/RegistrationM/pincode_model.dart';
import '../ViewModel/RegistrationVM/pincode_view_model.dart';
import '../ViewModel/RegistrationVM/register_view_model.dart';

class RegisterController extends GetxController {

  // ================= STEP =================
  RxInt currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < 3) currentStep.value++;
  }

  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  // ================= TEXT CONTROLLERS =================
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final gstNoController = TextEditingController();
  final drugLicenceNameController = TextEditingController();
  final drugLicenceNoController = TextEditingController();
  final validUptoController = TextEditingController();
  final fssaiNoController = TextEditingController();

  final dl1Controller = TextEditingController();
  final dl2Controller = TextEditingController();
  final fssaiImageController = TextEditingController();

  final addressController = TextEditingController();
  final pinCodeController = TextEditingController();

  final contactPersonNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final alternateNumberController = TextEditingController();

  // ================= FILE NAMES =================
  RxString dl1FileName = "".obs;
  RxString dl2FileName = "".obs;
  RxString fssaiFileName = "".obs;

  // ================= FLAGS =================
  RxString hasGST = "No".obs;
  RxString hasDrugLicence = "No".obs;
  RxString hasFSSAI = "No".obs;
  RxBool isAgreed = false.obs;

  // ================= DROPDOWNS =================
  RxList<Country> countryList = <Country>[].obs;
  RxList<StateModel> stateList = <StateModel>[].obs;
  RxList<CityModel> cityList = <CityModel>[].obs;

  Rx<Country?> selectedCountry = Rx<Country?>(null);
  Rx<StateModel?> selectedState = Rx<StateModel?>(null);
  Rx<CityModel?> selectedCity = Rx<CityModel?>(null);

  RxBool isCountryLoading = false.obs;
  RxBool isStateLoading = false.obs;
  RxBool isCityLoading = false.obs;

  // ================= VIEWMODELS =================
  final PincodeViewModel pincodeVM = Get.put(PincodeViewModel());
  final RegisterViewModel viewModel = Get.put(RegisterViewModel());

  // ================= INIT =================
  @override
  void onInit() {
    super.onInit();
    loadCountries();
  }

  // ================= COUNTRY =================
  Future<void> loadCountries() async {
    try {
      isCountryLoading.value = true;
      final data = await viewModel.getCountries();
      countryList.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", "Failed to load countries");
    } finally {
      isCountryLoading.value = false;
    }
  }

  void onCountrySelected(Country? value) {
    selectedCountry.value = value;

    if (value != null) {
      loadStates(value.countryId);
    }
  }

  // ================= STATE =================
  Future<void> loadStates(int countryId) async {
    try {
      isStateLoading.value = true;

      final data = await viewModel.getStates(countryId);

      print("Controller stateList length: ${data.length}");

      stateList.assignAll(data);

      selectedState.value = null;
      cityList.clear();

    } catch (e) {
      print("LoadStates ERROR: $e");
      Get.snackbar("Error", "Failed to load states");
    } finally {
      isStateLoading.value = false;
    }
  }

  void onStateSelected(StateModel? value) {
    selectedState.value = value;

    if (value != null) {
      loadCities(value.stateId);
    }
  }
  // ================= CITY =================
  Future<void> loadCities(int stateId) async {
    try {
      isCityLoading.value = true;
      final data = await viewModel.getCities(stateId);
      cityList.assignAll(data);

      selectedCity.value = null;
    } catch (e) {
      Get.snackbar("Error", "Failed to load cities");
    } finally {
      isCityLoading.value = false;
    }
  }

  void onCitySelected(CityModel? city) {
    selectedCity.value = city;

    pinCodeController.text = "";
    pincodeVM.selectedPincode.value = null;
    pincodeVM.pincodeList.clear();

    if(city != null){
      pincodeVM.fetchPincode(city.cityId);
    }
  }

  // ================= FILE PICKER =================
  Future<void> pickFile(
      TextEditingController controller,
      RxString fileName,
      ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      controller.text = result.files.single.path ?? "";
      fileName.value = result.files.single.name;
    }
  }

  // ================= SUBMIT =================
  Future<void> submitRegistration() async {

    final model = RegisterRequestModel(
      userTypeId: 979394,
      firmName: nameController.text.trim(),
      gstNo: gstNoController.text.trim(),
      valid: DateTime.now().toIso8601String(),
      phoneNo: phoneController.text.trim(),
      dl1: dl1Controller.text,
      dl2: dl2Controller.text,
      pic3: fssaiImageController.text,
      address: addressController.text.trim(),
      registerDate: DateTime.now().toIso8601String(),
      payLateStatus: 1,
      email: emailController.text.trim(),
      postalCode: pinCodeController.text.trim(),
      dlNo: drugLicenceNoController.text.trim(),
      adminId: 6798,
      completeRegStatus: 1,
      countryId: selectedCountry.value?.countryId ?? 1,
      stateId: selectedState.value?.stateId ?? 1,
      cityId: selectedCity.value?.cityId ?? 1,
      regionalId: 1,
      areaId: pincodeVM.selectedPincode.value?.areaid ?? 1,
      status: 1,
      dlName: drugLicenceNameController.text.trim(),
      fssaiNo: fssaiNoController.text.trim(),
      personName: contactPersonNameController.text.trim(),
      personNumber: contactNumberController.text.trim(),
      alternateNumber: alternateNumberController.text.trim(),
      hdnDrugYesNo: hasDrugLicence.value == "Yes" ? 1 : 0,
      hdnFSSAI: hasFSSAI.value == "Yes" ? 1 : 0,
      gstNoYesNo: hasGST.value == "Yes" ? 1 : 0,
      mrid: 0,
      terms: isAgreed.value ? "1" : "0",
      firmPassword: passwordController.text.trim(),
      appStatus: 0,
      salePid: 0,
      salesExecutiveId: 0,
    );

    bool success = await viewModel.register(model);

    if (success) {
      Get.snackbar(
        "Success",
        "Firm added successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Registration Failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // ================= DISPOSE =================
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}