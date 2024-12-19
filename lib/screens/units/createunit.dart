// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers, depend_on_referenced_packages, use_build_context_synchronously, unused_import, duplicate_ignore

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/models/dropdown.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:legala/sevices/unitprovider.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateUnit extends StatefulWidget {
  const CreateUnit({super.key});

  @override
  State<CreateUnit> createState() => _CreateUnitState();
}

class _CreateUnitState extends State<CreateUnit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitname = TextEditingController();
  final TextEditingController _unitsize = TextEditingController();
  final TextEditingController _bedsroom = TextEditingController();
  final TextEditingController _bathroom = TextEditingController();
  List<String> propertyItems = ['Villa', 'Individual House', 'Outhouse'];
  String? selectedPropertyValue;
  final TextEditingController _rentamount = TextEditingController();
  final TextEditingController _depositamount = TextEditingController();
  final TextEditingController _gstnumber = TextEditingController();
  List<String> categoryItems = ["monthly", "6months", "yearly"];
  String? selectedCategoryValue;
  String? unitimg;

  File? unitThumbnail;

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
        unitThumbnail = File(pickedFile.path);
        fileName = unitThumbnail!.path.split('/').last;
      });
    } else {
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
  
Future<void> _createUnit() async {
 
  try {
     final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final propertyId =
        Provider.of<PropertyProvider>(context, listen: false).selectedPropertyId;

    final url =
        Uri.parse('https://www.eparivartan.co.in/rentalapp/public/user/unit');

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);
  


    // Add headers for authorization
    request.headers.addAll({
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'multipart/form-data',
    });

    // Add fields
    request.fields['propertyId'] = propertyId.toString();
    request.fields['unitName'] = _unitname.text;
    request.fields['unitSize'] = '${_unitsize.text}.00';
    request.fields['bedrooms'] = _bedsroom.text;
    request.fields['bathrooms'] = _bathroom.text;
    request.fields['rentAmount'] = _rentamount.text;
    request.fields['rentType'] = selectedCategoryValue.toString();
    request.fields['depositAmount'] = _depositamount.text;
    request.fields['gstNumber'] = _gstnumber.text;

    // Add file if available
    if (unitThumbnail != null && unitThumbnail!.existsSync()) {
      request.files.add(await http.MultipartFile.fromPath(
        'thumbnail',
        unitThumbnail!.path,
        filename: fileName,
      ));
    }

    // Send the request
    var response = await request.send();

   

    // Handle the response
    if (response.statusCode == 201) {
      var responseBody = await response.stream.bytesToString();
    
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const BottomNavigation()),
      );
    } else {
      var responseBody = await response.stream.bytesToString();
     
    }
  } catch (e) {
    Fluttertoast(
      
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    'Create Unit',
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
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),

                        SizedBox(
                          height: 0.5.h,
                        ),
                        // getproperty(),
                        const UnitDropdown(),
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
                          'Unit Size',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        unitsize(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Bedroom',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        bedroom(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Bathrooms',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        bathroom(),
                        SizedBox(
                          height: 1.h,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      color: ColorConstants.whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'Rent Amount',
                        style: GoogleFonts.urbanist(
                            color: ColorConstants.blackcolor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      rentalamount(),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'Rent Type',
                        style: GoogleFonts.urbanist(
                            color: ColorConstants.blackcolor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      renttype(),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'Deposit Amount',
                        style: GoogleFonts.urbanist(
                            color: ColorConstants.blackcolor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      depositamount(),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'GST',
                        style: GoogleFonts.urbanist(
                            color: ColorConstants.blackcolor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      gst(),
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
                      uploadunitimgs(),
                      SizedBox(
                        height: 1.h,
                      )
                    ],
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
                      onTap: ()  {
                         
                    
                         
                          _createUnit();
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
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

  Widget getproperty() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstants.filterborderColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true, // Expands dropdown to full width
          hint: const Text('Select Property Type'),
          value: selectedPropertyValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedPropertyValue = newValue;
            });
          },
          items: propertyItems.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _propertyname() {
    return Container(
      child: TextFormField(
        controller: _unitname,
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

  Widget unitsize() {
    return Container(
      child: TextFormField(
        controller: _unitsize,
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

  Widget bedroom() {
    return Container(
      child: TextFormField(
        controller: _bedsroom,
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
          hintText: 'Enter Howmany bedrooms',
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

  Widget bathroom() {
    return Container(
      child: TextFormField(
        controller: _bathroom,
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
          hintText: 'Enter Howmany Bathrooms',
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

  // Amout and proof section

  Widget rentalamount() {
    return Container(
      child: TextFormField(
        controller: _rentamount,
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
          hintText: 'Enter Rental Amount',
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

  Widget renttype() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstants.filterborderColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: const Text('Select Rent Type'),
          value: selectedCategoryValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedCategoryValue = newValue;
            });
          },
          items: categoryItems.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget gst() {
    return Container(
      child: TextFormField(
        controller: _gstnumber,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter Gstnumber(optional)',
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

  Widget depositamount() {
    return Container(
      child: TextFormField(
        controller: _depositamount,
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
          hintText: 'Enter Deposit Amount',
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

  //thumbnail

  Widget uploadunitimgs() {
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
        child: Container(
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
      ),
    );
  }
}
