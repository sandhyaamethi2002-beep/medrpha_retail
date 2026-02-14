import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medrpha/Screen/profile_page.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_provider.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_categories.dart';
import '../widgets/home_new_banner.dart';
import '../widgets/home_pharma_gallery.dart';
import 'cart_page.dart';
import 'my_order_page.dart';

class HomePage extends StatefulWidget {

  final dynamic mobileNumber;

  const HomePage({
    super.key,
    required this.mobileNumber, required int selectedIndex,
  });


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();
  // final GlobalKey _categoriesKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget homeScreen() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            HomeBanner(mobileNumber: widget.mobileNumber),

            const SizedBox(height: 10),

            const HomeNewBanner(),
            // buildVerticalCard(
            //   CupertinoIcons.shopping_cart,
            //   "Start Ordering Now",
            //   "Browse and order products for your shop from top sellers",
            // ),

            const SizedBox(height: 16),

            const HomeCategories(),

            const SizedBox(height: 30),

            const HomePharmaGallery(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }

        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(

        appBar:(_selectedIndex == 2 || _selectedIndex == 3)
            ? null
          : AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(CupertinoIcons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // CART ICON WITH BADGE
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                int totalQty = cart.cartList.fold(
                    0, (sum, item) => sum + item.qty);

                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.shopping_cart,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CartPage(),
                          ),
                        );
                      },
                    ),

                    if (totalQty > 0)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '$totalQty',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),

      body: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: [
                homeScreen(),
                homeScreen(),
                const MyOrderPage(),
                const ProfilePage(mobileNumber: '',),
              ],
            ),

            // MINI CART BAR
            if (_selectedIndex == 0)
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {

                    if (cart.cartList.isEmpty) {
                      return const SizedBox();
                    }
                    int totalQty = cart.cartList.fold(
                      0,
                          (sum, item) => sum + item.qty,
                    );

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$totalQty items added",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),

                            const Text(
                              "View Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home, size: 24),
                activeIcon: Icon(CupertinoIcons.home, size: 26),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_grid_2x2,  size: 24),
                activeIcon: Icon(CupertinoIcons.square_grid_2x2,  size: 26),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cube_box,  size: 24),
                activeIcon: Icon(CupertinoIcons.cube_box,  size: 26),
                label: "My Order",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person, size: 24),
                activeIcon: Icon(CupertinoIcons.person, size: 26),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

