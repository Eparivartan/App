// ignore_for_file: deprecated_member_use, use_build_context_synchronously, empty_catches, prefer_const_declarations

import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/screens/properties/editableselectedid.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedPropertyDetails extends StatefulWidget {
  const SelectedPropertyDetails({super.key});

  @override
  State<SelectedPropertyDetails> createState() =>
      _SelectedPropertyDetailsState();
}

class _SelectedPropertyDetailsState extends State<SelectedPropertyDetails> {
  String? propertyProfile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _propertyType = TextEditingController();
  final TextEditingController _propertyName = TextEditingController();
  final TextEditingController _propertySize = TextEditingController();
  final TextEditingController _propertyYearlyTax = TextEditingController();
  final TextEditingController _propertyCountry = TextEditingController();
  final TextEditingController _propertyState = TextEditingController();
  final TextEditingController _propertyCity = TextEditingController();
  final TextEditingController _propertyZipcode = TextEditingController();
  final TextEditingController _propertyAddress = TextEditingController();
  final TextEditingController _propertyStatus = TextEditingController();

  @override
  void initState() {
    super.initState();
    Editvalue();
  }

  File? propertyThumbnail;
  String? propertyid;

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
    } else {}
  }

  // ignore: non_constant_identifier_names
  Future<void> Editvalue() async {
    final selectedPropertyDetails =
        Provider.of<SelectedPropertyProvider>(context, listen: false)
            .selectedProperty;

    if (selectedPropertyDetails != null) {
      setState(() {
        _propertyType.text = selectedPropertyDetails.propertyType.toString();
        _propertyName.text = selectedPropertyDetails.propertyName.toString();
        _propertySize.text = selectedPropertyDetails.propertySize.toString();
        _propertyYearlyTax.text =
            selectedPropertyDetails.propertyYearlyTax.toString();
        _propertyCountry.text =
            selectedPropertyDetails.propertyCountry.toString();
        _propertyState.text = selectedPropertyDetails.propertyState.toString();
        _propertyCity.text = selectedPropertyDetails.propertyCity.toString();
        _propertyZipcode.text =
            selectedPropertyDetails.propertyZipcode.toString();
        _propertyAddress.text =
            selectedPropertyDetails.propertyAddress.toString();
        _propertyStatus.text =
            selectedPropertyDetails.propertyStatus.toString();
        propertyProfile = selectedPropertyDetails.propertyThumbnail.toString();
        propertyid = selectedPropertyDetails.propertyId.toString();
      });
    } else {
      // Handle case where property details are not available
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              // Use your controllers here, for example:
              SizedBox(
                height: 1.6.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  'Edit Property',
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
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
                        final prefs = await SharedPreferences.getInstance();
                        final accessToken = prefs.getString('access_token');

                        // final selectedImg = '${baseFileName}';
                        final country = 'India';
                        final url = Uri.parse(
                            'https://www.eparivartan.co.in/rentalapp/public/user/updateproperty/${propertyid.toString()}'); // Replace with your API URL

                        // Create a multipart request
                        var request = http.MultipartRequest('POST', url);

                        // Add headers for authorization
                        request.headers.addAll({
                          'Authorization': 'Bearer $accessToken',
                          'Content-Type': 'multipart/form-data',
                        });

                        // Add fields (key-value pairs)
                        request.fields['propertyType'] = _propertyType.text;
                        request.fields['propertyName'] = _propertyName.text;
                        request.fields['propertySize'] = _propertySize.text;
                        request.fields['propertyYearlyTax'] =
                            _propertyYearlyTax.text;
                        request.fields['propertyCountry'] = 'India';
                        request.fields['propertyState'] = _propertyState.text;
                        request.fields['propertyCity'] = _propertyCity.text;
                        request.fields['propertyZipcode'] =
                            _propertyZipcode.text;
                        request.fields['propertyAddress'] =
                            _propertyAddress.text;
                        request.fields['propertyStatus'] = '1';

                        // Add the file if available
                        if (propertyThumbnail != null &&
                            propertyThumbnail!.existsSync()) {
                          request.files.add(await http.MultipartFile.fromPath(
                            'propertyThumbnail',
                            propertyThumbnail!.path,
                            filename: fileName ?? "",
                          ));
                        }

                        try {
                          // Send the request
                          var response = await request.send();

                          // Handle the response
                          if (response.statusCode == 200) {
                            var responseBody =
                                await response.stream.bytesToString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavigation()),
                            );
                          } else {
                            var responseBody =
                                await response.stream.bytesToString();
                          }
                        } catch (e) {}
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
              // Add more fields as necessary
            ],
          ),
        ),
      ),
    );
  }

  Widget address() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: TextFormField(
        controller: _propertyAddress,
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
          hintText: _propertyAddress.text,
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
    return TextFormField(
      controller: _propertyState,
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
        hintText: _propertyState.text,
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

  // ignore: non_constant_identifier_names
  Widget City() {
    return TextFormField(
      controller: _propertyCity,
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
        hintText: _propertyCity.text,
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
              '${propertyProfile ?? fileName} ?? "No Chosenfile',
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
    return TextFormField(
      controller: _propertyYearlyTax,
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
        hintText: _propertyYearlyTax.text,
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

  Widget propertysize() {
    return TextFormField(
      controller: _propertySize,
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
        hintText: _propertySize.text,
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

  Widget _proprtytype() {
    return TextFormField(
      controller: _propertyType,
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
        hintText: _propertyType.text,
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
    // ignore: avoid_unnecessary_containers
    return Container(
      child: TextFormField(
        controller: _propertyZipcode,
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
          hintText: _propertyZipcode.text,
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
    return TextFormField(
      controller: _propertyName,
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
    );
  }

  Widget country() {
    return TextFormField(
      controller: _propertyCountry,
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
        hintText: _propertyCountry
            .text, // Optional, since 'India' is already the default value
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
    );
  }
}
