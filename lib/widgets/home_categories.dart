import 'package:flutter/material.dart';
import '../Product_Categories/category_product.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Categories",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CategoryItem(
              imgPath: 'assets/products_img/ethical.png',
              title: "ETHICAL",
              bgColor: Color(0xffE8F5E9),
              categoryId: 1,
            ),
            CategoryItem(
              imgPath: 'assets/products_img/generic.png',
              title: "GENERIC",
              bgColor: Color(0xffF3E5F5),
              categoryId: 2,
            ),
            CategoryItem(
              imgPath: 'assets/products_img/surgical.png',
              title: "SURGICAL",
              bgColor: Color(0xffFFEBEE),
              categoryId: 3,
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CategoryItem(
              imgPath: 'assets/products_img/veterinary.png',
              title: "VETERINARY",
              bgColor: Color(0xffFFFDE7),
              categoryId: 4,
            ),
            CategoryItem(
              imgPath: 'assets/products_img/ayurvedic.png',
              title: "AYURVEDIC",
              bgColor: Color(0xffE6F7FF),
              categoryId: 5,
            ),
            CategoryItem(
              imgPath: 'assets/products_img/general.png',
              title: "GENERAL",
              bgColor: Color(0xffF3E5F5),
              categoryId: 6,
            ),
          ],
        ),
      ],
    );
  }
}

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
            builder: (_) => CategoryProduct(
              title: title,
              categoryId: categoryId,
            ),
          ),
        );
      },
      child: Container(
        width: 110,
        height: 150,
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
          children: [
            Image.asset(
              imgPath,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
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
