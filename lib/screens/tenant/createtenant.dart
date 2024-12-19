// ignore_for_file: deprecated_member_use, non_constant_identifier_names, unused_import, use_build_context_synchronously, duplicate_ignore

import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/screens/dropdownlist.dart';
import 'package:legala/screens/tenant/tenantconnectionprovider.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTenant extends StatefulWidget {
  const CreateTenant({super.key});

  @override
  State<CreateTenant> createState() => _CreateTenantState();
}

class _CreateTenantState extends State<CreateTenant> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _emailtenant = TextEditingController();
  final TextEditingController _phonenumbertenant = TextEditingController();
  final TextEditingController _totalnumbers = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipcode = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String? multipleimages;
  String? proprtyid;
  String? unitid;

  String? validateEmail(String? value) {
    // Regular expression for validating email addresses
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null; // No error
  }

  final List<File> _uploadedImages = [];
  final List<File> _uploadedDocuments = [];

  final List<File> _cameraCapturedImages = [];
  final List<File> _images = [];

  final ImagePicker _picker = ImagePicker();

  // emailvalidation

  File? unitThumbnail;
  File? propertydocument;
  File? camerathumbnail;

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
      
    }
  }

  // start condition and endcondition


  Future<void> createtenant() async {
 
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    proprtyid = Provider.of<SelectionProvider>(context, listen: false)
        .selectedPropertyId;
    unitid =
        Provider.of<SelectionProvider>(context, listen: false).selectedUnitId;
   
    final url = Uri.parse(
        'https://www.eparivartan.co.in/rentalapp/public/user/createtenant');

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);
  

    // Add headers for authorization
    request.headers.addAll({
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'multipart/form-data',
    });

    // Add fields
    request.fields['propertyId'] = proprtyid.toString();
    request.fields['unitId'] = unitid.toString();
    request.fields['tenantFirstName'] = _firstname.text;
    request.fields['tenantLastName'] = _lastname.text;
    request.fields['tenantEmail'] = _emailtenant.text;
    request.fields['tenantPhoneNumber'] = _phonenumbertenant.text;
    request.fields['tenantNumbers'] = _totalnumbers.text;
    request.fields['tenantCountry'] = 'India';
    request.fields['tenantStateList'] = _state.text;
    request.fields['tenantCity'] = _city.text;
    request.fields['tenantZipCode'] = _zipcode.text;
    request.fields['tenantAddress'] = _address.text;
    request.fields['startDate'] = _startDateController.text;
    request.fields['endDate'] = _endDateController.text;
 for (var i = 0; i < _uploadedImages.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'fileDco[]',
       _uploadedImages[i].path,
      ));
    }

    for (var i = 0; i < _images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'startcondation[]',
        _images[i].path,
      ));
    }

    for (var i = 0; i < _cameraCapturedImages.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'endcondation[]',
        _cameraCapturedImages[i].path,
      ));
    }

    if (unitThumbnail != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'tenantProfileImage',
        unitThumbnail!.path,
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
      Fluttertoast.showToast(
        msg: responseBody.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstants.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  // ignore: empty_catches
  } catch (e) {
     Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstants.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
   
  }
}



//documents upload
  Future<void> pickfileoption() async {
    final ImagePicker picker = ImagePicker();

    // Show dialog for selecting file or image source
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final List<XFile> images = await picker.pickMultiImage();
                  setState(() {
                    _uploadedImages
                        .addAll(images.map((img) => File(img.path)));
                  });
                                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _uploadedImages.add(File(image.path));
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_copy),
                title: const Text('Documents'),
                onTap: () async {
                  Navigator.of(context).pop();
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: [
                      'pdf',
                      'doc',
                      'docx'
                    ], // Allowed extensions
                  );
                  if (result != null) {
                    setState(() {
                      _uploadedDocuments.addAll(result.paths
                          .where((path) => path != null)
                          .map((path) => File(path!)));
                    });
                  }
                },
              ),
            ],
          );
        });
  }

