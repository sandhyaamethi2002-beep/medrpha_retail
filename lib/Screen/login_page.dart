import 'package:flutter/material.dart';
import 'package:medrpha/Screen/login_with_password.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Screen/otp_verification.dart';
import '../../ViewModel/AccountVM/send_login_view_model.dart';
import '../../ViewModel/AccountVM/checkfirmbymobile_view_model.dart';

class SendLoginView extends StatefulWidget {
  const SendLoginView({super.key});

  @override
  State<SendLoginView> createState() => _SendLoginViewState();
}

class _SendLoginViewState extends State<SendLoginView> {
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  Future<void> saveLoginData(String mobile, String otp) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('mobile_number', mobile);
    await prefs.setString('otp', otp);

    print("Saved Mobile: $mobile");
    print("Saved OTP: $otp");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SendLoginViewModel()),
        ChangeNotifierProvider(create: (_) => CheckFirmByMobileViewModel()),
      ],
      child: Consumer2<SendLoginViewModel, CheckFirmByMobileViewModel>(
        builder: (context, vm, checkFirmVM, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      SizedBox(height: size.height * 0.02),

                      Image.asset(
                        'assets/images/img.png',
                        height: 130,
                        width: 130,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Enter your 10-digit mobile number to receive the verification code.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 30),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mobile Number",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: "Enter Mobile Number",
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter mobile number";
                          } else if (value.length != 10) {
                            return "Please enter 10 digit mobile number";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginWithPassword(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            "Login With Password",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: vm.isLoading
                              ? null
                              : () async {

                            if (_formKey.currentState!.validate()) {

                              String mobile = mobileController.text.trim();

                              final checkFirm =
                              await checkFirmVM.checkFirm(mobile);

                              if (checkFirm == null || checkFirm.success != true) {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Firm not found")),
                                );
                                return;
                              }

                              int firmId = checkFirm.firmId ?? 0;

                              print("Correct FirmId From API: $firmId");

                              final ok = await vm.sendOtp(mobile);

                              if (ok) {

                                await saveLoginData(
                                  mobile,
                                  vm.responseModel?.otp ?? "",
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpVerification(
                                      mobileNumber: mobile,
                                      otp: vm.responseModel?.otp ?? "",
                                      firmId: firmId,
                                    ),
                                  ),
                                );

                              } else {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      vm.errorMessage.isNotEmpty
                                          ? vm.errorMessage
                                          : "OTP Failed",
                                    ),
                                  ),
                                );

                              }
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),

                          child: vm.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            "Get Verification Code (OTP)",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}