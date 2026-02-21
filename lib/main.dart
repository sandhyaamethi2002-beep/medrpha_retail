import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrpha/Provider/cart_provider.dart';
import 'package:medrpha/Screen/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/order_provider.dart';
import 'Provider/wishlist_provider.dart';
import 'Screen/home_page.dart';
import 'ViewModel/CategoryVM/category_detail_view_model.dart';
import 'ViewModel/CategoryVM/getcategory_view_model.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  final prefs = await SharedPreferences.getInstance();
  String? mobile = prefs.getString('mobile_number');

  print("App Start Mobile: $mobile");

  String initialRoute = (mobile != null && mobile.isNotEmpty) ? '/home' : '/login';

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
        // ChangeNotifierProvider(create: (_) => GetProductDetailViewModel()),
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
          GetPage(name: '/home',
              page: () => const HomePage(mobileNumber: null, selectedIndex: 0),
          )
        ],
      ),
    );
  }
}