// upload images
  Future<void> _captureImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          _images.add(File(image.path));
        });
      }
    } catch (e) {
    Fluttertoast();
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Widget _buildImageList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _images.asMap().entries.map((entry) {
          int index = entry.key;
          File image = entry.value;

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _removeImage(index),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  //endcondition
  Future<void> captureImageWithCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _cameraCapturedImages.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.searchfield,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.6.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create Unit',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.urbanist(
                          color: ColorConstants.secondaryColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'First Name',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _firstName(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Last Name',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _lastName(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Email',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _tenantemail(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Phone Number',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _phonenumber(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Total Members',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _totalmembers(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Profile',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _chhosefile(),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Native Address Details',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.secondaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
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
                        SizedBox(
                          height: 1.h,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Property Details',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.secondaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
        
                        const TwoDropdowns(),
        
                        // PropertyDropdown(),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Start Date',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        startdate(),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'End Date',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        enddate(),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Documents',
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.blackcolor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Documents(),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Start Conditions',
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.blackcolor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                _startcondition(),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'End Conditions',
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.blackcolor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                _endcondition(),
                SizedBox(
                  height: 2.h,
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
                       
                        createtenant();
        
                     
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

  Widget _startcondition() {
    return Column(
      children: [
        GestureDetector(
          onTap: _captureImage,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DottedBorder(
              color: Colors.black,
              strokeWidth: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Image.asset(
                    'assets/icons/upload.png',
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_images.isNotEmpty) _buildImageList(),
      ],
    );
  }

  Widget _endcondition() {
    return Column(
      children: [
        GestureDetector(
          onTap: captureImageWithCamera,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DottedBorder(
              color: Colors.black,
              strokeWidth: 1,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Display captured images in a horizontal list
        _cameraCapturedImages.isNotEmpty
            ? SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _cameraCapturedImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.file(
                            _cameraCapturedImages[index],
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _cameraCapturedImages.removeAt(index);
                              });
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 12,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            : const Text("No images captured"),
      ],
    );
  }

  Widget Documents() {
    return Column(
      children: [
        GestureDetector(
          onTap: pickfileoption,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DottedBorder(
              color: Colors.black,
              strokeWidth: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Image.asset(
                    'assets/icons/upload.png',
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Display uploaded images in a horizontal list
        _uploadedImages.isNotEmpty
            ? SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _uploadedImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.file(
                            _uploadedImages[index],
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _uploadedImages.removeAt(index);
                              });
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 12,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            : const Text("No images uploaded"),
      ],
    );
  }

  Widget enddate() {
    return TextFormField(
      controller: _endDateController,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _endDateController.text = pickedDate.toString().split(' ')[0];
          });
        }
      },
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Select End Date',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        suffixIcon: GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                _endDateController.text = pickedDate.toString().split(' ')[0];
              });
            }
          },
          child:
              const Icon(Icons.calendar_today, color: ColorConstants.textcolor),
        ),
      ),
    );
  }

  Widget startdate() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Spacing between fields
      child: TextFormField(
        controller: _startDateController,
        readOnly: true, // Prevent manual typing
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            setState(() {
              _startDateController.text =
                  pickedDate.toString().split(' ')[0]; // Format date
            });
          }
        },
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Select Start Date',
          hintStyle: const TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          suffixIcon: GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  _startDateController.text =
                      pickedDate.toString().split(' ')[0];
                });
              }
            },
            child: const Icon(Icons.calendar_today,
                color: ColorConstants.textcolor),
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
    return TextFormField(
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
    );
  }

  Widget City() {
    return TextFormField(
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
    );
  }

  Widget state() {
    return TextFormField(
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
    );
  }

  Widget country() {
    return TextFormField(
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
    );
  }

  Widget _chhosefile() {
    return GestureDetector(
      onTap: _showImagePickerOptions,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffDADADA), width: 1),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xffE9E9E9),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                'Choose File',
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                    color: ColorConstants.blackcolor,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              width: 1.w,
            ),
            Text(
              unitThumbnail != null
                  ? 'File Path: $unitThumbnail'
                  : 'No file selected',
              style: GoogleFonts.urbanist(
                  color: const Color(0xffABABAB),
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }

  Widget _tenantemail() {
    return TextFormField(
      controller: _emailtenant,
      keyboardType: TextInputType.name,
      validator: validateEmail,
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Email Address',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
      ),
    );
  }

  Widget _phonenumber() {
    return TextFormField(
      controller: _phonenumbertenant,
      keyboardType: TextInputType.name,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10), // Limit input to 10 characters
        FilteringTextInputFormatter.digitsOnly, // Only allow numeric input
      ],
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
        hintText: 'Enter Phone number',
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

  Widget _totalmembers() {
    return TextFormField(
      controller: _totalnumbers,
      keyboardType: TextInputType.name,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10), // Limit input to 10 characters
        FilteringTextInputFormatter.digitsOnly, // Only allow numeric input
      ],
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
        hintText: 'Enter Phone number',
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

  Widget _firstName() {
    return TextFormField(
      controller: _firstname,
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
        hintText: 'select property',
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

  Widget _lastName() {
    return TextFormField(
      controller: _lastname,
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
        hintText: 'select property',
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
}
