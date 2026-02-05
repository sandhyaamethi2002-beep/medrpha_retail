import 'package:flutter/material.dart';
import 'package:medrpha/Screen/home_page.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.blue;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        titleSpacing: 0,
        // leadingWidth: 50,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage(selectedIndex: 0)),
                  // (route) => false,
            );
          },
        ),

        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              color: primaryColor,
            ),

            // Profile card (overlapping)
            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: primaryColor,
                        child: const Text(
                          "A",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "User",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "1234567890",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "abc@gmail.com",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Icon(color: Colors.black87, CupertinoIcons.pencil),
                    ],
                  ),
                ),
              ),
            ),


            const SizedBox(height: 10),

            // List items


            _menuTile(
              icon: CupertinoIcons.phone,
              title: "Phone",
              subtitle: "1234567890",
              onTap: () {},
            ),
            _menuTile(
              icon: CupertinoIcons.home,
              title: "Address",
              subtitle: "123, Flutter Lane, Dart Ville",
              onTap: () {},
            ),
            _menuTile(
              icon: CupertinoIcons.bell,
              title: "Notification",
              subtitle: "All Notification",
              onTap: () {},
            ),
            _menuTile(
              icon: CupertinoIcons.bookmark,
              title: "Saved Items",
              subtitle: "Saved items here",
              onTap: () {},
            ),
            _menuTile(
              icon: CupertinoIcons.square_arrow_left,
              title: "Logout",
              subtitle: "",
              onTap: () {},
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  static Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black54),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        Divider(height: 1, color: Colors.grey.shade300),
      ],
    );
  }

  static Widget _bottomItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: active ? const Color(0xFFFF6A00) : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: active ? const Color(0xFFFF6A00) : Colors.grey,
          ),
        )
      ],
    );
  }
}

