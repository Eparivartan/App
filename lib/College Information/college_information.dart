import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/cc_button.dart';
import '/Widgets/App_Bar_Widget.dart';
import '../Config.dart';
import 'internationalFields.dart';
import 'nationalFields.dart';
import 'our_recommendations.dart';

class CollegeInformation extends StatefulWidget {
  const CollegeInformation({Key? key}) : super(key: key);

  @override
  State<CollegeInformation> createState() => _CollegeInformationState();
}

class _CollegeInformationState extends State<CollegeInformation> {
  String? selectedValue;
  String? userId;
  final List<String> items = [
    'National',
    'International',
  ];

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "College Information",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  @override
  void initState() {
    saveToRecent();
    // TODO: implement initState
    super.initState();
  }

  bool colorBool = false;
  Future<void> postFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);

    print(userId.toString());
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postmyfavourite/endpoint.php');
    print(url.toString());

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': userId.toString(),
          'PATH': jsonEncode({
            'ROOT1': "CollegeInformation",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.3.h),
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
              actions: [
                Center(
                  child: Text(
                    'Educational Institutions / \n' ' University courses',
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 17),
                  child: InkWell(
                    onTap: () {
                      postFavourite();
                    },
                    child: Icon(
                      Icons.star_border,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ],
            )),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: Center(
            child: ListView(
              children: [
                //  SizedBox(height: 2.5.h,),
                Image.asset(
                  'assets/images/collegeInformation.png',
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 17, left: 13, right: 13, top: 17),
                  child: Text(
                    'CAD Career Coach provides you with the whole collection of data pertaining to universities, colleges to help your educational needs',
                    style: TextStyle(
                      fontSize: Config.font_size_12.sp,
                    ),
                  ),
                ),
                // SizedBox(height: 1.w,),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, bottom: 26, right: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Let us help you with refined data….!',
                        style: TextStyle(
                          fontSize: Config.font_size_12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Text(
                        'Select option(s) from below:',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: Config.font_size_12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                        'Search*',
                        style: TextStyle(
                          fontSize: Config.font_size_12.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 5.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          // color: Color(0xffffffff),
                          border:
                              Border.all(width: 1, color: Color(0xfff1f1f1)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            dropdownDecoration: BoxDecoration(
                              border: Border.all(
                                width: 0,
                                color: Color(0xfff1f1f1),
                              ),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xff000000),
                            ),
                            // barrierColor: Color(0xfff0bf4e).withOpacity(0.2),
                            selectedItemHighlightColor: Color(0xff8CB93D),
                            isExpanded: true,
                            items: items
                                .map(
                                  (items) => DropdownMenuItem<String>(
                                    value: items,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Text(
                                        items,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          // fontWeight: FontWeight.bold,
                                          color: const Color(0xff38385E),
                                        ),
                                        //  overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });

                              if (selectedValue == 'National') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NationalFields(value: 'National')));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InternationalFields(
                                                value: 'International')));
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
