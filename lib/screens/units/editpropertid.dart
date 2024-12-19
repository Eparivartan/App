// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:legala/sevices/unitprovider.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



class EditUnitProperty extends StatefulWidget {
  const EditUnitProperty({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditUnitPropertyState createState() => _EditUnitPropertyState();
}

class _EditUnitPropertyState extends State<EditUnitProperty> {
  bool isLoading = true;
  String errorMessage = '';
  List<dynamic> propertyTypes = [];

  @override
  void initState() {
    super.initState();
    initializeDefaultProperty();
    fetchProperties();
  }

  /// Initialize default property values from the provider
  Future<void> initializeDefaultProperty() async {
    final propertyProvider =
        Provider.of<PropertyProvider>(context, listen: false);

    // Call EditPropertyid to print and ensure default values
    final propertyId = propertyProvider.selectedPropertyId;
    final selectedPropertyName = propertyProvider.selectedPropertyName;

    if (propertyId != null && selectedPropertyName != null) {
     

      // Simulate a brief delay to showcase provider initialization
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Fetch properties from API
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

          // Set default selected property from provider
          final propertyProvider =
              // ignore: use_build_context_synchronously
              Provider.of<PropertyProvider>(context, listen: false);
          final defaultProperty = propertyTypes.firstWhere(
            (property) =>
                property['propertyId'].toString() ==
                propertyProvider.selectedPropertyId,
            orElse: () => null,
          );

      
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Unit Property'),
      ),
      body: Consumer<PropertyProvider>(
        builder: (context, propertyProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Property',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Property Dropdown
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xffDADADA), width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Select Property Type'),
                      value: propertyProvider.selectedPropertyId,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          // Find the selected property
                          final selectedProperty = propertyTypes.firstWhere(
                            (property) =>
                                property['propertyId'].toString() == newValue,
                            orElse: () => null,
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
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
