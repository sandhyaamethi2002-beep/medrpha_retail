import 'package:flutter/material.dart';

void showAddAddressBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const AddAddressWidget(),
  );
}

class AddAddressWidget extends StatefulWidget {
  const AddAddressWidget({super.key});

  @override
  State<AddAddressWidget> createState() => _AddAddressWidgetState();
}

class _AddAddressWidgetState extends State<AddAddressWidget> {
  String selectedType = "Home";

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10, top: 15),
            child: _buildHeader(context),
          ),
          const Divider(),

          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: keyboardHeight + 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select address type", style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _typeChip(Icons.add, "Other"),
                      _typeChip(Icons.home, "Home"),
                      _typeChip(Icons.work, "Office"),
                    ],
                  ),
                  const SizedBox(height: 25),
                  _buildTextField("Receiver's name *", ""),
                  _buildTextField("Complete address *", ""),
                  _buildTextField("Nearby Landmark (optional)", ""),
                  _buildTextField("Mobile Number *", ""),
                  const SizedBox(height: 10),
                  _buildSaveButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Address details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        )
      ],
    );
  }

  Widget _typeChip(IconData icon, String label) {
    bool isSelected = selectedType == label;
    return GestureDetector(
      onTap: () => setState(() => selectedType = label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.blue : Colors.grey),
            if (label != "Other") ...[
              const SizedBox(width: 5),
              Text(label, style: TextStyle(
                color: isSelected ? Colors.blue : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        initialValue: initialValue,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: const Text("Save address",
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}