import 'dart:convert';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Home Page.dart';
import '../Models/headerModel.dart';
import '../Widgets/App_Bar_Widget.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final nameController = TextEditingController();
  final mailidController = TextEditingController();
  final subjectController = TextEditingController();
  final detailController = TextEditingController();
  List<headerModel> headerList = [];
  String? _Value1;
  List? info;
  var jsonData;
  String content = '';
  String? userId;
  Future<void> _loadUserId() async {
    userId = (await SharedPreferencesHelper.getUserId()) ?? "Not set";
    setState(() {});
  }

  //GET CALL >>>>>>>>>

  Future getProfileDetails() async {
    final response =
        await http.get(Uri.parse('${Config.baseURL}my-profile/13'));
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

      debugPrint("Profile Details ++ ${jsonData}");
      // debugPrint("Profile Details profId:: ++ ${jsonData['profiledetails']['profId']}");
    } else {
      debugPrint('get call error');
    }
  }

  //POST CALL>>>>>>>>>>>>>>>>

  Future<void> postQuestion() async {
    debugPrint(userId.toString());
    debugPrint("Printing Data:1: ${nameController.text}");
    debugPrint("Printing Data:1: ${mailidController.text}");
    debugPrint("Printing Data:1: ${subjectController.text}");
    debugPrint("Printing Data:1: ${detailController.text}");
    debugPrint("Printing Data:1: ${selectedValue}");
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postenquiry/endpoint.php');
//`userId`, `username`, `emailid`, `reason`, `subject`, `enquiredOn`
    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': userId.toString(),
          'NAME': nameController.text,
          'MAIL_ID': mailidController.text,
          'REASON': selectedValue,
          'SUBJECT': subjectController.text,
          "DETAILS": detailController.text,
        },
      );

      if (response.statusCode == 200) {
        // selectedValue = '';
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
                        selectedValue = '';
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
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

  //
  Future HeaderList() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listheaders'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];

      setState(() {
        headerList = jsonData
                .map<headerModel>((data) => headerModel.fromJson(data))
                .toList() ??
            [];

        String input = "${headerList[12].headerName}";

        // Define a regular expression pattern to match "<b>" and "</b>"
        // RegExp regExp = RegExp(r"<b>|<\/b>", multiLine: true);

        // Use the replaceAll method to remove the matched patterns
        // content = input.replaceAll(regExp, '');
        // debugPrint("headerList?[12].headerName:::$content");
      });
      debugPrint('GetCall Success');
      debugPrint('GetCall Success Printing:: ${content}');
      debugPrint('printing json data headers, $jsonData');
      debugPrint('printing header List, ${headerList[12].headerName}');
      debugPrint(
          'printing header Content List, ${headerList[12].headerContent}');
    } else {
      debugPrint('get call error');
    }
  }

  //`userId`, `username`, `emailid`, `reason`, `subject`, `enquiredOn`

  @override
  void initState() {
    _loadUserId();
    getProfileDetails();
    HeaderList();
    loadJson();
    // TODO: implement initState
    super.initState();
  }

  // cleanText = strInputCode.replace(/<\/?[^>]+(>|$)/g, "");

  Future loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/contactus.json');
    debugPrint("Checking map: jsonMap");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      info = jsonMap["data"];
    });
  }

  final List<String> items = [
    'General Inquiry',
    'Corporate Training',
    'Course Details',
    // 'Demo Class'
    'Other',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.3.h),
          child: App_Bar_widget3(
            image: ('assets/images/dhyanacademy-logo.png'),
          ),
        ),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: (headerList.length == 0)
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
              : ListView(
                  children: [
                    (info == null)
                        ? const Center(child: CircularProgressIndicator())
                        : Image.asset(info?[0]["image"], height: 20.h),
                    (headerList == null)
                        ? CircularProgressIndicator()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 17, bottom: 11),
                                child: Text(
                                  headerList[12].headerName ?? '',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Html(
                                    data: headerList[12].headerContent,
                                    shrinkWrap: true,
                                    style: {
                                      "n": Style(
                                          textOverflow: TextOverflow.ellipsis),
                                      "b": Style(
                                          before: "\n\n",
                                          after: "\n\n",
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSize.large),
                                    },
                                  )
                                  // Text(
                                  //   headerList[12].headerContent?.replaceAll(
                                  //           r'/<\/?[^>]+(>|$)(<b>)(</b>)/g',
                                  //           "") ??
                                  //       '',
                                  //   overflow: TextOverflow.ellipsis,
                                  //   maxLines: 15,
                                  // ),
                                  ),
                              Divider(thickness: 1),
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 15),
                                child: Text(
                                  'Book your free slot to attend demo sessions.',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xff433EB4),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 8),
                                child: Text(
                                  'Book your free slot to attend demo sessions.',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xff433EB4)),
                                ),
                              ),
                              Center(
                                child: Container(
                                  height: 14.h,
                                  width: 92.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xffD6F2A4),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.w, bottom: 3, top: 4),
                                        child: Text(
                                          'Reach us at :',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 3.w, top: 1.h),
                                        child: Row(
                                          children: [
                                            // SizedBox(width: 3.w),
                                            Icon(Icons.phone_in_talk_outlined),
                                            Text(info?[0]["text3"] ?? ''),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.w, top: 1.h),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon:
                                                    Icon(Icons.email_outlined)),
                                            Text(info?[0]["text4"] ?? ''),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: Text(
                                  'Drop your Enquiry:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              //Name
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 4.06.w, right: 4.06.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Name*',
                                      style: TextStyle(fontSize: 11.sp),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(bottom: 3),
                                        height: 5.h,
                                        width: 73.8.w,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0xffEBEBEB))),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 6),
                                            child: Text(
                                              nameController.text,
                                              style: GoogleFonts.inter(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.9.h,
                              ),
                              //Mail ID
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 4.06.w, right: 4.06.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Mail ID*',
                                      style: TextStyle(fontSize: 11.sp),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(bottom: 3),
                                        height: 5.h,
                                        width: 73.8.w,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0xffEBEBEB))),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 6),
                                            child: Text(
                                              mailidController.text,
                                              style: GoogleFonts.inter(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.9.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 4.06.w),
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.06.w, right: 3.w),
                                      child: Text(
                                        'Reason*',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Color(0xff1F1F39),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Container(
                                        height: 4.h,
                                        width: 33.w,
                                        child: DropdownButton2(
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
                                          ),
                                          selectedItemHighlightColor:
                                              Colors.lightGreen,
                                          underline: Container(),
                                          items: items
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
//Divider(thickness: 2,),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 2.w),
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                              debugPrint(
                                                  "selectedValue is :: $selectedValue");
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
                                          buttonPadding: const EdgeInsets.only(
                                              left: 5, right: 10),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                width: 1,
                                                color: Config.mainBorderColor),
                                            color: Colors.white,
                                          ),
                                          buttonElevation: 0,
                                          itemHeight: 30,
                                          itemPadding: const EdgeInsets.only(
                                              left: 1,
                                              right: 1,
                                              top: 0,
                                              bottom: 0),
                                          dropdownWidth: 35.5.w,
                                          dropdownMaxHeight: 100.h,
                                          dropdownPadding: null,
