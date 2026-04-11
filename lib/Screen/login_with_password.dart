import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ViewModel/AccountVM/loginwithpassword_view_model.dart';
import 'home_page.dart';

class LoginWithPassword extends StatefulWidget {
  const LoginWithPassword({super.key});

  @override
  State<LoginWithPassword> createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState(){
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? mobile = prefs.getString('mobile_number');

    print("Saved Mobile on Login Page: $mobile");

    if (mobile != null && mobile.isNotEmpty) {
      if (!mounted) return;

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage(mobileNumber: mobile, selectedIndex: 0),
      ),
      );
    }
  }

  void login(BuildContext context) async {
    String mobile = mobileController.text.trim();
    String password = passwordController.text.trim();

    if (mobile.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 10-digit mobile number")),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your password")),
      );
      return;
    }

    final viewModel = Provider.of<LoginWithPasswordViewModel>(context, listen: false);
    bool success = await viewModel.login(mobile, password);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(viewModel.message)),
    );

    if (success) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('mobile_number', mobile);

      print("Mobile Saved After Login: $mobile");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(selectedIndex: 0, mobileNumber: mobile),
        ),
      );
    }
  }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => LoginWithPasswordViewModel(),
      child: Consumer<LoginWithPasswordViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    Image.asset(
                      'assets/images/img.png',
                      fit: BoxFit.contain,
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Login",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Enter your mobile number and password",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(height: 40),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Mobile Number", style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
                        counterText: "",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: viewModel.isLoading ? null : () => login(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: viewModel.isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                            : const Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}