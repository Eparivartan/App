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
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';
import '../Config.dart';
import 'package:http/http.dart' as http;

import '../Home Page.dart';
import '../Models/myActivityModel.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final List<String> items = [
    'Student',
    'Professional',
    'Organization',
    'Other'
  ];
  final List<String> age = ['20 - 25', '25 - 35', '35+'];
  String? selectedValue;
  String? selectedValue1;
  String? Useridnum;
  List profileDetails = [];
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  List? userDetails;
  List getUserDetails = [];
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



  Future getProfileDetails() async {
    Useridnum = (await SharedPreferencesHelper.getUserId()) ?? "Not set";
    print(Useridnum.toString());
    final url = 'https://psmprojects.net/cadworld/my-profile/$Useridnum';

    print(url + '<<<<<<<<<<<<<<<<<<<<<<');
    final response = await http.get(Uri.parse(url));
    print(response.statusCode.toString());
    print(Useridnum.toString() + '|||||||||||||||||||||||||||||||||');

    if (response.statusCode == 200) {
      try {
        jsonData = jsonDecode(response.body);
        debugPrint("Printing data came in get call: ${jsonData}");
        setState(() {
          nameController.text = jsonData['profiledetails']['profileName'] ?? '';
          mailController.text = jsonData['profiledetails']['emailId'] ?? '';
          _mobileController.text =
              jsonData['profiledetails']['phoneNumber'] ?? '';
          _output = jsonData['profiledetails']['userLocation'] ?? '';
          selectedValue = jsonData['profiledetails']['userGender'] ?? '';
          selectedValue1 = jsonData['profiledetails']['userAge'] ?? '';

          eventDetails = jsonDecode(jsonData["profiledetails"]["contentPref"]);
          debugPrint("contentPref_array : $eventDetails");
          debugPrint("content_array123 : ${eventDetails["CONTENT_PREFS_1"]}");
          debugPrint(
              "content_array123 : ${eventDetails["CONTENT_PREFS_1"][0]}");
          debugPrint(
              "content_array123 : ${eventDetails["CONTENT_PREFS_1"][1]}");
        });
        print(nameController.text);
        print(mailController.text);
        print(locationController.text);
        debugPrint("Profile Details ++ $jsonData");
      } catch (e) {
        debugPrint('Error parsing JSON: $e');
        debugPrint('Response body: ${response.body}');
      }
    } else {
      debugPrint('get call error with status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
    }
  }

  Future<void> profilesetup(String USER_PHOTO, String FULL_NAME, String EMAIL,
      String GENDER, String AGE, String LOCATION, String MOBILE_NUMBER) async {
    debugPrint("FULL_NAME : $FULL_NAME");
    debugPrint("EMAIL : $EMAIL");
    debugPrint("GENDER : $GENDER");
    debugPrint("AGE : $AGE");
    debugPrint("LOCATION : $LOCATION");
    debugPrint("MOBILE_NUMBER : $MOBILE_NUMBER");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString('userId') ?? '';
    String mobile = await prefs.getString('MOBILE_NUMBER') ?? '';

    // var stream =
    //     http.ByteStream(.typed(_imageFile?.openRead()));
    // var length = await _imageFile?.length();
    //
    // var img = http.MultipartFile(
    //   "image",
    //   stream,
    //   length!,
    //   filename: _imageFile?.path,
    // );

    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.baseURL + 'home/postmyprofile'));
    request.fields['userId'] = userId;
    // request.fields['USER_PHOTO'] = base64UrlEncode(_imageFile!.readAsBytesSync());
    request.fields['USER_PHOTO'] = USER_PHOTO;
    request.fields['profileName'] = FULL_NAME;
    request.fields['EMAIL'] = EMAIL;
    request.fields['AGE'] = AGE;
    request.fields['GENDER'] = GENDER;
    request.fields['LOCATION'] = LOCATION;
    request.fields['mobileNo'] = MOBILE_NUMBER;
    request.fields['MY_CV'] = '';
    request.fields['CONTENT_PREFS'] = jsonEncode({
      "CONTENT_PREFS_1": "${(selectedButtonList1.toString())}",
      "CONTENT_PREFS_2": "${(selectedButtonList2.toString())}",
      "CONTENT_PREFS_3": "${(selectedButtonList3.toString())}",
    });
    request.fields['NOTIFICATION_PREFS'] =
        '${(selectedButtonList4.toString())}';

    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'USER_PHOTO', _imageFile?.path ?? ''));
    }

    // var file = await http.MultipartFile.fromPath('file', '/path/to/your/file.jpg');
    // request.files.add(file);

    var res = await request.send();
    var response = await http.Response.fromStream(res);

    if (response.statusCode == 200) {
      debugPrint("Came to success of uploadDataAndFile post call");
      debugPrint("Came to success & printing body: ${response.body}");

      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const MyProfile()));
    } else if (response.statusCode == 401) {
      debugPrint("Came to failed - uploadDataAndFile post call");
      // debugPrint('failed');
      debugPrint(response.body);
    }

    // var response = await request.send();
    // if (response.statusCode == 200) {
    //   print('Uploaded!');
    // } else {
    //   print('Failed to upload');
    // }
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

  getAssetName(data) {
    if (_imageFile != null) {
      return FileImage(File(_imageFile!.path));
    } else if ((userDetails?.length ?? 0) < 1) {
      return const AssetImage('assets/images/profile.png');
    } else if (data[0]["userPhoto"] != null) {
      return NetworkImage(data[0]["userPhoto"] ?? "");
    } else {
      return const AssetImage('assets/images/profile.png');
    }
  }

  Widget roundedProfileImage(BuildContext context) {
    return Stack(children: <Widget>[
      _imageFile != null
          ? CircleAvatar(
              radius: 33,
              backgroundImage:
                  getAssetName(AssetImage('assets/images/profileimg.png')),
            )
          : CircleAvatar(
              radius: 40,
              backgroundImage:
                  ("${jsonData['profiledetails']["userphoto"]}" == null)
                      ? getAssetName(AssetImage('assets/images/profileimg.png'))
                      : NetworkImage(Config.imageURL +
                          ('${jsonData['profiledetails']["userphoto"]}'))),
    ]);
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
          output = placemarks[0].locality.toString();
        }
        setState(() {
          _output = output;
        });
      });
    }
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

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  bool isAlphabetic(String char) {
    return RegExp(r'[a-zA-Z]').hasMatch(char);
  }

  List<MyActivityModel> FavoriteList = [];

  //GET CALL >>>>>>>>>

  Future GetCallDetails() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}myfavourites/' + Useridnum.toString()));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body)["myfavourites"];
      setState(() {
        FavoriteList = jsonData
                .map<MyActivityModel>((data) => MyActivityModel.fromJson(data))
                .toList() ??
            [];
        // getQuestionPaperDetails(0);
      });
      debugPrint("GetCall Details +(<-->)+ ${jsonData}");
    } else {
      debugPrint('get call error');
    }
  }

  bool colorBool = false;
  //POST CALL>>>>>>>>>>>>>>>>

  Future<void> postFavourite() async {
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postmyfavourite/endpoint.php');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': Useridnum.toString(),
          'PATH': jsonEncode({
            'ROOT1': "MyProfile",
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
                          backgroundColor: Config.careerCoachButtonColor),
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
  void initState() {
   
    super.initState();
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
                  postFavourite();
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
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: (jsonData == null)
                ?
                // Loading
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loading',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: Config.primaryTextColor,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        const CupertinoActivityIndicator(
                          radius: 25,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  )
                :
                //
                ListView(children: [
                    // roundedProfileImage(context),
                    // Stack(
                    //   alignment: Alignment.center,
                    //   children: [
                    //     Container(
                    //       height: 10.h,
                    //     ),
                    //     roundedProfileImage(context),
                    //     Positioned(
                    //       left: 180,
                    //       top: 50,
                    //       child: CircleAvatar(
                    //         radius: 14,
                    //         backgroundColor: Colors.lightGreen,
                    //         child: IconButton(
                    //             onPressed: () {
                    //               showModalBottomSheet(
                    //                 useRootNavigator: true,
                    //                 context: context,
                    //                 builder: (context) => bottomSheet(context),
                    //                 barrierColor: Colors.grey.withOpacity(0.5),
                    //                 isDismissible: true,
                    //                 // backgroundColor: Colors.white70,
                    //                 shape: const RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.vertical(
                    //                     top: Radius.circular(10),
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //             icon: const Icon(
                    //               Icons.camera_alt,
                    //               color: Colors.white,
                    //               size: 15,
                    //             )),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 2.h,
                    ),
                    //Name
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
                              border:
                                  Border.all(color: Config.mainBorderColor)),
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
                    SizedBox(
                      height: 1.h,
                    ),
                    //MailId
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
                              border:
                                  Border.all(color: Config.mainBorderColor)),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: TextFormField(
                              controller: mailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: nameController.text == null
                                    ? 'Name'
                                    : nameController.text,
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
                    //Who am I and Age
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'What am I',
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                        SizedBox(
                          width: 2.w,
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
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
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
                                  child: Text(_output),
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
                              border:
                                  Border.all(color: Config.mainBorderColor)),
                          child: TextFormField(
                            controller: _mobileController,
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
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(
                                    top: 12, bottom: 12, right: 8, left: 8)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black),
                            ))),
                        onPressed: () {
                          // String USER_PHOTO, String FULL_NAME, String EMAIL, String GENDER, String AGE, String LOCATION, String MOBILE_NUMBER)
                          profilesetup(
                              photoController.text,
                              nameController.text,
                              mailController.text,
                              selectedValue.toString(),
                              selectedValue1.toString(),
                              _output,
                              _mobileController.text);

                          // "PHOTO" : '',
                          // "FULL_NAME" : nameController.text,
                          // "EMAIL" : mailController.text,
                          // "GENDER" : selectedValue.toString(),
                          // "AGE" : ageController.text,
                          // "LOCATION" : locationController.text,
                          // "MOBILE_NUMBER" : _mobileController.text);
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 1.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '* Our team will help you on relevant job openings',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Config.grey),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'My CV',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.only(
                                                  top: 12,
                                                  bottom: 12,
                                                  right: 8,
                                                  left: 8)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.black),
                                      ))),
                                  onPressed: () => _pickFiles(),
                                  child: const Text(
                                    'Upload',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ),
                                Text('*pdf, doc',
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: Config.grey,
                                    )),
                              ],
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Visibility(
                              visible: (_paths != null) ? true : false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    height: 5.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      _paths?[0]?.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.lightBlue[900],
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.done_all_outlined,
                                    size: 15.sp,
                                    color: Colors.lightBlue[900],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
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
                                    selectedColor:
                                        Config.careerCoachButtonColor,
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
                                  buttons: [
                                    "Civil",
                                    "Mechanical",
                                    "Architecture"
                                  ],
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
                                    selectedColor:
                                        Config.careerCoachButtonColor,
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
                                  buttons: const [
                                    "Jobs",
                                    "Internships",
                                    "Tutorials"
                                  ],
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
                                    selectedColor:
                                        Config.careerCoachButtonColor,
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
                                      selectedColor:
                                          Config.careerCoachButtonColor,
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
                      ],
                    ),
                  ]),
          )),
    );
  }
}
