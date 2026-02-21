import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:medrpha/widgets/terms_condition_page.dart';
import 'package:medrpha/widgets/yes_no_dropdown.dart';
import '../../Controllers/register_controller.dart';
import '../../Model/RegistrationM/city_model.dart';
import '../../Model/RegistrationM/country_model.dart';
import '../../Model/RegistrationM/pincode_model.dart';
import '../../Model/RegistrationM/state_model.dart';
import 'custom_registration_widgets.dart';

/// ================= PERSONAL STEP =================
class PersonalStep extends StatelessWidget {
  final RegisterController controller;
  const PersonalStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
            label: "Name *",
            ctr: controller.nameController,
            icon: CupertinoIcons.person),
        CustomInputField(
            label: "Phone No. *",
            ctr: controller.phoneController,
            icon: CupertinoIcons.phone,
            keyboardType: TextInputType.phone),
        CustomInputField(
            label: "Email *",
            ctr: controller.emailController,
            icon: CupertinoIcons.mail,
            keyboardType: TextInputType.emailAddress),
        CustomInputField(
            label: "Password *",
            ctr: controller.passwordController,
            icon: CupertinoIcons.lock,
            isPass: true),
      ],
    );
  }
}

/// ================= FIRM STEP =================
class FirmStep extends StatelessWidget {
  final RegisterController controller;
  const FirmStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ================= GST =================
        YesNoDropdown(
          label: "GST No. *",
          selectedValue: controller.hasGST,
          icon: CupertinoIcons.doc_text,
          onChanged: () {},
          children: [
            CustomInputField(
              label: "GST Number *",
              ctr: controller.gstNoController,
              icon: CupertinoIcons.doc_text,
            ),
          ],
        ),

        /// ================= DRUG LICENCE =================
        YesNoDropdown(
          label: "Drugs Licence *",
          selectedValue: controller.hasDrugLicence,
          icon: CupertinoIcons.doc_text,
          onChanged: () {},
          children: [
            CustomInputField(
              label: "Drugs Licence Name *",
              ctr: controller.drugLicenceNameController,
              icon: CupertinoIcons.doc_text,
            ),
            CustomInputField(
              label: "Drugs Licence No. *",
              ctr: controller.drugLicenceNoController,
              icon: CupertinoIcons.doc_text,
            ),
            UploadField(
              label: "DL-1 *",
              fileName: controller.dl1FileName,
              onTap: () =>
                  controller.pickFile(controller.dl1Controller, controller.dl1FileName),
            ),
            UploadField(
              label: "DL-2 *",
              fileName: controller.dl2FileName,
              onTap: () =>
                  controller.pickFile(controller.dl2Controller, controller.dl2FileName),
            ),
          ],
        ),

        /// ================= FSSAI =================
        YesNoDropdown(
          label: "FSSAI *",
          selectedValue: controller.hasFSSAI,
          icon: CupertinoIcons.shield,
          onChanged: () {},
          children: [
            CustomInputField(
              label: "FSSAI No. *",
              ctr: controller.fssaiNoController,
              icon: CupertinoIcons.shield,
            ),
            UploadField(
              label: "FSSAI Image *",
              fileName: controller.fssaiFileName,
              onTap: () =>
                  controller.pickFile(controller.fssaiImageController, controller.fssaiFileName),
            ),
          ],
        ),
      ],
    );
  }
}

/// ================= ADDRESS STEP =================
class AddressStep extends StatelessWidget {
  final RegisterController controller;
  const AddressStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Country Dropdown
        Obx(() {
          if (controller.isCountryLoading.value) return const CircularProgressIndicator();
          return DropdownButtonFormField<Country>(
            value: controller.selectedCountry.value,
            decoration: const InputDecoration(
              labelText: "Country *",
              prefixIcon: Icon(CupertinoIcons.globe),
              border: OutlineInputBorder(),
            ),
            items: controller.countryList
                .map((country) => DropdownMenuItem(
                value: country, child: Text(country.countryName)))
                .toList(),
            onChanged: controller.onCountrySelected,
          );
        }),
        const SizedBox(height: 12),

        /// State Dropdown
        Obx(() {
          if (controller.isStateLoading.value) return const CircularProgressIndicator();
          return DropdownButtonFormField<StateModel>(
            value: controller.selectedState.value,
            decoration: const InputDecoration(
              labelText: "State *",
              prefixIcon: Icon(CupertinoIcons.map),
              border: OutlineInputBorder(),
            ),
            items: controller.stateList
                .map((state) =>
                DropdownMenuItem(value: state, child: Text(state.stateName)))
                .toList(),
            onChanged: controller.onStateSelected,
          );
        }),
        const SizedBox(height: 12),

        /// City Dropdown
        Obx(() {
          if (controller.isCityLoading.value) return const CircularProgressIndicator();
          return DropdownButtonFormField<CityModel>(
            value: controller.selectedCity.value,
            decoration: const InputDecoration(
              labelText: "City *",
              prefixIcon: Icon(CupertinoIcons.location_solid),
              border: OutlineInputBorder(),
            ),
            items: controller.cityList
                .map((city) =>
                DropdownMenuItem(value: city, child: Text(city.cityName)))
                .toList(),
            onChanged: controller.onCitySelected,
          );
        }),
        const SizedBox(height: 12),

        /// PinCode Dropdown
        Obx(() {
          if (controller.pincodeVM.isLoading.value)
            return const CircularProgressIndicator();
          return DropdownButtonFormField<PincodeModel>(
            isExpanded: true,
            menuMaxHeight: 400,
            value: controller.pincodeVM.selectedPincode.value,
            decoration: const InputDecoration(
              labelText: "Pin Code *",
              prefixIcon: Icon(CupertinoIcons.location),
              border: OutlineInputBorder(),
            ),
            items: controller.pincodeVM.pincodeList
                .map((pincode) => DropdownMenuItem(
                value: pincode, child: Text(pincode.areaName)))
                .toList(),
            onChanged: (value) {
              controller.pincodeVM.onPincodeSelected(value);
              controller.pinCodeController.text = value?.areaName ?? "";
            },
          );
        }),
        const SizedBox(height: 12),

        /// Address Input
        CustomInputField(
            label: "Address *",
            ctr: controller.addressController,
            icon: CupertinoIcons.house,
            maxLines: 3),
      ],
    );
  }
}

/// ================= OTHER STEP =================
class OtherStep extends StatelessWidget {
  final RegisterController controller;
  const OtherStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
            label: "Contact Person Name",
            ctr: controller.contactPersonNameController,
            icon: CupertinoIcons.person_crop_circle),
        CustomInputField(
            label: "Number",
            ctr: controller.contactNumberController,
            icon: CupertinoIcons.device_phone_portrait,
            keyboardType: TextInputType.phone),
        CustomInputField(
            label: "Alternate Number",
            ctr: controller.alternateNumberController,
            icon: CupertinoIcons.phone,
            keyboardType: TextInputType.phone),
        const SizedBox(height: 10),
        Obx(() => CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: controller.isAgreed.value,
          onChanged: (val) => controller.isAgreed.value = val!,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.blue,
          title: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black),
              children: [
                const TextSpan(text: "I agree with "),
                TextSpan(
                  text: "Terms and Conditions",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TermsConditionPage()));
                    },
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}