// ignore_for_file: deprecated_member_use, override_on_non_overriding_member, use_build_context_synchronously, non_constant_identifier_names, avoid_unnecessary_containers, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/models/unitresponsestore.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUnit extends StatefulWidget {
  const EditUnit({super.key});

  @override
  State<EditUnit> createState() => _EditUnitState();
}

class _EditUnitState extends State<EditUnit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitname = TextEditingController();
  final TextEditingController _unitsize = TextEditingController();
  final TextEditingController _bedsroom = TextEditingController();
  final TextEditingController _bathroom = TextEditingController();
  List<String> propertyItems = ["monthly", "6months", "yearly"];
  String? selectedPropertyValue;
  final TextEditingController _rentamount = TextEditingController();
  final TextEditingController _depositamount = TextEditingController();
  final TextEditingController _gstnumber = TextEditingController();
  String? getrenttype;
  String? selectedCategoryValue;
  String? selectedpropertid;
  String? tenantimage;
  String? editid;
  String? propertyid;
  List<dynamic> propertyTypes = [];
  String? selectedPropertyId; // Stores the selected propertyId
  bool isLoading = true;
  String? errorMessage;
  String? edittenantimag;
  String? selectimag;
  @override
  String tenantImage = '';
  String? selectedrenttype;
  File? selectedFile;

  @override
  void initState() {
   
    super.initState();
    Editvalue();
  }

  @override
  Future<void> _showImagePickerOptions() async {
    final picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Capture from Camera'),
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  Navigator.of(context).pop();
                  if (pickedFile != null) {
                    setState(() {
                      selectedFile = File(pickedFile.path);
                      tenantImage = pickedFile.path; // Update the image path
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Select from Gallery'),
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  Navigator.of(context).pop();
                  if (pickedFile != null) {
                    setState(() {
                      selectedFile = File(pickedFile.path);
                      tenantImage = pickedFile.path; // Update the image path
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> Editvalue() async {
    final selectedunitDetails =
        Provider.of<UnitProvider>(context, listen: false).selectedUnit;

    if (selectedunitDetails != null) {
      setState(() {
        editid = selectedunitDetails['unitId'].toString();
        propertyid = selectedunitDetails['propertyId'].toString();
        _unitname.text = selectedunitDetails['unitName'].toString();
        _unitsize.text = selectedunitDetails['unitSize'].toString();
        _bedsroom.text = selectedunitDetails['bedrooms'].toString();
        _bathroom.text = selectedunitDetails['bathrooms'].toString();
        getrenttype = selectedunitDetails['rentType'].toString();
        _rentamount.text = selectedunitDetails['rentAmount'].toString();
        _depositamount.text = selectedunitDetails['depositAmount'].toString();
        _gstnumber.text = selectedunitDetails['gstNumber'].toString();
        selectedpropertid = selectedunitDetails['propertid'].toString();
        edittenantimag = selectedunitDetails['thumbnail'].toString();
      });
    
      fetchProperties();
    } else {
      // Handle case where property details are not available
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
            propertyTypes = data['allproperties'];
            selectedPropertyId = propertyTypes.isNotEmpty
                ? propertyTypes[0]['propertyId'].toString()
                : null; // Default selection
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


  Future<void> _UpdateUnit() async {
        final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
   
    try {


      final url = Uri.parse(
          'https://www.eparivartan.co.in/rentalapp/public/user/updateUnit/$editid');

      // Create a multipart request
      var request = http.MultipartRequest('POST', url);
    

      // Add headers for authorization
      request.headers.addAll({
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'multipart/form-data',
      });

      // Add fields
      request.fields['propertyId'] = selectedPropertyId.toString();
      request.fields['unitName'] = _unitname.text;
      request.fields['unitSize'] = '${_unitsize.text}.00';
      request.fields['bedrooms'] = _bedsroom.text;
      request.fields['bathrooms'] = _bathroom.text;
      request.fields['rentAmount'] = _rentamount.text;
      request.fields['rentType'] = selectedrenttype.toString();
      request.fields['depositAmount'] = _depositamount.text;
      request.fields['gstNumber'] = _gstnumber.text;

      // Add file if available
      String fileName = tenantImage.toString(); // Extract file name
      request.files.add(await http.MultipartFile.fromPath(
        'thumbnail', // Key to send the image
        selectimag.toString(), // File path
        filename: selectimag, // File name
      ));

      // Send the request
      var response = await request.send();



      // Handle the response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
     
        Navigator.push(
         
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()),
        );
      } else {
        var responseBody = await response.stream.bytesToString();
      
      }
    } catch (e) {
    Fluttertoast();
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
                    'Edit Unit',
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
                        Text(
                          'Property',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                            
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        // getproperty(),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color(0xffDADADA), width: 1)),
                          child: DropdownButton<String>(
                            value: selectedPropertyId,
                            hint: const Text('Select a property'),
                            items: propertyTypes
                                .map<DropdownMenuItem<String>>((property) {
                              return DropdownMenuItem<String>(
                                value: property['propertyId'].toString(),
                                child: Text(property['propertyName'] ??
                                    'Unnamed Property'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedPropertyId =
                                    value; // Update selected property
                              });
                            },
                          ),
                        ),
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
                      rentType(),
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
                      onTap: () {
                        setState(() {
                          selectedrenttype =
                              selectedCategoryValue.toString();
                          selectimag = tenantImage.isNotEmpty
                              ? tenantImage
                              : '$edittenantimag';
                        });
                        

                               _UpdateUnit();

                      
                        // _UpdateUnit();
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

  Widget rentType() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text('$getrenttype'),
          value: selectedCategoryValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedCategoryValue = newValue;
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
        border: Border.all(color: const Color(0xffDADADA), width: 1),
      ),
      child: GestureDetector(
        onTap: () {
          _showImagePickerOptions();
        },
        child: Row(
          children: [
            Container(
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
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                tenantImage.isNotEmpty ? tenantImage : '$edittenantimag',
                style: GoogleFonts.urbanist(
                  color: ColorConstants.blackcolor,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
