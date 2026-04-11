import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Controllers/user_controller.dart';
import '../ViewModel/CategoryVM/GetByCategory_vm.dart';
import '../ViewModel/CategoryVM/getproductdetail_view_model.dart';
import '../widgets/product_card.dart';
import '../widgets/product_card2.dart';

class ProductScreen extends StatefulWidget {
  final String title;
  final int categoryId;

  const ProductScreen({
    super.key,
    required this.title,
    required this.categoryId,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    bool isVerified = userController.drugLicence.value == 1 &&
        userController.status.value == 1;

    Future.microtask(() {
      if (isVerified) {
        context.read<GetProductDetailViewModel>().getProducts(widget.categoryId);
      } else {
        context.read<CategoryDetailViewModel>().fetchCategoryDetail(widget.categoryId);
      }
    });
  }

  String _getImageUrl(String? productImg) {
    if (productImg == null || productImg.isEmpty) return "https://via.placeholder.com/150";
    if (productImg.startsWith("http")) return productImg;
    return "https://retailer.medrpha.com/images/$productImg";
  }

  @override
  Widget build(BuildContext context) {
    bool isVerified = userController.drugLicence.value == 1 &&
        userController.status.value == 1;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: isVerified ? _buildVerifiedBody() : _buildUnverifiedBody(),
    );
  }

  // --- CASE 1: VERIFIED USER (Detailed API) ---
  Widget _buildVerifiedBody() {
    return Consumer<GetProductDetailViewModel>(
      builder: (context, vm, child) {
        if (vm.isLoading) return const Center(child: CircularProgressIndicator());

        if (vm.errorMessage.isNotEmpty) {
          return Center(child: Text(vm.errorMessage, style: const TextStyle(color: Colors.red)));
        }

        if (vm.productList.isEmpty) {
          return const Center(child: Text("No Products Found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: vm.productList.length,
          itemBuilder: (context, index) {
            final item = vm.productList[index];
            return ProductCard(
              imageUrl: _getImageUrl(item.productImg),
              productsname: item.productName,
              status: item.productType,
              available: item.companyName,
              price: item.finalCompanyPrice,
              mrp: item.mrp,
              discountPercentage: item.discountPercentage,
              minQuantity: (item.minOrderQty == 0) ? 1 : item.minOrderQty,
              availableQty: (item.availableQuantity == 0) ? 1000 : item.availableQuantity,
              productId: item.pid ?? 0,
              priceId: item.priceId ?? 0,
            );
          },
        );
      },
    );
  }

  // --- CASE 2: UNVERIFIED USER (Basic GetByCategory API) ---
  Widget _buildUnverifiedBody() {
    return Consumer<CategoryDetailViewModel>(
      builder: (context, vm, child) {
        if (vm.isLoading) return const Center(child: CircularProgressIndicator());

        if (vm.errorMessage.isNotEmpty) {
          return Center(child: Text(vm.errorMessage, style: const TextStyle(color: Colors.red)));
        }

        if (vm.products.isEmpty) {
          return const Center(child: Text("No Products Found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: vm.products.length,
          itemBuilder: (context, index) {
            final item = vm.products[index];
            return ProductCard2(
              imageUrl: _getImageUrl(item.productImg),
              productName: item.productName ?? "N/A",
              companyName: item.companyName ?? "N/A",
            );
          },
        );
      },
    );
  }
}