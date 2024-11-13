import 'dart:convert';
import 'dart:io';

import 'package:careercoach/Calculator/keyboard.dart';
import 'package:careercoach/Config.dart';
import 'package:careercoach/Config.dart';
import 'package:careercoach/Home%20Page.dart';
import 'package:careercoach/config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'sharepreferences/sharedpreferences.dart';

class GetProfileScreen extends StatefulWidget {
  @override
  _GetProfileScreenState createState() => _GetProfileScreenState();
}

class _GetProfileScreenState extends State<GetProfileScreen> {
  final TextEditingController _profileNameController = TextEditingController();
  final TextEditingController _profileemailController = TextEditingController();
  final TextEditingController _profilegenderController =
      TextEditingController();
  final TextEditingController _profileageController = TextEditingController();
  final TextEditingController _profilemobileController =
      TextEditingController();
  // Instance variables to hold profile details
  String? profileName;
  String? emailId;
  String? userAge;
  String? userGender;
  String? userLocation;
  String? userCV;
  String? contentPref;
  String? notificationPrefs;
  String? userPhoto;
  String? addedOn;
  String? phoneNumber;
  String? userId;
  String? _selectedValue;
  String? _selectedValue1;
  String? _output;
  String? _pdfPath;
  String? pdf;
  String? userpdfview;
  String? profile;
  String? concatenatedSelectedStrings;
  File? _imageFile;
  String? _imageUrl;
  String? selectedValue;
  String? selectedValue1;
  String? user;
  String? whereami;
  String? userage;
  String? userinformatio;
  String? pdfedit;
  bool isEditinggender = false;
  bool isEditingage = false;

  final List<String> age = ['20 - 25', '25 - 35', '35+'];
  final List<String> items = [
    'Student',
    'Professional',
    'Organization',
    'Other'
  ];
  List<String> gender = ['Profisional', 'student', 'other'];
  List<String> contprefstring = [
    'Civil',
    'Mechanical',
    'Architecture',
    'Jobs',
    'Internships',
    'Tutorials',
    'Colleges',
    'Career guide'
  ];
  final List<String> _options = ['SMS', 'Email', 'Push'];
  final List<String> _selectedValues = [];

  List<bool>? selected;

