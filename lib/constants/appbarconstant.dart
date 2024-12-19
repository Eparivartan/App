// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:legala/constants/coloconstant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({super.key}) : preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.whiteColor,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Image.asset(
        'assets/images/logo.png',  // Replace with your logo
        height: 40,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle notification press
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: CircleAvatar(
            radius: 18, // Adjust the size of the profile picture
            backgroundImage: AssetImage('assets/icons/profile.png'), // Replace with your profile image
          ),
        ),
      ],
    );
  }
}
