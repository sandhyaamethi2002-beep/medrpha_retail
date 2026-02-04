import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Medrpha',
              // textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,

              ),
            ),
          ),
          ListTile(
            leading: Image.asset(
            'assets/products_img/ethical.png',
            width: 30,
             height: 30,
             ),
            title: const Text('ETHICAL'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/products_img/ayurvedic.png',
              width: 30,
              height: 30,
            ),
            title: const Text('AYURVEDIC'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/products_img/generic.png',
              width: 30,
              height: 30,
            ),
            title: const Text('GENERIC'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Image.asset(
              'assets/products_img/surgical.png',
              width: 30,
              height: 30,
            ),
            title: const Text('SURGICAL'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Image.asset(
              'assets/products_img/veterinary.png',
              width: 30,
              height: 30,
            ),
            title: const Text('VETERINARY'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Image.asset(
              'assets/products_img/general.png',
              width: 30,
              height: 30,
            ),
            title: const Text('GENERAL'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
