import 'dart:convert';
import 'package:careercoach/Widgets/App_Bar_Widget.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';
import '../Config.dart';
import 'package:http/http.dart' as http;

import '../Home Page.dart';
import '../Models/myActivityModel.dart';
import 'My Profile/Profile.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String mobileNumber = '';
  String useridnum = '';
  String? userId;
  List<String> contentPrefs = [];
  final List<String> items = [
    'Student',
    'Professional',
    'Organization',
    'Other'
  ];
  final List<String> age = ['20 - 25', '25 - 35', '35+'];
  String? selectedValue;
  String? selectedValue1;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  var jsonData;
  var eventDetails;
  List<int>? eventDetails1;
  List<int>? eventDetails2;
  List<int>? eventDetails3;
  List dataa1 = [];

  Future takePhoto(ImageSource source) async {
    try {
      final pickedFile = (await _picker.pickImage(
        source: source,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 100,
      ));
      setState(() => _imageFile = File(pickedFile?.path ?? ''));
    } on PlatformException catch (e) {
      debugPrint('Failed to pick Image: $e');
    }
  }

  List<String> selectedButtonList1 = [];
  List<String> selectedButtonList2 = [];
  List<String> selectedButtonList3 = [];
  List<String> selectedButtonList4 = [];
  String selectedButtonText = '';
  // List<int> selected = [];
  List<int> selectedList1 = [];
  List<int> selectedList2 = [];
  List<int> selectedList3 = [];
  List<int> selectedList4 = [];

  void selectedButtonsList1(val, index) {
    setState(() {
      selectedButtonText = val.toString();
      if (selectedButtonList1.contains(selectedButtonText) &&
          selectedList1.contains(index)) {
        selectedButtonList1.remove(selectedButtonText);
        selectedList1.remove(index);
      } else {
        selectedButtonList1.add(selectedButtonText);
        selectedList1.add(index);
      }
    });
  }

  Future<void> _loadMobileNumber() async {
    mobileNumber =
        (await SharedPreferencesHelper.getMobileNumber()) ?? "Not set";
    setState(() {});
  }

  Future<void> _loadUserId() async {
    useridnum = (await SharedPreferencesHelper.getUserId()) ?? "Not set";
    setState(() {});
  }

  void selectedButtonsList2(val, index) {
    setState(() {
      selectedButtonText = val.toString();
      if (selectedButtonList2.contains(selectedButtonText) &&
          selectedList2.contains(index)) {
        selectedButtonList2.remove(
            selectedButtonText); // Remove the item if it's already selected
        selectedList2.remove(index);
      } else {
        selectedButtonList2
            .add(selectedButtonText); // Add the item if it's not selected
        selectedList2.add(index);
      }
    });
  }

  void selectedButtonsList3(val, index) {
    setState(() {
      selectedButtonText = val.toString();
      if (selectedButtonList3.contains(selectedButtonText) &&
          selectedList3.contains(index)) {
        selectedButtonList3.remove(
            selectedButtonText); // Remove the item if it's already selected
        selectedList3.remove(index);
      } else {
        selectedButtonList3
            .add(selectedButtonText); // Add the item if it's not selected
        selectedList3.add(index);
      }
    });
  }

  void selectedButtonsList4(val, index) {
    setState(() {
      selectedButtonText = val.toString();
      if (selectedButtonList4.contains(selectedButtonText) &&
          selectedList4.contains(index)) {
        selectedButtonList4.remove(
            selectedButtonText); // Remove the item if it's already selected
        selectedList4.remove(index);
      } else {
        selectedButtonList4
            .add(selectedButtonText); // Add the item if it's not selected
        selectedList4.add(index);
      }
    });
  }

  void postData() async {
    // Constructing the JSON payload
    Map<String, dynamic> data = {
      "USER_ID": userId.toString(),
      "NAME": nameController.text,
      "EMAIL": mailController.text,
      // "userGender": selectedValue.toString(),
      // "userAge": selectedValue1.toString(),
      // "userLocation": _output.toString(),
      // "mobileNumber": mobileNumber,
      // "contentPref": contentPrefs.toString(),
      // "notificationPrefs": selectedButtonList4.toString()
    };
    print(data.toString());

    // Encoding the JSON payload
    String jsonData = jsonEncode(data);
    print(jsonData.toString() + ">>>>>>>>>>>>>>>>>>>");

    // Sending the POST request
    try {
      http.Response response = await http.post(
        Uri.parse('https://psmprojects.net/cadworld/postuserprofile'),
        body: jsonData,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.toString());
      print(response.headers);

      // Checking the response
      if (response.statusCode == 200) {
        print('Data posted successfully');
        print(response.body);
      } else {
        print('Failed to post data. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }

  Widget bottomSheet(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.camera),
                label: const Text(
                  "Camera",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.image),
                label: const Text(
                  "Gallery",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadMobileNumber();
    fetchUserId();
    super.initState();
  }

  String _output = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController iAmController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  bool isLoading = false;
  String? _directoryPath;
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _saveAsFileName;
  bool _userAborted = false;
  FileType _pickingType = FileType.any;
  bool _multiPick = true;
  String? _extension;
  bool _isLoading = false;
  String? Address;
  String? location;
  String? latitude;
  String? longitude;
  String? phoneNumber;

  Future<void> _loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneNumber = prefs.getString('phone_number');
    });
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
        });
      });
    }
  }

  void fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);
    print(userId.toString() + '>>>>>>>>>>>>>>>>>>');
    // Once you have the userId, update the UI
   
  }

  void displayAlert4(context, data) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.location_on,
                size: 28,
              ),
              color: Colors.black,
              alignment: Alignment.topRight,
            ),
            RichText(
                text: TextSpan(
                    text: 'Allow',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    children: [
                  TextSpan(
                      text: ' "CAD Career Coach" ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  TextSpan(
                    text: 'to access your location?',
                  )
                ]))
          ]),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),

            // width: double.maxFinite,
            height: 160,
            child: Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(241, 241, 241, 1),
                  ),
                  child: Text(
                    'Allow While Using App',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(241, 241, 241, 1),
                  ),
                  child: Text(
                    'Always Allow',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(241, 241, 241, 1),
                  ),
                  child: Text(
                    'Don`t Allow',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _pickFiles() async {
    _paths = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    ))
        ?.files;

    if (_paths != null && _paths!.isNotEmpty) {
      if (_paths![0].extension == 'pdf') {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PdfViewerPage(file: _paths![0]),
        //   ),
        // );
      } else {
        // Handle DOC and DOCX files or show an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Only PDF files are supported for viewing')),
        );
      }
    }
    setState(() {});
  }

  Future<void> _uploadImage(File image) async {
    setState(() {
      _isUploading = true;
    });

    // Extract file name from the image path
    String fileName = image.path.split('/').last;

    // Construct the upload URL
    String uploadUrl = 'https://psmprojects.net/cadworld/uploads/$fileName';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          _isUploading = false;
        });
        print('Image uploaded successfully');
      } else {
        setState(() {
          _isUploading = false;
        });
        print('Image upload failed with status code: ${response.statusCode}');
        // Log response body for further inspection
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      print('Error uploading image: $e');
    }
  }

  bool isAlphabetic(String char) {
    return RegExp(r'[a-zA-Z]').hasMatch(char);
  }

  List<MyActivityModel> FavoriteList = [];

  //GET CALL >>>>>>>>>

  bool colorBool = false;

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }
  }

  String? validateEmail123(String? email) {
    RegExp emailRegex = RegExp(
        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    GroupButtonController controller1 =
        GroupButtonController(selectedIndexes: selectedList1);
    GroupButtonController controller2 =
        GroupButtonController(selectedIndexes: selectedList2);
    GroupButtonController controller3 =
        GroupButtonController(selectedIndexes: selectedList3);
    GroupButtonController controller4 =
        GroupButtonController(selectedIndexes: selectedList4);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Config.containerColor,
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                },
              ),
            ),
            actions: [
              Center(
                child: Text(
                  'My Profile',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: Config.primaryTextColor),
                ),
              ),
              // (FavoriteList[0].favPath["MODULE_NAME"] == {widget.title}) ?
              InkWell(
                onTap: () {
                  debugPrint("Tapped On PostFav Call");
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 17),
                  child: InkWell(
                    child: Icon(
                      Icons.star_outline_rounded,
                      color: (colorBool == false)
                          ? Colors.black
                          : Config.goldColor,
                    ),
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     debugPrint("Tapped On PostFav Call");
              //     postFavourite();
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.only(left: 10,right: 17),
              //     child: InkWell(
              //       child: Icon(Icons.star_outline_rounded,
              //         color: Config.goldColor,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //profileimage
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 49,
                          backgroundColor: Colors.grey.shade400,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : AssetImage("assets/images/profileimg.png")
                                  as ImageProvider,
                        ),
                        Positioned(
                          right: 2,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  builder: (context) => bottomSheet(context),
                                  barrierColor: Colors.grey.withOpacity(0.5),
                                  isDismissible: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        if (_imageFile != null)
                          Positioned(
                            right: 2,
                            bottom: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_imageFile != null && !_isUploading) {
                                  _uploadImage(_imageFile!);
                                }
                              },
                              child: _isUploading
                                  ? CircularProgressIndicator()
                                  : Text('Upload'),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 1.9.h,
                  ),

                  //Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name*',
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
                            border: Border.all(color: Config.mainBorderColor)),
                        child: TextFormField(
                          controller: nameController,
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
                  SizedBox(height: 0.8.h),

                  //what am i

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mail ID*',
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
                            border: Border.all(color: Config.mainBorderColor)),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            controller: mailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Mail ID',
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: validateEmail,
                            // initialValue:'Messina@gmail.com',style: TextStyle(fontSize: 12.sp),cursorColor: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  //what am i

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'What am I',
                        style: TextStyle(fontSize: 12.sp, color: Colors.black),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButton2(
                            dropdownElevation: 5,
                            isExpanded: true,
                            hint: const Text(
                              'Select',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            selectedItemHighlightColor: Colors.lightGreen,
                            underline: Container(),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Column(
                                        children: [
                                          //Divider(thickness: 2,),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 3.w, top: 0.7.h),
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          //Divider(color: Colors.black,),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 5.w,
                            ),
                            iconSize: 30,
                            iconEnabledColor: Colors.black,
                            buttonHeight: 4.h,
                            buttonWidth: 30.w,
                            buttonPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1, color: Config.mainBorderColor),
                              color: Colors.white,
                            ),
                            buttonElevation: 0,
                            itemHeight: 30,
                            itemPadding: const EdgeInsets.only(
                                left: 1, right: 1, top: 0, bottom: 0),
                            dropdownWidth: 30.5.w,
                            dropdownMaxHeight: 100.h,
                            dropdownPadding: null,
                            //EdgeInsets.all(1),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.grey.shade100,
                            ),
                            offset: const Offset(0, 0),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Age',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          DropdownButton2(
                            dropdownElevation: 5,
                            isExpanded: true,
                            hint: Text(
                              'Select',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            selectedItemHighlightColor: Colors.lightGreen,
                            underline: Container(),
                            items: age
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Column(
                                        children: [
                                          // SizedBox(height: 1.3.h,),
                                          //Divider(thickness: 2,),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.w, top: 0.7.h),
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          //Divider(color: Colors.black,),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue1,
                            onChanged: (value) {
                              setState(() {
                                selectedValue1 = value as String;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 5.w,
                            ),
                            iconSize: 30,
                            iconEnabledColor: Colors.black,
                            buttonHeight: 4.h,
                            buttonWidth: 25.w,
                            buttonPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1, color: Config.mainBorderColor),
                              color: Colors.white,
                            ),
                            buttonElevation: 0,
                            itemHeight: 30,
                            itemPadding: const EdgeInsets.only(
                                left: 1, right: 1, top: 0, bottom: 0),
                            dropdownWidth: 30.5.w,
                            dropdownMaxHeight: 100.h,
                            dropdownPadding: null,
                            //EdgeInsets.all(1),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.grey.shade100,
                            ),
                            offset: const Offset(0, 0),
                          ),
                        ],
                      )
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
                      /*Container(
                            width: 70.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Config.mainBorderColor)),
                            child: TextFormField(
                              controller: locationController,
                              // readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Location',
                                contentPadding: EdgeInsets.all(10),
                              ),
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(255),
                                FilteringTextInputFormatter.singleLineFormatter
                              ],
                              // initialValue:'987632109',style: TextStyle(fontSize: 12.sp,color: Config.purple),cursorColor: Colors.black
                            ),
                          ),*/
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Config.mainBorderColor)),
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
                                      _output,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.inter(),
                                    )),
                              ),
                              InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                      'assets/images/locationn.png'),
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

                  //phone number

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
                          height: 5.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: Config.mainBorderColor)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${mobileNumber}",
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  //My CV

                  Row(
                    children: [
                      Text(
                        'My CV',
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                      ),
                      SizedBox(width: 7.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(
                                    top: 12, bottom: 12, right: 8, left: 8),
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                            onPressed: () => _pickFiles(),
                            child: const Text(
                              'Upload',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black),
                            ),
                          ),
                          Text(
                            '*pdf, doc',
                            style: TextStyle(fontSize: 9.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: 3.0),
                      Visibility(
                        visible: _paths != null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.bottomRight,
                              height: 50.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _paths?[0].name ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.lightBlue[900],
                                ),
                              ),
                            ),
                            Icon(
                              Icons.done_all_outlined,
                              size: 15.0,
                              color: Colors.lightBlue[900],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //multiple selec tion
                  Divider(),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ElevatedButton(
                          //   onPressed: () {
                          //     debugPrint("print:'''${controller1}");
                          //     debugPrint(
                          //         "Print:::${controller1.selectedIndexes}");
                          //     List preferenceValues = [];
                          //     preferenceValues
                          //         .add(controller1.selectedIndexes);
                          //     debugPrint("print:'''${preferenceValues}");
                          //   },
                          //   child: Text('press button'),
                          // ),
                          Text(
                            'Content Preferences',
                            style: TextStyle(
                                color: Config.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GroupButton(
                            controller: controller1,
                            isRadio: false,
                            options: GroupButtonOptions(
                              textAlign: TextAlign.center,
                              borderRadius: BorderRadius.circular(8),
                              buttonHeight: 5.h,
                              runSpacing: 12,
                              textPadding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              spacing: 10,
                              selectedTextStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              unselectedTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              unselectedColor: Config.containerColor,
                              selectedColor: Config.careerCoachButtonColor,
                            ),
                            onSelected: (
                              val,
                              index,
                              selectColor,
                            ) {
                              selectedButtonsList1(val, index);
                              debugPrint(
                                  'Button: $val index: $index $selectColor');
                            },
                            buttons: ["Civil", "Mechanical", "Architecture"],
                          ),
                          SizedBox(
                            height: 2.w,
                          ),
                          GroupButton(
                            controller: controller2,
                            isRadio: false,
                            options: GroupButtonOptions(
                              textAlign: TextAlign.center,
                              runSpacing: 10,
                              borderRadius: BorderRadius.circular(8),
                              buttonHeight: 5.h,
                              textPadding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              spacing: 20,
                              selectedTextStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              unselectedTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              unselectedColor: Config.containerColor,
                              selectedColor: Config.careerCoachButtonColor,
                            ),
                            onSelected: (
                              val,
                              index,
                              selectColor,
                            ) {
                              selectedButtonsList2(val, index);
                              debugPrint(
                                  'Button: $val index: $index $selectColor');
                            },
                            buttons: const ["Jobs", "Internships", "Tutorials"],
                          ),
                          SizedBox(
                            height: 2.w,
                          ),
                          GroupButton(
                            controller: controller3,
                            isRadio: false,
                            options: GroupButtonOptions(
                              textAlign: TextAlign.center,
                              groupingType: GroupingType.wrap,
                              runSpacing: 10,
                              borderRadius: BorderRadius.circular(8),
                              buttonHeight: 5.h,
                              textPadding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              spacing: 15,
                              selectedTextStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Config.primaryTextColor,
                              ),
                              unselectedTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              unselectedColor: Config.containerColor,
                              selectedColor: Config.careerCoachButtonColor,
                            ),
                            onSelected: (
                              val,
                              index,
                              selectColor,
                            ) {
                              selectedButtonsList3(val, index);
                              debugPrint(
                                  'Button: $val index: $index $selectColor');
                            },
                            buttons: ["Colleges", "Career guide"],
                          ),
                          SizedBox(
                            height: 3.w,
                          ),
                          Divider(
                            height: 25,
                          ),
                          SizedBox(
                            height: 3.w,
                          ),
                          Text(
                            'Notification Preferences',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Config.grey),
                          ),
                          SizedBox(
                            height: 3.w,
                          ),
                          GroupButton(
                              controller: controller4,
                              isRadio: false,
                              options: GroupButtonOptions(
                                textAlign: TextAlign.center,
                                groupingType: GroupingType.wrap,
                                borderRadius: BorderRadius.circular(8),
                                buttonHeight: 5.h,
                                textPadding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                spacing: 15,
                                selectedTextStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                unselectedTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                unselectedColor: Config.containerColor,
                                selectedColor: Config.careerCoachButtonColor,
                              ),
                              onSelected: (
                                val,
                                index,
                                selectColor,
                              ) {
                                selectedButtonsList4(val, index);
                                debugPrint(
                                    'Button: $val index: $index $selectColor');
                              },
                              buttons: ["Mail", "SMS", "Push"]),
                        ]),
                  ),

                  SizedBox(
                    height: 1.5.h,
                  ),

                  //submit button

                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.only(
                                  top: 12, bottom: 12, right: 8, left: 8)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black),
                          ))),
                      onPressed: () async {
                        contentPrefs.addAll(selectedButtonList1);
                        contentPrefs.addAll(selectedButtonList2);
                        contentPrefs.addAll(selectedButtonList3);
                        print(_imageFile.toString());
                        print(userId.toString());
                        print(nameController.text);
                        print(mailController.text);
                        print(selectedValue.toString());
                        print(selectedValue1.toString());
                        print(_output.toString());
                        print(mobileNumber);
                        print(contentPrefs.toString());
                        print(selectedButtonList4.toString());
                        postData();

                        nameController.clear();
                        mailController.clear();
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
