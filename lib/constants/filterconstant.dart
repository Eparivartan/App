import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:legala/providers/propertytypeid.dart'; // Import the PropertyTypeProvider
import 'package:provider/provider.dart';

class FilterConstant extends StatefulWidget {
  const FilterConstant({super.key});

  @override
  State<FilterConstant> createState() => _FilterConstantState();
}

class _FilterConstantState extends State<FilterConstant> {
  List<Map<String, String>> propertyTypes = [];
  List<dynamic> properties = [];
  bool isLoading = true;
  String? errorMessage;
  String? selectedPropertyValue;
  String? sltunitid;

  String? selectedPropertyid;
  String? selectedPropertyText;

  @override
  void initState() {
    super.initState();
    fetchProperties();
    fetchType();
  }

  Future<void> fetchType() async {
    final token =
        Provider.of<TokenProvider>(context, listen: false).accessToken;
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/getPropertiesType'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['allproperties'] != null && data['allproperties'] is List) {
          setState(() {
            propertyTypes = (data['allproperties'] as List)
                .map((item) => {
                      'type': item['type'].toString(),
                      'id': item['id'].toString(), // Assuming 'id' is available
                    })
                .toList();
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
              height: 20,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : propertyTypes.isEmpty
                    ? const Center(child: Text('No properties found'))
                    : Row(
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
                                ImageConstants.CATEGORYTYPE,
                                height: 25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstants.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: ColorConstants.filterborderColor,
                                    width: 1),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: const Text('Select Property Type'),
                                  value: selectedPropertyValue,
                                  onChanged: (value) {
                                    final selectedType = value;
                                    final selectedId = propertyTypes.firstWhere(
                                      (element) =>
                                          element['type'] == selectedType,
                                      orElse: () => {'id': '', 'type': ''},
                                    )['id']; // Corrected line

                                    setState(() {
                                      selectedPropertyValue = selectedType;
                                    
                                    });

                                    // Store the selected id and type in the provider
                                    Provider.of<PropertyTypeProvider>(context,
                                            listen: false)
                                        .setPropertyType(
                                            selectedType, selectedId);
                                  },
                                  items: propertyTypes
                                      .map((property) =>
                                          DropdownMenuItem<String>(
                                            value: property['type'],
                                            child: Text(
                                              property['type']!,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ))
                                      .toList(),
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
