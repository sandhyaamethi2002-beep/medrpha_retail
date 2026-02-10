import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CountryStateCityWidget extends StatefulWidget {
  final Function(String country, String state, String city) onChanged;

  const CountryStateCityWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<CountryStateCityWidget> createState() =>
      _CountryStateCityWidgetState();
}

class _CountryStateCityWidgetState extends State<CountryStateCityWidget> {
  final List<Country> countryList = CountryService().getAll();

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  List<csc.State> stateList = [];
  List<csc.City> cityList = [];

  bool isLoadingStates = false;
  bool isLoadingCities = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// ---------------- COUNTRY ----------------
        DropdownSearch<Country>(
          items: countryList,
          itemAsString: (c) => "${c.flagEmoji} ${c.name}",
          selectedItem: selectedCountry != null
              ? countryList.firstWhere((c) => c.name == selectedCountry)
              : null,
          popupProps: const PopupProps.menu(showSearchBox: true),
          dropdownDecoratorProps: _decoration(
              "Country *", CupertinoIcons.globe),
          validator: (value) =>
          value == null ? "Country is required" : null,
          onChanged: (Country? country) async {
            if (country == null) return;

            setState(() {
              selectedCountry = country.name;
              selectedState = null;
              selectedCity = null;
              stateList = [];
              cityList = [];
              isLoadingStates = true;
            });

            final states =
            await csc.getStatesOfCountry(country.countryCode);

            setState(() {
              stateList = states;
              isLoadingStates = false;
            });

            _notifyParent();
          },
        ),

        const SizedBox(height: 15),

        /// ---------------- STATE ----------------
        if (isLoadingStates)
          const CircularProgressIndicator()
        else
          DropdownSearch<csc.State>(
            items: stateList,
            itemAsString: (s) => s.name,
            selectedItem: selectedState != null
                ? stateList.firstWhere((s) => s.name == selectedState)
                : null,
            popupProps: const PopupProps.menu(showSearchBox: true),
            dropdownDecoratorProps: _decoration(
                "State *", CupertinoIcons.map_pin_ellipse),
            validator: (value) =>
            value == null ? "State is required" : null,
            onChanged: (csc.State? state) async {
              if (state == null) return;

              setState(() {
                selectedState = state.name;
                selectedCity = null;
                cityList = [];
                isLoadingCities = true;
              });

              final cities = await csc.getStateCities(
                  state.countryCode, state.isoCode);

              setState(() {
                cityList = cities;
                isLoadingCities = false;
              });

              _notifyParent();
            },
          ),

        const SizedBox(height: 15),

        /// ---------------- CITY ----------------
        if (isLoadingCities)
          const CircularProgressIndicator()
        else
          DropdownSearch<csc.City>(
            items: cityList,
            itemAsString: (c) => c.name,
            selectedItem: selectedCity != null
                ? cityList.firstWhere((c) => c.name == selectedCity)
                : null,
            popupProps: const PopupProps.menu(showSearchBox: true),
            dropdownDecoratorProps: _decoration(
                "City *", CupertinoIcons.location_solid),
            validator: (value) =>
            value == null ? "City is required" : null,
            onChanged: (csc.City? city) {
              setState(() {
                selectedCity = city?.name;
              });

              _notifyParent();
            },
          ),
      ],
    );
  }

  /// Common Decoration
  DropDownDecoratorProps _decoration(String label, IconData icon) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        prefixIcon: Icon(icon, size: 20, color: Colors.blue),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          const BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  void _notifyParent() {
    if (selectedCountry != null &&
        selectedState != null &&
        selectedCity != null) {
      widget.onChanged(
          selectedCountry!, selectedState!, selectedCity!);
    }
  }
}
