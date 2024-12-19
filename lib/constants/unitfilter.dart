import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/sevices/tokenprovider.dart';
// Import the PropertyTypeProvider
import 'package:provider/provider.dart';

class UnitFilter extends StatefulWidget {
  const UnitFilter({super.key});

  @override
  State<UnitFilter> createState() => _UnitFilterState();
}

class _UnitFilterState extends State<UnitFilter> {
  List<dynamic> properties = [];
  List<dynamic> unitList = [];
  bool isLoading = true;
  String? errorMessage;

  String? sltunitid;

  String? selectedPropertyid;
  String? selectedPropertyText;

  @override
  void initState() {
    super.initState();
    fetchProperties();
  }

  Future<void> fetchProperties() async {
    final token =
        Provider.of<TokenProvider>(context, listen: false).accessToken;
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/getproperties/'),
        headers: {'Authorization': 'Bearer $token'},
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
          unitList = data['allunits'] ?? [];
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: ColorConstants.whiteColor,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: ColorConstants.filterborderColor, width: 1),
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
                      border: Border.all(color: const Color(0xffDADADA), width: 1),
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

                          // Find the selected property
                          final selectedProperty = properties.firstWhere(
                            (property) =>
                                property['propertyId'].toString() == newValue,
                            orElse: () => null,
                          );

                          if (selectedProperty != null) {
                            setState(() {
                              sltunitid =
                                  selectedProperty['propertyId'].toString();
                            });
                          }
                        },
                        items: properties.map((property) {
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
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (selectedPropertyText != null) {
                  
                 
                  fetchUnitsForSelectedProperty();
                } else {
                  Fluttertoast.showToast(
                    msg: "Please select a property",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity
                        .BOTTOM, // You can use TOP, CENTER, or BOTTOM
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  return;
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
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
