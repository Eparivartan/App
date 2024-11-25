import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/screens/dropdownlist.dart';
import 'package:legala/screens/tenant/tenantconnectionprovider.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';

class CreateTenant extends StatefulWidget {
  const CreateTenant({super.key});

  @override
  State<CreateTenant> createState() => _CreateTenantState();
}

class _CreateTenantState extends State<CreateTenant> {
  @override
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

  // emailvalidation

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    // Define the regex pattern for email validation
    const pattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;
  String _filePath = '';
  String baseValue = ''; // Variable to store the base value

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _filePath = pickedFile.path; // Get the file path
      });

      // Example of using the split method
      // This assumes you want to split the file path by the '/' or '\\' (depending on the OS)
      List<String> pathParts = _filePath.split('/');

      // For example, extracting the last part (the file name)
      baseValue = pathParts.last;

      // If you want the file name without the extension

      print('Base Value: $baseValue'); // Output the base value
    }
  }

  Future<void> _pickfile() async {
    try {
      // Pick multiple files
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'doc',
          'docx',
          'xls',
          'xlsx',
          'ppt',
          'pptx'
        ], // Specify allowed document types
      );

      // Check if files were selected
      if (result != null && result.files.isNotEmpty) {
        // If multiple files are selected
        List<String> filePaths =
            result.files.map((file) => file.path!).toList();

        // Store base paths in a variable
        List<String> basePaths = [];
        setState(() {
          multipleimages = basePaths.toList().toString();
        });

        for (String filePath in filePaths) {
          print('Selected file: $filePath');

          // Split the file path and extract the base path (directory)
          multipleimages = filePath
              .split('/')
              .sublist(0, filePath.split('/').length - 1)
              .join('/');
        }

        // Now basePaths contains the base paths of all selected files
        print('Base paths: $basePaths');
      } else {
        print('No files selected.');
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  // start condition and endcondition

  Widget _imageContainer(XFile image) {
    return Container(
      width: 80, // Adjust width as needed
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Color(0xffDADADA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(image.path),
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> sendTenantData() async {
    final token =
        Provider.of<TokenProvider>(context, listen: false).accessToken;
    final proprtyid = Provider.of<SelectionProvider>(context, listen: false)
        .selectedPropertyId;
    final unitid =
        Provider.of<SelectionProvider>(context, listen: false).selectedUnitId;

    if (token != null) {
      print('$token >>>>>>>>>>>>>>>>>>>>>>'); // Log the token for debugging
      print('${proprtyid}');
      print('${unitid}');
      print(_firstname.text);
      print(_lastname.text);
      print(_emailtenant.text);
      print(_phonenumbertenant.text);
      print(_totalnumbers.text);
      print(_state.text);
      print(_city.text);
      print(_zipcode.text);
      print(_address.text);
      print(_startDateController.text);
      print(_endDateController.text);
      print(multipleimages.toString());

      // Define the data to be sent in the POST request
      final requestBody = {
        "propertyId": '${proprtyid}',
        "unitId": "${unitid}",
        "tenantFirstName": "${_firstname.text}",
        "tenantLastName": "${_lastname}",
        "tenantEmail": "${_emailtenant.text}",
        "tenantPhoneNumber": "${_phonenumbertenant.text}",
        "tenantNumbers": "${_totalnumbers.text}",
        "tenantProfileImage": "${baseValue.toString()}",
        "tenantCountry": "India",
        "tenantStateList": "${_state.text}",
        "tenantCity": "${_city.text}",
        "tenantZipcode": "${_zipcode.text}",
        "tenantAddress": "${_address.text}",
        "tenantAddDate": "${_startDateController.text}",
        "startdate": "${_startDateController.text} ",
        "enddate": "${_endDateController.text}",
        "documents": "${baseValue.toString()}"
      };

      try {
        // Making the POST request
        final response = await http.post(
          Uri.parse(
              'https://www.eparivartan.co.in/rentalapp/public/user/createtenant'),
          headers: {
            'Authorization': 'Bearer $token', // Use Bearer scheme for the token
            'Content-Type': 'application/json', // Ensure JSON content type
          },
          body: jsonEncode(requestBody),
        );

        // Handle the response
        if (response.statusCode == 200 || response.statusCode == 201) {
          Fluttertoast.showToast(
            msg: "Property data submitted successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          print("Response: ${response.body}");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          );
        } else {
          Fluttertoast.showToast(
            msg: "Failed to submit property data. Error: ${response.body}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          print("Error Response: ${response.body}");
        }
      } catch (error) {
        Fluttertoast.showToast(
          msg: "An error occurred: $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        print("Exception: $error");
      }
    } else {
      Fluttertoast.showToast(
        msg: "Token is missing!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      print("Token is null");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.searchfield,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.6.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
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
                padding: EdgeInsets.symmetric(horizontal: 6),
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
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

                      TwoDropdowns(),

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
              // Text(
              //   'Start Conditions',
              //   style: GoogleFonts.urbanist(
              //       color: ColorConstants.blackcolor,
              //       fontSize: 13.sp,
              //       fontWeight: FontWeight.w600),
              // ),
              // SizedBox(
              //   height: 0.5.h,
              // ),
              // _startcondition(),
              // SizedBox(
              //   height: 2.h,
              // ),
              // Text(
              //   'End Conditions',
              //   style: GoogleFonts.urbanist(
              //       color: ColorConstants.blackcolor,
              //       fontSize: 13.sp,
              //       fontWeight: FontWeight.w600),
              // ),
              // SizedBox(
              //   height: 0.5.h,
              // ),
              // _endcondition(),
              // SizedBox(
              //   height: 2.h,
              // ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Color(0xffdadada),
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
                      print('>>>>>>>>>>>>>>>>>>>>>>>>>>');
                      sendTenantData();
                      // if (_formKey.currentState!.validate()) {
                      //   print('>>>>>>>>>>>>>>>>>>>>>>>>>>');
                      //   // print(_firstname.text);
                      //   // print(_lastname.text);
                      //   // print(_emailtenant.text);
                      //   // print(_phonenumbertenant.text);
                      //   // print(_totalnumbers.text);
                      //   // print(_state.text);
                      //   // print(_city.text);
                      //   // print(_zipcode.text);
                      //   // print(_address.text);
                      //   // print(_startDateController.text);
                      //   // print(_endDateController.text);
                      //   // sendTenantData();
                      // } else {
                      //   print('Fill whole details');
                      // }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 16),
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
    );
  }

  Widget _startcondition() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffDADADA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xffDADADA), width: 1)),
          child: Center(
              child: Image.asset(
            'assets/icons/upload.png',
            height: 40,
          )),
        ),
      ),
    );
  }

  Widget _endcondition() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffDADADA),
              border: Border.all(color: Color(0xffDADADA), width: 1)),
          child: Center(
              child: Image.asset(
            'assets/icons/upload.png',
            height: 40,
          )),
        ),
      ),
    );
  }

  Widget Documents() {
    return GestureDetector(
      onTap: _pickfile,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DottedBorder(
            color: Colors.black,
            strokeWidth: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                  child: Image.asset(
                'assets/icons/upload.png',
                height: 40,
              )),
            )),
      ),
    );
  }

  Widget enddate() {
    return Container(
      child: TextFormField(
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
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Select End Date',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
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
            child: Icon(Icons.calendar_today, color: ColorConstants.textcolor),
          ),
        ),
      ),
    );
  }

  Widget startdate() {
    return Container(
      margin: EdgeInsets.only(bottom: 16), // Spacing between fields
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
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Select Start Date',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
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
            child: Icon(Icons.calendar_today, color: ColorConstants.textcolor),
          ),
        ),
      ),
    );
  }

  Widget address() {
    return Container(
      child: TextFormField(
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
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter Property Address',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
        ),
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
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter Zipcode',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

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
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter City',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
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
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter State',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  Widget country() {
    return Container(
      child: TextFormField(
        controller: _country,
        readOnly: true, // Makes the field read-only
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: Color(0xffdadada),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText:
              'India', // Optional, since 'India' is already the default value
          hintStyle: GoogleFonts.urbanist(
            color: ColorConstants.blackcolor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffdadada), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffdadada), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffdadada), width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffdadada), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffdadada), width: 1),
          ),
        ),
      ),
    );
  }

  Widget _chhosefile() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffDADADA), width: 1),
        ),
        child: Container(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffE9E9E9),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Choose File',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                      color: Color(0xff00000),
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                _filePath.isNotEmpty
                    ? 'File Path: $baseValue'
                    : 'No file selected',
                style: GoogleFonts.urbanist(
                    color: Color(0xffABABAB),
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _tenantemail() {
    return TextFormField(
      controller: _emailtenant,
      keyboardType: TextInputType.name,
      validator: emailValidator,
      style: TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Email Address',
        hintStyle: TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xff192252), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xff192252), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xff192252), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xff192252), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xff192252), width: 1)),
      ),
    );
  }

  Widget _phonenumber() {
    return Container(
      child: TextFormField(
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
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter Phone number',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  Widget _totalmembers() {
    return Container(
      child: TextFormField(
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
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Enter Phone number',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  Widget _firstName() {
    return Container(
      child: TextFormField(
        controller: _firstname,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null; // Return null if validation is successful
        },
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'select property',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }

  Widget _lastName() {
    return Container(
      child: TextFormField(
        controller: _lastname,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null; // Return null if validation is successful
        },
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'select property',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffdadada), width: 1)),
        ),
      ),
    );
  }
}
