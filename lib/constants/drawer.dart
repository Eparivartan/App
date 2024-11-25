import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/sevices/usedetailsprovider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
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
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Icon(Icons.menu,color: Colors.black,),
                SizedBox(
                  width: 4.w,
                ),
                Image.asset('assets/images/logo.png',height: 25,)
              ],
            )
          ),
           GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = 0;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
       
        child: Row(
          children: [
            Icon(
              Icons.settings,
              color: _selectedIndex == 0
                  ? Colors.white
                  : ColorConstants.blackcolor,
            ),
            SizedBox(width: 10),
            Text(
              'Settings',
              style: TextStyle(
                color: _selectedIndex == 0
                    ? Colors.white
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
    SizedBox(height: 8.0), // Spacing between containers
    GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = 1;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
        
         
        ),
        child: Row(
          children: [
            Icon(
              Icons.logout,
              color: _selectedIndex == 1
                  ? Colors.white
                  : ColorConstants.blackcolor,
            ),
            SizedBox(width: 10),
            Text(
              'Logout',
              style: TextStyle(
                color: _selectedIndex == 1
                    ? Colors.white
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