  List<String> selectedStrings = [];

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Pick Image from Camera'),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pick Image from Gallery'),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not given");
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      placemarkFromCoordinates(
              currentPosition.latitude, currentPosition.longitude)
          .then((placemarks) {
        var output = 'No results found.';
        if (placemarks.isNotEmpty) {
          print(placemarks);
          output =
              '${placemarks[0].locality}, ${placemarks[0].subLocality}, ${placemarks[0].thoroughfare}, ${placemarks[0].name}';
        }
        setState(() {
          _output = output;
          userLocation = _output;
        });
      });
    }
  }

  //pf file
  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf',],
    );

    if (result != null) {
      setState(() {
        PlatformFile file = result.files.single;

        _pdfPath = file.path;

        if (_pdfPath != null) {
          String splitPath = _pdfPath!
              .split(
                  '/data/user/0/com.eparivartan.careercoach/cache/file_picker/')
              .last;
          print('Filename: ${file.name}');
          print('File size: ${file.size} bytes');
          print('Temp file path: $_pdfPath');

          pdf = splitPath.toString();
          print(pdf.toString() + 'pdfpdfpdfpdfpdf');
        }
      });
    }
  }

  // Method to fetch profile details
  Future<void> getProfileDetails() async {
    user = (await SharedPreferencesHelper.getUserId()) ?? "Not set";
    final response = await http
        .get(Uri.parse('https://psmprojects.net/cadworld/my-profile/$user'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      GetProfileDetails profileDetails = GetProfileDetails.fromJson(jsonData);

      if (profileDetails.profiledetails != null) {
        setState(() {
          profileName = profileDetails.profiledetails!.profileName;
          emailId = profileDetails.profiledetails!.emailId;
          userAge = profileDetails.profiledetails!.userAge;
          userGender = profileDetails.profiledetails!.userGender;
          userLocation = profileDetails.profiledetails!.userLocation;
          userCV = profileDetails.profiledetails!.userCV;
          contentPref = profileDetails.profiledetails!.contentPref;
          notificationPrefs = profileDetails.profiledetails!.notificationPrefs;
          userPhoto = profileDetails.profiledetails!.userPhoto;
          addedOn = profileDetails.profiledetails!.addedOn;
          phoneNumber = profileDetails.profiledetails!.phoneNumber;
        });

        setState(() {
          _profileNameController.text = profileName.toString();
          _profileemailController.text = emailId.toString();
          _selectedValue = userGender.toString();
          _selectedValue1 = userAge.toString();
          _profilemobileController.text = phoneNumber.toString();
          userpdfview = userCV.toString();
        });

        // Now you can use these string variables as needed in your app.
        print('Profile Name: $profileName');
        print('Email ID: $emailId');
        // Print other variables similarly if needed
      }
    } else {
      throw Exception('Failed to load profile details');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch profile details when the widget initializes
    getProfileDetails();
    selected = List<bool>.filled(contprefstring.length, false);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  bool colorBool = false;
  //POST CALL>>>>>>>>>>>>>>>>

  Future<void> postFavourite() async {
    debugPrint("CAME TO PostTrail call");
    user = (await SharedPreferencesHelper.getUserId()) ?? "Not set";
    final url = Uri.parse(
        'https://psmprojects.net/cadworld/home/postmyfavourite/endpoint.php');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': user.toString(),
          'PATH': jsonEncode({
            'ROOT1': "Edit Profile",
          }),
        },
      );

      if (response.statusCode == 200) {
        colorBool = true;
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Success!!",
                  ),
                  content: const Text("Added to Favorite's successfully!!"),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff8CB93D)),
                      //return false when click on "NO"
                      child: const Text('OK'),
                    ),
                  ],
                ));
        print('Response data: ${response.body}');
      } else {
        print('Error - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending POST request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> contentPrefList =
        contentPref != null ? contentPref!.split(' ') : [];
    List<String> selectedItems = [];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFFF9F9FB),
        leadingWidth: 85,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: InkWell(
            child: Image.asset(
              'assets/images/logo.png',
              height: 6.1.h,
              width: 22.6.w,
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
        ),
        actions: [
          Center(
            child: Text(
              'Edit Profile',
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF333333)),
            ),
          ),
          InkWell(
            onTap: () {
              debugPrint("Tapped On PostFav Call");
              postFavourite();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 17),
              child: InkWell(
                child: Icon(
                  Icons.star_outline_rounded,
                  color:
                      (colorBool == false) ? Colors.black : Color(0xffffdf00),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : _imageUrl != null
                            ? NetworkImage(_imageUrl!)
                            : NetworkImage(
                                    'https://psmprojects.net/cadworld/$userPhoto')
                                as ImageProvider,
                  ),
                  Positioned(
                    bottom: 1,
                    right: 3,
                    child: IconButton(
                        onPressed: _showImagePickerOptions,
                        icon: Icon(
                          Icons.camera,
                          color: Colors.black,
                          size: 35,
                        )),
                  )
                ],
              ),
            ),

            //     : Center(
            //         child: CircleAvatar(
            //           radius: 50,
            //           backgroundImage: AssetImage('assets/images/1234.png'),
            //         ),
            //       ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.black),
                ),
                Container(
                  width: 70.w,
                  // height: 5.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black)),
                  child: TextFormField(
                    controller: _profileNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      contentPadding: EdgeInsets.all(10),
                    ),
                    // initialValue:'Messina Cake',style: TextStyle(fontSize: 12.sp,color:Config.purple),cursorColor: Colors.black
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.black),
                ),
                Container(
                  width: 70.w,
                  // height: 5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: TextFormField(
                    controller: _profileemailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      contentPadding: EdgeInsets.all(10),
                    ),
                    // initialValue:'Messina Cake',style: TextStyle(fontSize: 12.sp,color:Config.purple),cursorColor: Colors.black
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            isEditinggender
                ? Row(
                    children: [
                      Text(
                        'What am I',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.sp,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: 'Student',
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          Radio<String>(
                            value: 'Others',
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          Text('Others'),
                        ],
                      ),
                      Text('Student'),
                      Radio<String>(
                        value: 'Professional',
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                      Text('Professional'),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        'What am I',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.sp,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        _selectedValue.toString(),
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isEditinggender = true;
                          });
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),

            isEditingage
                ? Row(
                    children: [
                      Text(
                        'Age',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                            color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Spacer(),
                      Radio<String>(
                        value: '15-35',
                        groupValue: selectedValue1,
                        onChanged: (value) {
                          setState(() {
                            selectedValue1 = value;
                          });
                        },
                      ),
                      Text('15-35'),
                      Radio<String>(
                        value: '25-35',
                        groupValue: selectedValue1,
                        onChanged: (value) {
                          setState(() {
                            selectedValue1 = value;
                          });
                        },
                      ),
                      Text('25-35'),
                      Radio<String>(
                        value: '35+',
                        groupValue: selectedValue1,
                        onChanged: (value) {
                          setState(() {
                            selectedValue1 = value;
                          });
                        },
                      ),
                      Text('35+'),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        'Age',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                            color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        _selectedValue1.toString(),
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            isEditingage = true;
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ))
                    ],
                  ),

            SizedBox(
              height: 1.h,
            ),
            //Location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Location',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.black),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    height: 5.h,
                    width: 70.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Container(
                              width: 160,
                              child: Text(
                                userLocation.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.inter(),
                              )),
                        ),
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Image.asset('assets/images/locationn.png'),
                          ),
                          onTap: _getCurrentPosition,
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            //Mobile Number
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mobile',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.black),
                ),
                Container(
                  width: 70.w,
                  // height: 5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: TextFormField(
                    controller: _profilemobileController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      contentPadding: EdgeInsets.all(10),
                    ),
                    // initialValue:'Messina Cake',style: TextStyle(fontSize: 12.sp,color:Config.purple),cursorColor: Colors.black
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 1.h,
            ),

            Text(
              '* Our team will help you on relevant job openings',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: Colors.grey),
            ),
            SizedBox(height: 2.h),

            Row(
              children: [
                Text(
                  'My CV',
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
                SizedBox(
                  width: 7.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _pickPDF,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Text(
                          'Upload',
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _pdfPath != null
                        ? GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 100,
                              height: 15,
                              child: Text(
                                pdf.toString(),
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 100,
                              height: 15,
                              child: Text(
                                userCV.toString(),
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              ],
            ),
            SizedBox(height: 2.h),

            Text(
              'Selected Content Preferences',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp),
            ),

            SizedBox(
              height: 1.5.h,
            ),

            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5),
              itemCount: contprefstring.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected![index] = !selected![index];
                      if (selected![index]) {
                        selectedStrings.add(contprefstring[index]);
                      } else {
                        selectedStrings.remove(contprefstring[index]);
                      }
                    });
                  },
                  child: GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected![index] ? Colors.green : Colors.white,
                        border: Border.all(
                          color: selected![index] ? Colors.green : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          contprefstring[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              color: selected![index]
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(
              height: 3.w,
            ),
            Text(
              'Notification Preferences',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 3.w,
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView.builder(
                itemCount: _options.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  final option = _options[index];
                  final isSelected = _selectedValues.contains(option);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedValues.remove(option);
                        } else {
                          _selectedValues.add(option);
                        }
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 20,
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Clear the list before adding selected items
                  selectedStrings.clear();

                  for (int i = 0; i < selected!.length; i++) {
                    if (selected![i]) {
                      print(_profileNameController.text);
                      print(_profileemailController.text);
                      print(selectedValue.toString());
                      print(selectedValue1.toString());
                      print(userLocation.toString());
                      print(_profilemobileController.text);
                      print(pdf.toString());
                      print(_imageFile!.path);
                      selectedStrings.add(contprefstring[i]);
                      print(_selectedValues.toString());
                      setState(() {
                        concatenatedSelectedStrings =
                            selectedStrings.join(", ");
                         whereami = _selectedValue == null ? selectedValue.toString():_selectedValue.toString();
                         userage = _selectedValue1 == null ? selectedValue1.toString():_selectedValue1.toString();
                         userinformatio = userPhoto.toString() == null ? _imageFile!.path:userPhoto.toString();
                         pdfedit = userCV.toString() == null ? pdf.toString():userCV.toString();
                            
                      });
                      print(concatenatedSelectedStrings);
                    }
                  }
                  postUserProfile();
                  print(selectedStrings);
                },
                child: Text('Edit Profile'),
              ),
            ),
          ])),
    );
  }
