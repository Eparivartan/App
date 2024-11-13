import 'dart:convert';
import 'package:careercoach/Home%20Page.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final nameController = TextEditingController();
  final mailidController = TextEditingController();
  final subjectController = TextEditingController();
  final detailController = TextEditingController();

  String? _Value1;
  String? Useridnum;
  List? info;
  var jsonData;

  //GET CALL >>>>>>>>>

  Future getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String Useridnum = await prefs.getString('userId') ?? '';
    debugPrint("came with UserId to Contact_Us Page : $Useridnum");

    final response =
        await http.get(Uri.parse('${Config.baseURL}my-profile/$Useridnum'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      // var jsonData = jsonDecode(response.body)["profiledetails"];

      setState(() {
        nameController.text =
            ('${jsonData['profiledetails']['profileName']}') ?? '';
        mailidController.text =
            ('${jsonData['profiledetails']['emailId']}') ?? '';
      });

      // getAskExpertDetails(0);
      debugPrint("Profile Details ++ ${jsonData}");
      // debugPrint("Profile Details profId:: ++ ${jsonData['profiledetails']['profId']}");
    } else {
      debugPrint('get call error');
    }
  }

  //POST CALL>>>>>>>>>>>>>>>>

  Future<void> postQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String Useridnum = await prefs.getString('userId') ?? '';

    print(Useridnum.toString() + '>>>>>>>>>>>>>>>>>>>>>');
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postquery/endpoint.php');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': Useridnum,
          'NAME': nameController.text,
          'MAIL_ID': mailidController.text,
          'SUBJECT': subjectController.text,
          "DETAILS": detailController.text,
        },
      );

      if (response.statusCode == 200) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Success!!",
                  ),
                  content: const Text(
                      "You Question has been successfully submitted!!"),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        subjectController.clear();
                        detailController.clear();
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

  @override
  void initState() {
    getProfileDetails();
    loadJson();
    // TODO: implement initState
    super.initState();
  }

  bool colorBool = false;
  //POST CALL>>>>>>>>>>>>>>>>

  Future<void> postFavourite() async {
    Useridnum = (await SharedPreferencesHelper.getUserId()) ?? "Not set";
    print(Useridnum.toString());

    print(Useridnum.toString());
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postmyfavourite/endpoint.php');

    print(url.toString() + '>>>>>>>>>');
    print(Useridnum.toString() + '<><><><><><>');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': Useridnum.toString(),
          'PATH': jsonEncode({
            'ROOT1': "Contact Us",
          }),
        },
      );
      print(response.toString());
      print(response.body.toString());
      print(response.statusCode.toString());

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

  final List<String> items = [
    'Job Posting',
    'AdSpace Booking',
    'Content Contribution',
    'Academic Workshops',
    'For Placements',
    'Other'
  ];
  Future loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/contact.json');
    debugPrint("Checking map: jsonMap");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      info = jsonMap["data"];
    });
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(6.h),
            child: AppBar(
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ),
              actions: [
                Center(
                  child: Text(
                    'Contact Us',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Config.primaryTextColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 17),
                  child: InkWell(
                    child: Icon(
                      Icons.star_outline_rounded,
                      color: Color(0xff000000),
                    ),
                    onTap: () {
                      postFavourite();
                    },
                  ),
                ),
              ],
            )),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: ListView(
            children: [
              (info == null)
                  ? Center(
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
                  : Image.asset("assets/images/homedesign.png", height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(info?[0]["data"] ?? "",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14.sp,
                        )),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(info?[0]["data1"] ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        )),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'What we offer...',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(info?[0]["text"] ?? ''),
                    SizedBox(
                      height: 1.h,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Want to collaborate? Need our services?',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Reach us at :',
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone_in_talk_outlined),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(info?[0]["text3"] ?? ''),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Icon(Icons.email_outlined),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(info?[0]["text4"] ?? ''),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Drop your Enquiry:',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    //Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name*',
                          style: TextStyle(fontSize: 11.sp),
                        ),
                        Container(
                          height: 4.h,
                          width: 73.8.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 1, color: Color(0xffEBEBEB))),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            controller: nameController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(11),
                              hintText: "Name",
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Config.containerColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Config.mainBorderColor),
                              ),
                            ),
                            //labelText: 'Enter 10 digit mobile number',
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.9.h,
                    ),
                    //Mail ID
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mail ID*',
                          style: TextStyle(fontSize: 11.sp),
                        ),
                        Container(
                          height: 4.h,
                          width: 73.8.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 1, color: Color(0xffEBEBEB))),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            controller: mailidController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(11),
                              hintText: "Mail ID",
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Config.containerColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Config.mainBorderColor),
                              ),
                            ),
                            //labelText: 'Enter 10 digit mobile number',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.9.h,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Reason*',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Color(0xff1F1F39),
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                            height: 4.h,
                            width: 33.w,
                            child: DropdownButton2(
                              dropdownElevation: 5,
                              isExpanded: true,
                              hint: Text(
                                'Select',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Config.primaryTextColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              selectedItemHighlightColor: Colors.lightGreen,
                              underline: Container(),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 1.h,
                                            ),
//Divider(thickness: 2,),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 2.w),
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 11.sp,
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
                              buttonWidth: 68.5.w,
                              buttonPadding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    width: 1, color: Config.mainBorderColor),
                                color: Colors.white,
                              ),
                              buttonElevation: 0,
                              itemHeight: 30,
                              itemPadding: const EdgeInsets.only(
                                  left: 1, right: 1, top: 0, bottom: 0),
                              dropdownWidth: 45.5.w,
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
                            )),
                        SizedBox(
                          width: 110,
                          child: Visibility(
                            visible: (selectedValue == 'Other') ? true : false,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: Container(
                                height: 4.h,
                                width: 75.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: Config.mainBorderColor)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 10, bottom: 15),
                                      border: InputBorder.none,
                                      hintText: 'opted text',
                                      hintStyle: TextStyle(fontSize: 11.sp)),
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  onChanged: (String? value) {},
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.9.h,
                    ),
                    //Subject
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subject',
                          style: TextStyle(fontSize: 11.sp),
                        ),
                        Container(
                          height: 4.h,
                          width: 73.8.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 1, color: Color(0xffEBEBEB))),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            controller: subjectController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(11),
                              hintText: "Subject",
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Config.containerColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Config.mainBorderColor),
                              ),
                            ),
                            //labelText: 'Enter 10 digit mobile number',
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.9.h,
                    ),
                    //Detail
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Detail',
                          style: TextStyle(fontSize: 11.sp),
                        ),
                        Container(
                          height: 15.4.h,
                          width: 73.8.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 1, color: Color(0xffEBEBEB))),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            controller: detailController,
                            decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText:
                                  "Lorem Ipsum is simply dummy text \nof the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s.",
                              // enabledBorder: UnderlineInputBorder(
                              //   borderSide: BorderSide(color: Config.containerColor),
                              // ),
                              // focusedBorder: UnderlineInputBorder(
                              //   borderSide: BorderSide(color: Config.mainBorderColor),
                              // ),
                            ),
                            //labelText: 'Enter 10 digit mobile number',
                            keyboardType: TextInputType.multiline,
                            maxLength: 55,
                            maxLines: null,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(50),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(''),
                        Container(
                          width: 28.3.w,
                          height: 4.3.h,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xff00000029),
                                  blurRadius: 5.0,
                                ),
                              ],
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: const Color(0XFF999999), width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
