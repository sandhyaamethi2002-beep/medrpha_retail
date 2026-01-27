import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medrpha/Screen/home_page.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpVerification> {
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();

  final otp1Focus = FocusNode();
  final otp2Focus = FocusNode();
  final otp3Focus = FocusNode();
  final otp4Focus = FocusNode();

  String generateOtp() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }

  void resendOtp() {
    String otp = generateOtp();
    debugPrint("Generated OTP: $otp");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("OTP resent successfully")),
    );
  }

  void verifyOtp() {
    String otp = otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text;

    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 4 digit OTP")),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage(selectedIndex: 0)),
    );
  }

  Widget otpBox({
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return SizedBox(
      width: 45,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.blue.shade200,
              width: 2,
            ),
          ),
        ),
        onChanged: (value) {
          // **Move to next box**
          if (value.length == 1) {
            if (focusNode == otp1Focus) {
              FocusScope.of(context).requestFocus(otp2Focus);
            } else if (focusNode == otp2Focus) {
              FocusScope.of(context).requestFocus(otp3Focus);
            } else if (focusNode == otp3Focus) {
              FocusScope.of(context).requestFocus(otp4Focus);
            } else {
              FocusScope.of(context).unfocus();
            }
          }

          // **Backspace -> move to previous box**
          if (value.isEmpty) {
            if (focusNode == otp2Focus) {
              FocusScope.of(context).requestFocus(otp1Focus);
            } else if (focusNode == otp3Focus) {
              FocusScope.of(context).requestFocus(otp2Focus);
            } else if (focusNode == otp4Focus) {
              FocusScope.of(context).requestFocus(otp3Focus);
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();

    otp1Focus.dispose();
    otp2Focus.dispose();
    otp3Focus.dispose();
    otp4Focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Verification"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.02),

              Image.asset(
                'assets/images/img.png',
                fit: BoxFit.contain,
                height: 130,
                width: 130,
              ),

              const SizedBox(height: 25),

              const Text(
                "Mobile Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Please enter the 4-digit verification code sent to your mobile number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter OTP",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  otpBox(controller: otp1Controller, focusNode: otp1Focus),
                  const SizedBox(width: 10),
                  otpBox(controller: otp2Controller, focusNode: otp2Focus),
                  const SizedBox(width: 10),
                  otpBox(controller: otp3Controller, focusNode: otp3Focus),
                  const SizedBox(width: 10),
                  otpBox(controller: otp4Controller, focusNode: otp4Focus),
                ],
              ),

              const SizedBox(height: 20),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Didn't receive the code? ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "Resend",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = resendOtp,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