void postUserProfile() async {
  try {
    if (_pdfPath == null) {
      print('No PDF file selected');
      return;
    }

    // Get the application documents directory
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    // Path to save the PDF file
    String pdfPath = _pdfPath!; // Use the selected file path directly
    print('PDF path: $pdfPath');

    File pdfFile = File(pdfPath);

    // Check if the PDF file exists and its size
    if (await pdfFile.exists()) {
      print('PDF file exists');
      print('PDF file size: ${await pdfFile.length()} bytes');
    } else {
      print('PDF file does not exist');
      return;
    }

    // Print the PDF file's properties
    print('PDF file path: ${pdfFile.path}');
    print('PDF file size: ${await pdfFile.length()} bytes');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://www.psmprojects.net/cadworld/Home/postuserprofile'),
    );
    print('Multipart request prepared');

    // Add fields to the request and print their values
    request.fields['NAME'] = _profileNameController.text;
    print('NAME: ${_profileNameController.text}');
    request.fields['EMAIL'] = _profileemailController.text;
    print('EMAIL: ${_profileemailController.text}');
    request.fields['userGender'] = whereami.toString();
    print('userGender: ${whereami.toString()}');
    request.fields['userAge'] = userage.toString();
    print('userAge: ${userage.toString()}');
    request.fields['LOCATION'] = userLocation.toString();
    print('LOCATION: ${userLocation.toString()}');
    request.fields['mobile'] = _profilemobileController.text;
    print('mobile: ${_profilemobileController.text}');
    request.fields['contentpref'] = concatenatedSelectedStrings.toString();
    print('contentpref: ${concatenatedSelectedStrings.toString()}');
    request.fields['notificationPrefs'] = _selectedValues.toString();
    print('notificationPrefs: ${_selectedValues.toString()}');
    request.fields['USER_ID'] = user.toString();
    print('USER_ID: ${user.toString()}');
    print('Fields added to request');

    // Add PDF file to the request
    var pdfMultipartFile = await http.MultipartFile.fromPath('userCV', pdfFile.path);
    request.files.add(pdfMultipartFile);
    print('PDF file added to request');

    // Check if image file exists and add it to the request
    if (_imageFile != null) {
      var imageMultipartFile = await http.MultipartFile.fromPath('Profile_img', _imageFile!.path);
      request.files.add(imageMultipartFile);
      print('Image file added to request');
    }

    // Set headers if needed
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });
    print('Headers set');

    // Send the request and get the response
    var response = await request.send();
    print('Request sent');
    print(response.toString());

    // Handle the response
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print('Response status: ${response.statusCode}');
      print('Response data: $responseData');
      print('Image name: $_imageFile');
      // Example navigation after successful response
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('API not hit successfully: $e');
  }
}

}

