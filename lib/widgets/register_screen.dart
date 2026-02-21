import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/register_controller.dart';
import 'Register/step_widgets.dart';

class RegisterScreen extends StatefulWidget {
  final String? mobileNumber;

  const RegisterScreen({
    super.key,
    required this.mobileNumber,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  late final RegisterController controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<RegisterController>()) {
      controller = Get.find<RegisterController>();
    } else {
      controller = Get.put(RegisterController());
    }

    controller.phoneController.text = widget.mobileNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Registration",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Obx(() {
              int step = controller.currentStep.value;

              return Column(
                children: [

                  Row(
                    children: List.generate(
                      4,
                          (index) => _buildTab(
                        index,
                        ["Personal", "Firm", "Address", "Other"][index],
                        step,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _getStepWidget(step),
                          const SizedBox(height: 25),
                          _buildNavigationButtons(step),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _getStepWidget(int step) {
    switch (step) {
      case 0:
        return PersonalStep(controller: controller);
      case 1:
        return FirmStep(controller: controller);
      case 2:
        return AddressStep(controller: controller);
      case 3:
        return OtherStep(controller: controller);
      default:
        return const SizedBox();
    }
  }

  Widget _buildTab(int index, String title, int step) {
    bool isActive = step == index;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(int step) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        _navButton(
          "Previous",
          step == 0 ? null : () => controller.previousStep(),
          isPrimary: false,
        ),

        _navButton(
          step == 3 ? "Finish" : "Next",
              () {
            if (_formKey.currentState!.validate()) {

              if (step == 3) {

                if (!controller.isAgreed.value) {
                  Get.snackbar(
                    "Terms Required",
                    "Please agree to Terms & Conditions",
                    backgroundColor: Colors.orange,
                    colorText: Colors.white,
                  );
                  return;
                }

                controller.submitRegistration();
              } else {
                controller.nextStep();
              }
            }
          },
          isPrimary: true,
        ),
      ],
    );
  }

  Widget _navButton(
      String label,
      VoidCallback? onPressed, {
        required bool isPrimary,
      }) {

    bool isDisabled = onPressed == null;

    return SizedBox(
      width: 120,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
          isDisabled ? Colors.grey.shade400 : Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: isDisabled ? 0 : 2,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
