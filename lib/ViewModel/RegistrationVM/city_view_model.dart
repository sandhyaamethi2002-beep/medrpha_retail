import 'package:get/get.dart';
import '../../AppManager/Services/RegistrationS/city_service.dart';
import '../../Model/RegistrationM/city_model.dart';

class CityViewModel extends GetxController {
  var cityList = <CityModel>[].obs;
  var selectedCity = Rxn<CityModel>();
  var isCityLoading = false.obs;

  Future<void> fetchCities(int stateId) async {
    try {
      isCityLoading.value = true;
      selectedCity.value = null;
      cityList.clear();

      final cities = await CityService.getCityByState(stateId);

      cityList.assignAll(cities);
    } finally {
      isCityLoading.value = false;
    }
  }

  void onCitySelected(CityModel? city) {
    selectedCity.value = city;
  }
}