//EdgeInsets.all(1),
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            color: Colors.grey.shade100,
                                          ),
                                          offset: const Offset(0, 0),
                                        )),
                                    SizedBox(
                                      width: 110,
                                      child: Visibility(
                                        visible: (selectedValue == 'Other')
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 4.w),
                                          child: Container(
                                            height: 4.h,
                                            width: 75.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                border: Border.all(
                                                    color: Config
                                                        .mainBorderColor)),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 10, bottom: 15),
                                                  border: InputBorder.none,
                                                  hintText: 'opted text',
                                                  hintStyle: TextStyle(
                                                      fontSize: 11.sp)),
                                              style: TextStyle(
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                              onChanged: (String? value) {
                                                selectedValue = value as String;
                                                debugPrint(
                                                    "selectedValue is :: $selectedValue");
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.9.h,
                              ),
                              //Subject
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 4.06.w, right: 4.06.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Subject',
                                      style: TextStyle(fontSize: 11.sp),
                                    ),
                                    Container(
                                      height: 5.h,
                                      width: 73.8.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xffEBEBEB))),
                                      child: TextFormField(
                                        textAlign: TextAlign.left,
                                        cursorColor: Colors.black,
                                        controller: subjectController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(11),
                                          hintText: "Subject",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Config.containerColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Config.mainBorderColor),
                                          ),
                                        ),
                                        //labelText: 'Enter 10 digit mobile number',
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.9.h,
                              ),
                              //Detail
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 4.06.w, right: 4.06.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xffEBEBEB))),
                                      child: TextFormField(
                                        textAlign: TextAlign.left,
                                        cursorColor: Colors.black,
                                        controller: detailController,
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: "Please enter details....",
                                          // enabledBorder: UnderlineInputBorder(
                                          //   borderSide: BorderSide(color: Config.containerColor),
                                          // ),
                                          // focusedBorder: UnderlineInputBorder(
                                          //   borderSide: BorderSide(color: Config.mainBorderColor),
                                          // ),
                                        ),
                                        //labelText: 'Enter 10 digit mobile number',
                                        keyboardType: TextInputType.multiline,
                                        maxLength: 250,
                                        maxLines: 10,
                                        inputFormatters: <TextInputFormatter>[
                                          LengthLimitingTextInputFormatter(250),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Container(
                                height: 5.h,
                                // width: 1.w,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 4.w, left: 74.w, top: 1.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 3,
                                    
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xff999999)),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                    ),
                                    onPressed: () {
                                      if (subjectController.text.isNotEmpty &&
                                          detailController.text.isNotEmpty &&
                                          selectedValue != null) {
                                        postQuestion();
                                      } else {
                                        var snackBar = SnackBar(
                                            backgroundColor: Colors.white,
                                            content: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey.shade200),
                                              child: Text(
                                                'Please Fill Reason, Subject and Details To submit!!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize:
                                                        Config.font_size_12.sp,
                                                    color: Colors.red),
                                              ),
                                            ));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        debugPrint(
                                            "please enter subject field and detail field");
                                      }
                                      // postQuestion();
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Result()));
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                            ],
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
