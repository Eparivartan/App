// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/screens/loginscreen.dart';
import 'package:legala/sevices/usedetailsprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 35,
                  )
                ],
              )),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: _selectedIndex == 0
                        ? ColorConstants.primaryColor
                        : ColorConstants.blackcolor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: _selectedIndex == 0
                          ? ColorConstants.primaryColor
                          : ColorConstants.blackcolor,
                      fontWeight: _selectedIndex == 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0), // Spacing between containers
          GestureDetector(
            onTap: () async {
              // Access SharedPreferences instance
              final prefs = await SharedPreferences.getInstance();

              // Clear the 'access_token' key
              await prefs.remove('access_token');

              setState(() {
                _selectedIndex = 1;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              decoration: const BoxDecoration(),
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: _selectedIndex == 1
                        ? ColorConstants.primaryColor
                        : ColorConstants.blackcolor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: _selectedIndex == 1
                          ? ColorConstants.primaryColor
                          : ColorConstants.blackcolor,
                      fontWeight: _selectedIndex == 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
