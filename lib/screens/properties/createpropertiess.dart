// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers, depend_on_referenced_packages

import 'dart:convert';

import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/drawer.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProperties extends StatefulWidget {
  const CreateProperties({super.key});

  @override
  State<CreateProperties> createState() => _CreatePropertiesState();
}

class _CreatePropertiesState extends State<CreateProperties> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _propertname = TextEditingController();
  final TextEditingController _propertysize = TextEditingController();
  final TextEditingController _yearlytax = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipcode = TextEditingController();
  final TextEditingController _address = TextEditingController();
  String? propertyimg;
  String? baseFileName;
  String? selectedImg;
  File? propertyThumbnail;
  String? selectedId;

  void _showImagePickerOptions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    pickImage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    pickImage();
                  },
                ),
              ],
            ),
          );
        });
  }

  String? fileName;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        propertyThumbnail = File(pickedFile.path);
        fileName = propertyThumbnail!.path.split('/').last;
      });
    } else {
          Fluttertoast.showToast(
      msg: "This is a Toast message", // Message to display
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast (short or long)
      gravity: ToastGravity.BOTTOM, // Position of the toast (top, center, bottom)
      timeInSecForIosWeb: 1, // iOS/Web toast duration
      backgroundColor: Colors.black, // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Text font size
    );
    Fluttertoast.showToast(
      msg: "No image selected.", // Message to display
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast (short or long)
      gravity: ToastGravity.BOTTOM, // Position of the toast (top, center, bottom)
      timeInSecForIosWeb: 1, // iOS/Web toast duration
      backgroundColor: Colors.black, // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Text font size
    );

     
    }
  }
 List<Map<String, String>> propertyTypes = [];
  bool isLoading = true;
  String? errorMessage;
  String? selectedPropertyValue;
  String? sltunitid;

  @override
  void initState() {
    super.initState();
    fetchType();
  }

  Future<void> fetchType() async {
    final token =
        Provider.of<TokenProvider>(context, listen: false).accessToken;
     final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');    
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/getPropertiesType'),
        headers: {'Authorization': 'Bearer $accessToken'},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.searchfield,
      appBar: const CustomAppBar(), // Call your reusable CustomAppBar here
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.6.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    'Create Property',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.secondaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Type',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _proprtytype(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Name',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _propertyname(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Property Size',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        propertysize(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Yearly Tax',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        yearlytax(),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Thumbnail',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        uploadpropertyimgs(),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Country',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        country(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'State',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        state(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'City',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        City(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Zipcode',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        zipcode(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Address',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        address(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 16),
                      decoration: BoxDecoration(
                          color: const Color(0xffdadada),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'Close',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final token =
                              Provider.of<TokenProvider>(context, listen: false)
                                  .accessToken;
                          const country = 'India';

                          final url = Uri.parse(
                              'https://www.eparivartan.co.in/rentalapp/public/user/properties'); // Replace with your API URL

                          // Create a multipart request
                          var request = http.MultipartRequest('POST', url);

                          // Add headers for authorization
                          request.headers.addAll({
                            'Authorization': 'Bearer $token',
                            
                            'Content-Type': 'multipart/form-data',
                          });

                          // Add fields (key-value pairs)
                          request.fields['propertyType'] = '$selectedId';
                          request.fields['propertyName'] = _propertname.text;
                          request.fields['propertySize'] = _propertysize.text;
                          request.fields['propertyYearlyTax'] = _yearlytax.text;
                          request.fields['propertyCountry'] =
                              country.toString();
                          request.fields['propertyState'] = _state.text;
                          request.fields['propertyCity'] = _city.text;
                          request.fields['propertyZipcode'] = _zipcode.text;
                          request.fields['propertyAddress'] = _address.text;
                          request.fields['propertyStatus'] = '1';

                          // Add the file if available
                          if (propertyThumbnail != null &&
                              propertyThumbnail!.existsSync()) {
                            request.files.add(await http.MultipartFile.fromPath(
                              'propertyThumbnail',
                              propertyThumbnail!.path,
                              filename: '$fileName',
                            ));
                          }

                          try {
                            // Send the request
                            var response = await request.send();

                            // Handle the response
                            if (response.statusCode == 201) {
                              var responseBody =
                                  await response.stream.bytesToString();

                              Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomNavigation()),
                              );
                            } else {
                              var responseBody =
                                  await response.stream.bytesToString();
                            }
                          // ignore: empty_catches
                          } catch (e) {
                           
                          }
                        } else {}
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 16),
                        decoration: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            'Create',
                            style: GoogleFonts.urbanist(
                                color: ColorConstants.whiteColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget address() {
    return TextFormField(
      controller: _address,
      keyboardType: TextInputType.multiline,
      minLines: 3, // Start with 3 lines
      maxLines: 5, // Allow up to 5 lines

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null; // Return null if validation is successful
      },
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Enter Property Address',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
      ),
    );
  }

  Widget zipcode() {
    return Container(
      child: TextFormField(
        controller: _zipcode,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null; // Return null if validation is successful
        },
        style: const TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter Zipcode',
          hintStyle: const TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget City() {
    return Container(
      child: TextFormField(
        controller: _city,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null; // Return null if validation is successful
        },
        style: const TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter City',
          hintStyle: const TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  Widget state() {
    return Container(
      child: TextFormField(
        controller: _state,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null; // Return null if validation is successful
        },
        style: const TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter State',
          hintStyle: const TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  Widget country() {
    return Container(
      child: TextFormField(
        controller: _country,
        readOnly: true, // Makes the field read-only
        style: const TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: const Color(0xffdadada),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText:
              'India', // Optional, since 'India' is already the default value
          hintStyle: GoogleFonts.urbanist(
            color: ColorConstants.blackcolor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
          ),
        ),
      ),
    );
  }

  Widget uploadpropertyimgs() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConstants.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffDADADA), width: 1)),
      child: GestureDetector(
        onTap: () {
          _showImagePickerOptions();
        },
        child: Row(
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 10),
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              decoration: const BoxDecoration(
                color: Color(0xffe9e9e9),
              ),
              child: Text(
                'Choose File',
                style: GoogleFonts.urbanist(
                    color: ColorConstants.blackcolor,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Text(
              '${selectedImg ?? baseFileName} ?? "No Chosenfile',
              style: GoogleFonts.urbanist(
                  color: const Color(0xffababab),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget yearlytax() {
    return Container(
      child: TextFormField(
        controller: _yearlytax,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null; // Return null if validation is successful
        },
        style: const TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Yearly Tax',
          hintStyle: const TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  Widget propertysize() {
    return Container(
      child: TextFormField(
        controller: _propertysize,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null; // Return null if validation is successful
        },
        style: const TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter Property Size',
          hintStyle: const TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  Widget _propertyname() {
    return Container(
      child: TextFormField(
        controller: _propertname,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null; // Return null if validation is successful
        },
        style: const TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter Property Name',
          hintStyle: const TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  Widget _proprtytype() {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : propertyTypes.isEmpty
            ? const Center(child: Text('No properties found'))
            : Container(
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
                                     selectedId = propertyTypes
                                        .firstWhere(
                                          (element) =>
                                              element['type'] == selectedType,
                                          orElse: () => {'id': '', 'type': ''},
                                        )['id']; // Corrected line

                                    setState(() {
                                      selectedPropertyValue = selectedType;
                                   
                                    });

                                    // Store the selected id and type in the provider
                                    
                                  },
                                  items: propertyTypes
                                      .map((property) => DropdownMenuItem<String>(
                                            value: property['type'],
                                            child: Text(
                                              property['type']!,
                                              style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            );
  }
}
