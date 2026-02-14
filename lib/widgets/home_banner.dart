import 'package:flutter/material.dart';
import 'package:medrpha/widgets/register_screen.dart';


class HomeBanner extends StatelessWidget {
  final dynamic mobileNumber;

  const HomeBanner({super.key, required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffdff3f8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffdff3f8), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "MEDRPHA",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00a9e0),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "India's Genuine B2B Platform For Medicines",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "A WIDE VARIETY OF QUALITY\nHEALTHCARE PRODUCTS",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff00a9e0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        // RegisterUser(mobileNumber: mobileNumber),
                        RegisterScreen(mobileNumber: mobileNumber),
                      ),
                    );
                  },
                  child: const Text(
                    "Register Now",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Column(
            children: [
              Image(
                image: AssetImage('assets/banner_img/banner_2.png'),
                height: 80,
                width: 80,
              ),
            ],
          )
        ],
      ),
    );
  }
}