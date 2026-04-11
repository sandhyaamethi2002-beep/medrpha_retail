import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/CategoryVM/GetByCategory_vm.dart';

class CategoryDetailView extends StatefulWidget {
  final int categoryId;
  final String title;

  const CategoryDetailView({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CategoryDetailViewModel>().fetchCategoryDetail(widget.categoryId);
    });
  }

  String _getImageUrl(String? productImg) {
    if (productImg == null || productImg.isEmpty) {
      return "https://via.placeholder.com/150";
    }

    if (productImg.startsWith("http")) return productImg;

    return "https://via.placeholder.com/150";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          widget.title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Consumer<CategoryDetailViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                vm.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (vm.products.isEmpty) {
            return const Center(child: Text("No Products Found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: vm.products.length,
            itemBuilder: (context, index) {
              final item = vm.products[index];

            },
          );
        },
      ),
    );
  }
}
