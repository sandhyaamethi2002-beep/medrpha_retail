import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// --- Reusable Input Field ---
class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController ctr;
  final IconData icon;
  final bool isPass;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final int? maxLines;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.label,
    required this.ctr,
    required this.icon,
    this.isPass = false,
    this.readOnly = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: ctr,
        readOnly: readOnly,
        onTap: onTap,
        obscureText: isPass,
        keyboardType: keyboardType,
        maxLines: isPass ? 1 : maxLines,
        minLines: 1,
        validator: validator ?? (value) => value!.isEmpty ? "This field is required" : null,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade800, fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.blue.shade400, size: 22),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
        ),
      ),
    );
  }
}

// --- Upload Field ---
class UploadField extends StatelessWidget {
  final String label;
  final RxString fileName;
  final VoidCallback onTap;

  const UploadField({
    super.key,
    required this.label,
    required this.fileName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade600, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(CupertinoIcons.doc_text, color: Colors.blue.shade400, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                fileName.value.isEmpty ? label : fileName.value,
                style: TextStyle(
                  fontSize: 15,
                  color: fileName.value.isEmpty ? Colors.grey.shade800 : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(CupertinoIcons.cloud_upload, color: Colors.blue),
          ],
        ),
      ),
    ));
  }
}