import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/CategoryVM/getcategory_view_model.dart';
import 'category_item.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({super.key});

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<GetCategoryViewModel>(context, listen: false)
            .getCategories());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GetCategoryViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        viewModel.isLoading
            ? const Center(child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ))
            : viewModel.categories.isEmpty
            ? const Center(child: Text("No Categories Found"))
            : GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final category = viewModel.categories[index];

            return CategoryItem(
              imgPath: getCategoryImage(category.categoryName ?? ""),
              title: (category.categoryName ?? "N/A").toUpperCase(),
              bgColor: getCategoryColor(index),
              categoryId: category.catId ?? 0,
            );
          },
        ),
      ],
    );
  }

  String getCategoryImage(String name) {
    switch (name.toLowerCase()) {
      case "ethical":
        return 'assets/products_img/ethical.png';
      case "generic":
        return 'assets/products_img/generic.png';
      case "surgical":
        return 'assets/products_img/surgical.png';
      case "veterinary":
        return 'assets/products_img/veterinary.png';
      case "ayurvedic":
        return 'assets/products_img/ayurvedic.png';
      case "general":
        return 'assets/products_img/general.png';
      default:
        return 'assets/products_img/general.png';
    }
  }

  Color getCategoryColor(int index) {
    List<Color> colors = [
      const Color(0xffE8F5E9),
      const Color(0xffF3E5F5),
      const Color(0xffFFEBEE),
      const Color(0xffFFFDE7),
      const Color(0xffE6F7FF),
      const Color(0xffF3E5F5),
    ];
    return colors[index % colors.length];
  }
}