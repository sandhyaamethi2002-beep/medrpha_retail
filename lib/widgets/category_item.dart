import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Product_Categories/product_screen.dart';

class CategoryItem extends StatelessWidget {
  final String imgPath;
  final String title;
  final Color bgColor;
  final int categoryId;

  const CategoryItem({
    super.key,
    required this.imgPath,
    required this.title,
    required this.bgColor,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductScreen(
              title: title,
              categoryId: categoryId,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgPath,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}