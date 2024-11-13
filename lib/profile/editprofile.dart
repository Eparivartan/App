import 'dart:convert';
import 'dart:io';
import 'package:commercilapp/homepage/home.dart';
import 'package:path/path.dart' as path;
import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/profile/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../constant/imageconstant.dart';

class EditProfile extends StatefulWidget {
  final userDetails;
  const EditProfile({super.key, required, this.userDetails});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  String? _userlastname;
  String? _useremail;
  String? _username;
  String? _token;
  String? _uid;
  String? _userphone;
  String? _userimage;
  String? fileName;
  String? baseFileName;
  String? updateimage;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _editfirstnamecontroller =
      TextEditingController();
  final TextEditingController _editlastnamecontroller = TextEditingController();
  final TextEditingController _editphonenumbercontroller =
      TextEditingController();
  final TextEditingController _editmailidcontroller = TextEditingController();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();
  }

  void _showBottomSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

Future<void> _pickImage(ImageSource source) async {
  final pickedFile = await _picker.pickImage(source: source);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });

    // Extract the base file name from the full path
    final baseFileName = path.basename(_image!.path);
    print("Extracted filename: $baseFileName");

    setState(() {
      updateimage = baseFileName != null
          ? baseFileName
          : _userimage ;
    });
    print("Updated image value: $updateimage >>>>>>>>>>>>>>>>");
  }
}

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('userFirstName');
      _userlastname = prefs.getString('userLastName');
      _useremail = prefs.getString('userEmail');

      _userphone = prefs.getString('userMobile');
      _userimage =
          prefs.getString('userImage'); // Assuming 'userImage' is for image url

      _token = prefs.getString('token');
      _uid = prefs.getString('uid');

      _editfirstnamecontroller.text = _userlastname ?? '';
      _editlastnamecontroller.text =
          _username ?? ''; // Assuming username is first name
      _editphonenumbercontroller.text = _userphone ?? 'Enter ur mobile number';
      // Set phonenumber from token, uid, or another key if available
      _editmailidcontroller.text =
          _useremail ?? ''; // Assuming 'userid' is for phone number
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: 65),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: (() {
                          Navigator.pop(context);
                        }),
                        child: Image.asset(
                          ImageConstants.ARROWBACK,
                          height: 30,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          border: Border.all(
                            color: ColorConstants.bordercolor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(ImageConstants.HOME, height: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : NetworkImage(
                                  'https://mycommercialpal.com/${_userimage.toString()}')
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: -2,
                      right: 1,
                      child: IconButton(
                        onPressed: () {
                          _showBottomSheet();
                        },
                        icon: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Image.asset(
                            ImageConstants.EDIT,
                            height: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorConstants.secondaryColor,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: TextFormField(
                    controller: _editfirstnamecontroller,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      color: ColorConstants.textcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: ColorConstants.whiteColor,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      hintText: 'FirstName',
                      hintStyle: TextStyle(
                          color: ColorConstants.textcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  child: TextFormField(
                    controller: _editlastnamecontroller,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      color: ColorConstants.textcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Last name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: ColorConstants.whiteColor,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      hintText: 'LastName',
                      hintStyle: TextStyle(
                          color: ColorConstants.textcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  child: TextFormField(
                    controller: _editphonenumbercontroller,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          10), // Limit to 10 characters
                      FilteringTextInputFormatter
                          .digitsOnly, // Allow only numbers
                    ],
                    style: TextStyle(
                      color: ColorConstants.textcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Phone';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: ColorConstants.whiteColor,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(
                          color: ColorConstants.textcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  child: TextFormField(
                    controller: _editmailidcontroller,
                    keyboardType: TextInputType.name,
                    validator: emailValidator,
                    style: TextStyle(
                      color: ColorConstants.textcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      fillColor: ColorConstants.whiteColor,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(
                          color: ColorConstants.textcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: ColorConstants.bordercolor, width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                GestureDetector(
                  onTap: (() {
                    if (_formKey.currentState!.validate()) {
                    
                      editProfile();
                    }
                  }),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                    child: Center(
                      child: Text('Save',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorConstants.whiteColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editProfile() async {
    final url = Uri.parse("https://mycommercialpal.com/api-editprofile.php");

    // Define form fields
    final fields = {
      'userfirstname': _editfirstnamecontroller.text,
      'userlastname': _editlastnamecontroller.text,
      'emailid': _editmailidcontroller.text,
      'usermobile': _editphonenumbercontroller.text,
      'userid': _uid,
      'userImage': updateimage.toString()
    };

    try {
      // Make the POST request
      final response = await http.post(url, body: fields);

      if (response.statusCode == 200) {
        // Assuming success is determined by response body content
        final responseBody = response.body;

        if (responseBody.contains("success")) {
         
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        } else {
          // Show error if edit profile was not successful
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Edit Profile"),
              content: Text("Profile update was not successful."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            ),
          );
        }
      } else {
        // Handle error for non-200 status code
        throw Exception("Failed to connect to the server");
      }
    } catch (e) {
      // Display error if request fails
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Error"),
          content: Text("An error occurred: $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }



Future<void> updateUserProfile() async {
  var url = Uri.parse('https://mycommercialpal.com/api-editprofile.php');

  // Prepare the request
  var request = http.MultipartRequest('POST', url)
    ..fields['userfirstname'] = _editfirstnamecontroller.text
    ..fields['userlastname'] =  _editlastnamecontroller.text
    ..fields['emailid'] = _editmailidcontroller.text
    ..fields['usermobile'] = _editmailidcontroller.text
    ..fields['userid'] = _uid.toString()
    ..files.add(await http.MultipartFile.fromPath(
      'userImage',
     updateimage.toString(),
      filename: path.basename(updateimage.toString()),
    ));

  // Send the request
  var response = await request.send();

  // Handle the response
  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    var decodedData = jsonDecode(responseData);
    print('Success: ${decodedData['success']}');
    print('Message: ${decodedData['message']}');
    print('Received Data: ${decodedData['received_data']}');
  } else {
    print('Failed to update profile. Status code: ${response.statusCode}');
  }
}
  
}


//  await prefs.setString('userlastname', data['userlastname']);
//     await prefs.setString('useremail', data['useremail']);
//     await prefs.setString('username', data['username']);
//     await prefs.setString('userphone', data['usermobile']);


