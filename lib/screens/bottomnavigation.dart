import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/screens/homepage/homepage.dart';
import 'package:legala/screens/properties/propertylist.dart';
import 'package:legala/screens/tenant/tenantlist.dart';
import 'package:legala/screens/units/unitslist.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // List of pages to navigate to
  final List<Widget> _pages = [
    const Homepage(),
    const PropertyList(),
    const UnitsList(),
    const TenantList(),
    const Homepage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 82),
            painter: RPSCustomPainter(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 82, // Adjust height if needed
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent to see CustomPaint
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),  // Rounded top-left corner
                  topRight: Radius.circular(20), // Rounded top-right corner
                  // Bottom corners are not rounded, keeping them sharp
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 9,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),  // Rounded top-left corner
                  topRight: Radius.circular(20), // Rounded top-right corner
                ),
                child: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: _selectedIndex == 0
                          ? Image.asset(ImageConstants.SELECTEDCATEGORY, height: 24)
                          : Image.asset(ImageConstants.CATEGORY, height: 24),
                      label: 'Dashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: _selectedIndex == 1
                          ? Image.asset(ImageConstants.SELECTEDPROPERTIES, height: 24)
                          : Image.asset(ImageConstants.PROPERTIES, height: 24),
                      label: 'Properties',
                    ),
                    BottomNavigationBarItem(
                      icon: _selectedIndex == 2
                          ? Image.asset(ImageConstants.SELECTEDUNITS, height: 24)
                          : Image.asset(ImageConstants.UNITS, height: 24),
                      label: 'Units',
                    ),
                    BottomNavigationBarItem(
                      icon: _selectedIndex == 3
                          ? Image.asset(ImageConstants.SELECTEDTENANTS, height: 24)
                          : Image.asset(ImageConstants.TENANTS, height: 24),
                      label: 'Tenants',
                    ),
                    BottomNavigationBarItem(
                      icon: _selectedIndex == 4
                          ? Image.asset(ImageConstants.SELECTEDREPORTS, height: 24)
                          : Image.asset(ImageConstants.REPORTS, height: 24),
                      label: 'Reports',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: ColorConstants.primaryColor,
                  unselectedItemColor: Colors.grey,
                  selectedLabelStyle: GoogleFonts.urbanist(
                      color: ColorConstants.primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                  unselectedLabelStyle: GoogleFonts.urbanist(
                      color: ColorConstants.lighttext,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                  onTap: _onItemTapped,
                  type: BottomNavigationBarType.fixed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CustomPainter class
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(9, 30);
    path_0.cubicTo(9, 18.9543, 17.9543, 10, 29, 10);
    path_0.lineTo(364, 10);
    path_0.cubicTo(375.046, 10, 384, 18.9543, 384, 30);
    path_0.lineTo(384, 74);
    path_0.lineTo(9, 74);
    path_0.lineTo(9, 30);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
