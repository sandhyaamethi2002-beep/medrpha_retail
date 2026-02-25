import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/AccountM/getfirmbyid_model.dart';

class FirmDetailCard {
  static void show(BuildContext context, FirmData? data) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(CupertinoIcons.briefcase_fill,
                            color: Colors.blue, size: 22),
                        SizedBox(width: 10),
                        Text(
                          "Firm Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(thickness: 1),
                ),

                _buildInfoRow(CupertinoIcons.house_fill,
                    "Firm Name", data?.firmName),

                _buildInfoRow(CupertinoIcons.number,
                    "Firm ID", "MED-${data?.firmId}"),

                _buildInfoRow(CupertinoIcons.device_phone_portrait,
                    "Mobile Number", data?.phoneNo),

                _buildInfoRow(CupertinoIcons.location_fill,
                    "Address", data?.address),

                _buildInfoRow(CupertinoIcons.map_pin_ellipse,
                    "City", data?.address),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildInfoRow(
      IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon,
                size: 18, color: Colors.blue.shade700),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value ?? "N/A",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}