class GetProfileDetails {
  Profiledetails? profiledetails;

  GetProfileDetails({this.profiledetails});

  GetProfileDetails.fromJson(Map<String, dynamic> json) {
    profiledetails = json['profiledetails'] != null
        ? new Profiledetails.fromJson(json['profiledetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profiledetails != null) {
      data['profiledetails'] = this.profiledetails!.toJson();
    }
    return data;
  }
}

class Profiledetails {
  String? profId;
  String? userId;
  String? profileName;
  String? emailId;
  String? userAge;
  String? userGender;
  String? userLocation;
  String? userCV;
  String? contentPref;
  String? notificationPrefs;
  String? userPhoto;
  String? addedOn;
  String? phoneNumber;

  Profiledetails(
      {this.profId,
      this.userId,
      this.profileName,
      this.emailId,
      this.userAge,
      this.userGender,
      this.userLocation,
      this.userCV,
      this.contentPref,
      this.notificationPrefs,
      this.userPhoto,
      this.addedOn,
      this.phoneNumber});

  Profiledetails.fromJson(Map<String, dynamic> json) {
    profId = json['profId'];
    userId = json['userId'];
    profileName = json['profileName'];
    emailId = json['emailId'];
    userAge = json['userAge'];
    userGender = json['userGender'];
    userLocation = json['userLocation'];
    userCV = json['userCV'];
    contentPref = json['contentPref'];
    notificationPrefs = json['notificationPrefs'];
    userPhoto = json['userPhoto'];
    addedOn = json['addedOn'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profId'] = this.profId;
    data['userId'] = this.userId;
    data['profileName'] = this.profileName;
    data['emailId'] = this.emailId;
    data['userAge'] = this.userAge;
    data['userGender'] = this.userGender;
    data['userLocation'] = this.userLocation;
    data['userCV'] = this.userCV;
    data['contentPref'] = this.contentPref;
    data['notificationPrefs'] = this.notificationPrefs;
    data['userPhoto'] = this.userPhoto;
    data['addedOn'] = this.addedOn;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
