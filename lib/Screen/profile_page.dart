import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:medrpha/Screen/about_us.dart';
import 'package:medrpha/Screen/home_page.dart';
import 'package:medrpha/Screen/logout_dialog.dart';
import 'package:medrpha/Screen/saved_item_page.dart';
import '../Controllers/user_controller.dart';
import '../ViewModel/AccountVM/getfirmbyid_view_model.dart';
import 'contact_us.dart';
import 'edit_profile_page.dart';
import 'my_order_page.dart';
import 'notification_page.dart';

class ProfilePage extends StatefulWidget {
  final String mobileNumber;

  const ProfilePage({super.key, required this.mobileNumber});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userController = Get.find<UserController>();
      int currentFirmId = userController.firmId.value;

      if (currentFirmId != 0) {
        Provider.of<GetFirmByIdViewModel>(context, listen: false)
            .fetchFirm(currentFirmId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.blue;
    final viewModel = Provider.of<GetFirmByIdViewModel>(context);
    final firm = viewModel.firmData;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(mobileNumber: widget.mobileNumber, selectedIndex: 0),
              ),
            );
          },
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              color: primaryColor,
            ),

            /// PROFILE CARD (DYNAMIC)
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
                        child: Text(
                          firm?.firmName != null ? firm!.firmName[0].toUpperCase() : "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              firm?.firmName ?? "No Name",
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(firm?.phoneNo ?? widget.mobileNumber,
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 2),
                            Text(firm?.email ?? "Email not provided",
                                style: const TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ),
                      // IconButton(
                      //     icon: const Icon(CupertinoIcons.pencil, color: Colors.black87),
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(builder: (_) => EditProfilePage(mobileNumber: widget.mobileNumber),
                      //           )
                      //       );
                      //     }
                      // )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 2),

            /// MENU ITEMS

            _menuTile(
              icon: CupertinoIcons.bell,
              title: "Notification",
              subtitle: "All Notification",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationPage(),
                  ),
                );
              },
            ),

            _menuTile(
              icon: CupertinoIcons.cube_box,
              title: "My Orders",
              subtitle: "All Order here",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyOrderPage(),
                  ),
                );
              },
            ),

            _menuTile(
              icon: CupertinoIcons.bookmark,
              title: "Saved",
              subtitle: "Saved items here",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SavedItemsPage(),
                  ),
                );
              },
            ),

            _menuTile(
              icon: CupertinoIcons.info,
              title: "About Us",
              subtitle: "All details here",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AboutUs(),
                  ),
                );
              },
            ),

            _menuTile(
              icon: CupertinoIcons.mail,
              title: "Contact Us",
              subtitle: "Contact details",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=> const ContactUs()));
              },
            ),

            _menuTile(
              icon: CupertinoIcons.square_arrow_left,
              title: "Logout",
              subtitle: "Tap to logout",
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => LogoutDialog(
                    mobileNumber: widget.mobileNumber,
                  ),
                );
              },
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  /// MENU TILE
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
          subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        Divider(height: 1, color: Colors.grey.shade300),
      ],
    );
  }
}