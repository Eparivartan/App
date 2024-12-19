import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/sevices/unitprovider.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UnitDropdown extends StatefulWidget {
  const UnitDropdown({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UnitDropdownState createState() => _UnitDropdownState();
}

class _UnitDropdownState extends State<UnitDropdown> {
  String? selectedPropertyValue;
  String? selectedUnitValue;
  String? sltunitid;
  bool isLoading = true;
  String errorMessage = '';
  List<dynamic> propertyTypes = [];
  List<dynamic> unitList = [];

  @override
  void initState() {
    super.initState();
    fetchProperties();
  }

  Future<void> fetchProperties() async {
     final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/getproperties/'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['allproperties'] != null && data['allproperties'] is List) {
          setState(() {
            propertyTypes = data['allproperties'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'No properties found';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load properties: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Property',
          style: GoogleFonts.urbanist(
              color: ColorConstants.blackcolor,
              // ignore: deprecated_member_use
              fontSize: 13.sp,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        // Property Dropdown
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffDADADA), width: 1)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: const Text('Select Property Type'),
              value: propertyTypes.any((property) =>
                      property['propertyId'].toString() ==
                      selectedPropertyValue)
                  ? selectedPropertyValue
                  : null,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPropertyValue = newValue;
                });

                // Find the selected property
                final selectedProperty = propertyTypes.firstWhere(
                    (property) => property['propertyId'].toString() == newValue,
                    orElse: () => null);

                if (selectedProperty != null) {
                  setState(() {
                    sltunitid = selectedProperty['propertyId'].toString();
                  });
                  Provider.of<PropertyProvider>(context, listen: false)
                      .setProperty(
                    selectedProperty['propertyId'].toString(),
                    selectedProperty['propertyName'] ?? 'Unnamed Property',
                  );
                }
              },
              items: propertyTypes.map((property) {
                final propertyId = property['propertyId']?.toString();
                final propertyName =
                    property['propertyName'] ?? 'Unnamed Property';
                return DropdownMenuItem<String>(
                  value: propertyId,
                  child: Text(propertyName),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
