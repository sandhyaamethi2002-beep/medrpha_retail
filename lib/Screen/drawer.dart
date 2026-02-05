import 'package:flutter/material.dart';
import 'package:medrpha/Drawer/about_us.dart';
import 'package:medrpha/Drawer/contact_us.dart';
import 'package:medrpha/Drawer/return_exchange.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,

      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          color: Colors.white,

          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Medrpha',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),

              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Download App'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About us'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const AboutUs()),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: const Text('Return Exchanges'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context)=> const ReturnExchange()));
                },
              ),

              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('Contact us'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context)=> const ContactUs()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}