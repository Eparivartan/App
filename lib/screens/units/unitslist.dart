// ignore_for_file: deprecated_member_use, duplicate_ignore, non_constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/models/unitresponsestore.dart';
import 'package:legala/screens/units/createunit.dart';
import 'package:legala/screens/units/editunit.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnitsList extends StatefulWidget {
  const UnitsList({super.key});

  @override
  State<UnitsList> createState() => _UnitsListState();
}

class _UnitsListState extends State<UnitsList> {
  List<dynamic> properties = [];
  List<Map<String, dynamic>> unitList = [];

  bool isLoading = true;
  String? errorMessage;

  String? sltunitid;
  String? selectedPropertyid;
  String? selectedPropertyText;
  String? propertyName;
  String? unitid;

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
            properties = data['allproperties'];
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

  Future<void> fetchUnitsForSelectedProperty() async {
    final token =
        Provider.of<TokenProvider>(context, listen: false).accessToken;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/getunitsforproperties/$selectedPropertyText'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          unitList = List<Map<String, dynamic>>.from(data['allunits'] ?? []);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load units: ${response.statusCode}';
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
    return Scaffold(
      backgroundColor: ColorConstants.searchfield,
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 4.h),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: ColorConstants.whiteColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              color: ColorConstants.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: ColorConstants.filterborderColor,
                                  width: 1),
                            ),
                            child: Center(
                              child: Image.asset(
                                ImageConstants.PROPERTYTYPE,
                                height: 25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: const Color(0xffDADADA), width: 1),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: const Text('Select Property Type'),
                                  value: properties.any((property) =>
                                          property['propertyId'].toString() ==
                                          selectedPropertyText)
                                      ? selectedPropertyText
                                      : null,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedPropertyText = newValue;
                                    });

                                    final selectedProperty =
                                        properties.firstWhere(
                                      (property) =>
                                          property['propertyId'].toString() ==
                                          newValue,
                                      orElse: () => null,
                                    );

                                    if (selectedProperty != null) {
                                      setState(() {
                                        sltunitid =
                                            selectedProperty['propertyId']
                                                .toString();
                                        propertyName =
                                            selectedProperty['propertyName'] ??
                                                'Unnamed Property';
                                      });
                                    }
                                  },
                                  items: properties.map((property) {
                                    final propertyId =
                                        property['propertyId']?.toString();
                                    return DropdownMenuItem<String>(
                                      value: propertyId,
                                      child: Text(property['propertyName'] ??
                                          'Unnamed Property'),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          if (selectedPropertyText != null) {
                            fetchUnitsForSelectedProperty();
                           
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please select a property",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text('Search',
                                style: GoogleFonts.plusJakartaSans(
                                    color: ColorConstants.whiteColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedPropertyText != null
                        ? propertyName ?? 'Unnamed Property'
                        : 'Select a property',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.secondaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateUnit()),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: ColorConstants.primaryColor,
                          size: 20,
                        ),
                        Text(
                          'Create Unit',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.primaryColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : unitList.isEmpty
                      ? Center(
                          child: Text(errorMessage ?? 'No units available.'))
                      : ListView.builder(
                          itemCount: unitList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final unit = unitList[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 14),
                                decoration: BoxDecoration(
                                    color: ColorConstants.whiteColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                5.0), // Rounded corners
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.blue,
                                              child: Center(
                                                child: unit['thumbnail'] !=
                                                            null &&
                                                        unit['thumbnail']!
                                                            .isNotEmpty
                                                    ? Image.network(
                                                        'https://www.eparivartan.co.in/rentalapp/public/${unit['thumbnail']}',
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Text(
                                                unit['unitName'] ??
                                                    "Emoty Units",
                                                style: GoogleFonts.urbanist(
                                                    color: ColorConstants
                                                        .blackcolor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Text('Vasudha Avenue',
                                                style: GoogleFonts.urbanist(
                                                    color: ColorConstants
                                                        .lighttext,
                                                    // ignore: deprecated_member_use
                                                    fontSize: 11.sp,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Text(
                                                '${unit['unitSize'] ?? 'emptyUnit'} sq ft',
                                                style: GoogleFonts.urbanist(
                                                    color: ColorConstants
                                                        .lighttext,
                                                    fontSize: 11.sp,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Provider.of<UnitProvider>(
                                                            context,
                                                            listen: false)
                                                        .setSelectedUnit(unit);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const EditUnit()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffedf5ec),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Image.asset(
                                                      ImageConstants.EDIT,
                                                      height: 20,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      unitid = unit['unitId'];
                                                    });
                                                    DeleteIndex();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffe6e6e6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Image.asset(
                                                      ImageConstants.DELETE,
                                                      height: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(
                                      color: ColorConstants.textcolor,
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: const Color(0xfff4f4f4),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                ImageConstants.BEDROOM,
                                                height: 20,
                                              ),
                                              SizedBox(width: 2.w),
                                              Text(
                                                  unit['bedrooms'] ??
                                                      'emptybedrooms',
                                                  style: GoogleFonts.urbanist(
                                                      color: ColorConstants
                                                          .lighttext,
                                                      // ignore: deprecated_member_use
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: const Color(0xfff4f4f4),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                ImageConstants.KITCHEN,
                                                height: 20,
                                              ),
                                              SizedBox(width: 2.w),
                                              Text('02',
                                                  style: GoogleFonts.urbanist(
                                                      color: ColorConstants
                                                          .lighttext,
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: const Color(0xfff4f4f4),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                ImageConstants.BATHROOOMS,
                                                height: 20,
                                              ),
                                              SizedBox(width: 2.w),
                                              Text(
                                                  unit['bathrooms'] ??
                                                      'Empty Bathrooms',
                                                  style: GoogleFonts.urbanist(
                                                      color: ColorConstants
                                                          .lighttext,
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                        'Rent Type - ${unit['rentType'] ?? 'No RentType'}',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                        'Rent - ₹${unit['rentAmount'] ?? 'No Rent Amount'}',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text('Rent Duration - 7 Years',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                        'Deposit Amount - ₹${unit['depositAmount'] ?? 'Deposit Amount'}',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text('Yearly Tax - ₹3000',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    const SizedBox(
                                      width: 200,
                                      child: Divider(
                                        thickness: 1,
                                        color: ColorConstants.bordercolor,
                                      ),
                                    ),
                                    Text('Current Tenant',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> DeleteIndex() async {
    final String url =
        "https://www.eparivartan.co.in/rentalapp/public/user/deleteunit/$unitid";
    final bearerToken =
        Provider.of<TokenProvider>(context, listen: false).accessToken; //
  

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
      );
     

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
       
            await fetchProperties();
       
      } else {
         Fluttertoast.showToast(
      msg: "Failed to delete property: ${response.statusCode}", // Message to display
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast (short or long)
      gravity: ToastGravity.BOTTOM, // Position of the toast (top, center, bottom)
      timeInSecForIosWeb: 1, // iOS/Web toast duration
      backgroundColor: Colors.black, // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Text font size
    );
       
      }
    } catch (error) {
        Fluttertoast.showToast(
      msg: "Error deleting property: $error", // Message to display
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast (short or long)
      gravity: ToastGravity.BOTTOM, // Position of the toast (top, center, bottom)
      timeInSecForIosWeb: 1, // iOS/Web toast duration
      backgroundColor: Colors.black, // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Text font size
    );
     
    }
  }
}
