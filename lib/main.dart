import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha/Provider/cart_provider.dart';
import 'package:medrpha/Screen/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controllers/user_controller.dart';
import 'Provider/order_provider.dart';
import 'Provider/wishlist_provider.dart';
import 'Screen/home_page.dart';
import 'ViewModel/AccountVM/getfirmbyid_view_model.dart';
import 'ViewModel/AccountVM/getfirmdetail_view_model.dart';
import 'ViewModel/AddtoCart/DeleteCartById_vm.dart';
import 'ViewModel/AddtoCart/GetCartByFirmId_vm.dart';
import 'ViewModel/AddtoCart/GetCartDetailsByFirmId_view_model.dart';
import 'ViewModel/AddtoCart/addtocart_view_model.dart';
import 'ViewModel/AddtoCart/getcardtotal_view_model.dart';
import 'ViewModel/AddtoCart/placeorder_view_model.dart';
import 'ViewModel/CategoryVM/GetByCategory_vm.dart';
import 'ViewModel/CategoryVM/getcategory_view_model.dart';
import 'ViewModel/CategoryVM/getproductdetail_view_model.dart';
import 'ViewModel/OrderVM/GetOrderDetails_vm.dart';
import 'ViewModel/OrderVM/GetOrderInvoice_vm.dart';
import 'ViewModel/OrderVM/GetOrdersByFirm_vm.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  final userController = Get.put(UserController(), permanent: true);

  int savedFirmId = prefs.getInt('firmId') ?? 0;
  String savedMobile = prefs.getString('phoneNo') ?? "";

  userController.firmId.value = savedFirmId;
  userController.mobileNo.value = savedMobile;

  print("===== APP START DATA =====");
  print("FirmId in Memory: $savedFirmId");
  print("Mobile in Memory: $savedMobile");

  String initialRoute = (savedFirmId != userController.firmId) ? '/home' : '/login';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryDetailViewModel()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => GetCategoryViewModel()),
        ChangeNotifierProvider(create: (_) => GetProductDetailViewModel()),
        ChangeNotifierProvider(create: (_) => AddToCartViewModel()),
        ChangeNotifierProvider(create: (_) => GetCartTotalViewModel()),
        ChangeNotifierProvider(create: (_) => GetCartDetailsByFirmIdViewModel()),
        ChangeNotifierProvider(create: (_) => PlaceOrderViewModel()),
        ChangeNotifierProvider(create: (_) => GetFirmByIdViewModel()),
        ChangeNotifierProvider(create: (_) => GetFirmDetailViewModel()),
        ChangeNotifierProvider(create: (_) => GetCartByFirmIdViewModel()),
        ChangeNotifierProvider(create: (_) => GetOrdersByFirmViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteCartByIdViewModel()),
        ChangeNotifierProvider(create: (_) => GetOrderDetailsVM()),
        ChangeNotifierProvider(create: (_) => GetOrderInvoiceVM()),

      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medrpha Retailer',
        initialRoute: initialRoute,
        getPages: [
          GetPage(
            name: '/login',
            page: () => const SendLoginView(),
          ),
          GetPage(
            name: '/home',
            page: () => HomePage(
              selectedIndex: 0,
              mobileNumber: Get.find<UserController>().mobileNo.value,
            ),
          ),
        ],
      ),
    );
  }
}