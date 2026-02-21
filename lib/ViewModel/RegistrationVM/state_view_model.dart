import 'package:get/get.dart';
import '../../AppManager/Services/RegistrationS/state_service.dart';
import '../../Model/RegistrationM/state_model.dart';

class StateViewModel extends GetxController {
  var stateList = <StateModel>[].obs;
  var isStateLoading = false.obs;
  var selectedState = Rxn<StateModel>();

  Future<void> fetchStates(int countryId) async {
    try {
      isStateLoading.value = true;
      final states = await StateService.getStatesByCountry(countryId);
      stateList.assignAll(states);
    } catch (e) {
      print("State Fetch Error: $e");
    } finally {
      isStateLoading.value = false;
    }
  }
}
