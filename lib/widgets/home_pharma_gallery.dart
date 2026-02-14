import 'package:flutter/material.dart';

class HomePharmaGallery extends StatelessWidget {
  const HomePharmaGallery({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> items = [
      {
        "img": "assets/products/Alka-Seltzer Original Effervescent.jpg",
        "title": "Alka-Seltzer Original Effervescent"
      },
      {"img": "assets/products/Garden of Life RAW.jpg", "title": "Garden of Life RAW"},
      {
        "img": "assets/products/Herb Pharm Stone Breaker Compound.jpg",
        "title": "Herb Pharm Stone Breaker Compound"
      },
      {
        "img": "assets/products/Himalaya Herbal Healthcare Comfort.jpg",
        "title": "Himalaya Herbal Healthcare Comfort"
      },
      {"img": "assets/products/Hyland's Bioplasma Tablets.jpg", "title": "Hyland's Bioplasma Tablets"},
      {"img": "assets/products/Natrol Biotin 10000 MCG Tablets.jpg", "title": "Natrol Biotin 10000 MCG Tablets"},
      {
        "img": "assets/products/Nature's Way Umcka Original Alcohol Free.jpg",
        "title": "Nature's Way Umcka Original Alcohol Free"
      },
      {"img": "assets/products/Nature Made Vitamin.jpg", "title": "Nature Made Vitamin"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Our Pharma Gallery",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, index) =>
            const SizedBox(width: 20),
            itemBuilder: (context, index) {
              return _buildGalleryItem(
                items[index]["img"]!,
                items[index]["title"]!,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGalleryItem(String imgPath, String title) {
    return Container(
      width: 140,
      height: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade50, width: 2),
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
            height: 80,
            width: 80,
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
    );
  }
}
