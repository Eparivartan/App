import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/models/uermodel.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:legala/sevices/unitprovider.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:http/http.dart' as http;
import 'dart:convert';

class PropertyListView extends StatefulWidget {
  @override
  _PropertyListViewState createState() => _PropertyListViewState();
}

class _PropertyListViewState extends State<PropertyListView> {
  bool isLoading = true; // For loading indicator
  String errorMessage = ''; // For error messages
  List<Allproperties> propertyTypes = []; // List to hold property types

  @override
  void initState() {
    super.initState();
    fetchProperties(); // Fetch the properties when the widget is initialized
  }

  Future<void> fetchProperties() async {
    final token = Provider.of<TokenProvider>(context, listen: false)
        .accessToken; // Replace with the correct token or pass from the parent
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/getproperties/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['allproperties'] != null && data['allproperties'] is List) {
          final PropertiesDisplay propertiesDisplay =
              PropertiesDisplay.fromJson(data);
          setState(() {
            propertyTypes = propertiesDisplay.allproperties ?? [];
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
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(), // Show loader when loading
      );
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(errorMessage), // Show error message
      );
    }

    if (propertyTypes.isEmpty) {
      return Center(
        child: Text('No properties available'), // Show no data message
      );
    }

    return ListView.builder(
      itemCount: propertyTypes.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final property = propertyTypes[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(5.0), // Rounded corners
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.blue,
                          child: Center(
                            child: property.propertyThumbnail != null &&
                                    property.propertyThumbnail!.isNotEmpty
                                ? Image.network(
                                    'https://www.eparivartan.co.in/rentalapp/public/${property.propertyThumbnail}',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Fallback to asset image on error
                                      return Image.asset(
                                        'assets/images/property.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/images/property.png',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${property.propertyName ?? 'Unknown Property'}',
                            style: GoogleFonts.urbanist(
                                color: ColorConstants.secondaryColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            '${property.propertyCity ?? 'Unknown City'}, ${property.propertyState ?? 'Unknown State'}',
                            style: GoogleFonts.urbanist(
                                color: ColorConstants.lighttext,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${property.propertySize ?? 'Unknown size'}sq ft',
                                style: GoogleFonts.urbanist(
                                    color: ColorConstants.lighttext,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '${property.propertySize ?? 'Unknown size'}',
                                style: GoogleFonts.urbanist(
                                    color: ColorConstants.secondaryColor,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.5.h,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Divider(
                  color: ColorConstants.bordercolor,
                  thickness: 1,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Units: 10',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.textcolor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          'Available Units: 05',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.primaryColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Color(0xffedf5ec),
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(
                        ImageConstants.EDIT,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Color(0xffe6e6e6),
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(
                        ImageConstants.DELETE,
                        height: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
