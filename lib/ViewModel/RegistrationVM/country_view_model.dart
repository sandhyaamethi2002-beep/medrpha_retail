import 'package:flutter/material.dart';

import '../../AppManager/Services/RegistrationS/country_service.dart';
import '../../Model/RegistrationM/country_model.dart';


class CountryViewModel extends ChangeNotifier {
  final CountryService _service = CountryService();

  List<Country> countries = [];
  bool isLoading = false;

  Future<void> fetchCountries() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getCountries();

    if (response != null && response.success) {
      countries = response.data;
    }

    isLoading = false;
    notifyListeners();
  }
}
