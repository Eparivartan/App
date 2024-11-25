import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/drawer.dart';
import 'package:legala/constants/filterconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/models/propertylistview.dart';
import 'package:legala/models/uermodel.dart';
import 'package:legala/screens/properties/createpropertiess.dart';
import 'package:legala/screens/properties/storedvalues.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  List<PropertiesDisplay> properties = []; // List to hold property data
  bool isLoading = true; // For loading indicator
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProperties();
  }

  Future<void> fetchProperties() async {
    final token = Provider.of<TokenProvider>(context, listen: false).accessToken;
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/getproperties/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse the response into a Map
        if (data['properties'] != null && data['properties'] is List) {
          final List<dynamic> propertiesData = data['properties'];
          setState(() {
            properties = propertiesData
                .map((json) => PropertiesDisplay.fromJson(json))
                .toList();
            isLoading = false;
          });
          print(response.body);
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'Failed to load properties: No properties found in response';
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.searchfield,
      appBar: CustomAppBar(), // Call your reusable CustomAppBar here
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 4.h,
              ),
              FilterConstant(),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Properties',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.secondaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateProperties()),
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: ColorConstants.primaryColor,
                            size: 20,
                          ),
                          Text(
                            'Create Property',
                            style: GoogleFonts.urbanist(
                                color: ColorConstants.primaryColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),


              PropertyListView(),
             
            ],
          ),
        ),
      ),
    );
  }
}
