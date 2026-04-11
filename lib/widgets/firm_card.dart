import 'package:flutter/material.dart';
import 'firm_detail_card.dart';

class FirmCard extends StatelessWidget {
  final String firmName;
  final String firmId;
  final String? city;
  final String? phone;
  final dynamic fullData;

  const FirmCard({
    super.key,
    required this.firmName,
    required this.firmId,
    this.city,
    this.phone,
    this.fullData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FirmDetailCard.show(context, fullData);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(14, 12, 14, 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(color: Colors.blue.shade700, width: 4),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firmName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      _infoText("ID: $firmId"),
                      _dotDivider(),
                      _infoText(city ?? "N/A"),
                      if (phone != null) ...[
                        _dotDivider(),
                        _infoText(phone!),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _infoText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12),
    );
  }

  Widget _dotDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.circle, size: 3),
    );
  }
}