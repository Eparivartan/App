import 'dart:convert';

import 'package:careercoach/College%20Information/result.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Models/collegeInfo.dart';
import '../Models/softwareInUseModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import 'package:http/http.dart' as http;

import 'nationalFields.dart';

class InternationalFields extends StatefulWidget {
  String value;
  InternationalFields({Key? key, required this.value}) : super(key: key);

  @override
  State<InternationalFields> createState() => _InternationalFieldsState();
}

class _InternationalFieldsState extends State<InternationalFields> {
  String? selectedValue;
  String? userId;

  var jsonData;
  var jsonData1;

  List<CountryDisplayModel> countryList = [];
  List<CourseDisplayModel> courseList = [];
  List<CollegeSearchResultModel> collegeList = [];
  List<CollegeSearchResultModel> recommendedCollegeList = [];
  List fullStateList = [];
  List fullStateIdList = [];
  List totalCollegeNames = [];
  List fullCourseList = [];
  List<BranchDropdownModel> branchDropdown = [];

  final List<String> items = [
    'National',
    'International',
  ];

  //GET CALLS

  Future getCountryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString('userId') ?? '';
    debugPrint("came with UserId to National_pg : $userId");

    final response =
        await http.get(Uri.parse('${Config.baseURL}listcountries'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body)["getcountries"];
      // var jsonDetails = jsonDecode(response.body)["getstates"];
      setState(() {
        countryList = jsonData
                .map<CountryDisplayModel>(
                    (data) => CountryDisplayModel.fromJson(data))
                .toList() ??
            [];
        // getQuestionPaperDetails(0);
      });

      debugPrint("Profile Details ++ ${jsonData}");
      debugPrint("Profile fullStateList ++ ${fullStateList}");

      // debugPrint("Profile Details profId:: ++ ${jsonData['profiledetails']['profId']}");
    } else {
      debugPrint('get call error');
    }
  }

  Future getCourseData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString('userId') ?? '';
    debugPrint("came with UserId to National_pg : $userId");

    final response = await http
        .get(Uri.parse('${Config.baseURL}listinternationalcoursetype'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body)["getcoursetype"];
      // var jsonDetails = jsonDecode(response.body)["getstates"];
      setState(() {
        courseList = jsonData
                .map<CourseDisplayModel>(
                    (data) => CourseDisplayModel.fromJson(data))
                .toList() ??
            [];
        // getQuestionPaperDetails(0);
      });

      for (var i = 0; i < courseList.length; i++) {
        fullCourseList.add(courseList[i].courseName);
        // return fullStateList;
      }

      debugPrint("Profile Details ++ ${jsonData}");
      debugPrint("Profile fullStateList ++ ${courseList}");
      debugPrint("Profile fullCourseList::(((( ++  ))))  ${fullCourseList}");
      debugPrint("Profile Details(((( ++  ))))  ${fullCourseList}");

      // debugPrint("Profile Details profId:: ++ ${jsonData['profiledetails']['profId']}");
    } else {
      debugPrint('get call error');
    }
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
            'ROOT1': "InterNationalFields",
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

  Future getBranchDetails() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listcategory'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];

      setState(() {
        branchDropdown = jsonData
                .map<BranchDropdownModel>(
                    (data) => BranchDropdownModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json BranchDropdown Model, ${branchDropdown}');
    } else {
      debugPrint('getDetails get call error');
    }
    //debugPrint("Fresher2Industry123 : $branchDropdown");
    // debugPrint("Service Details : $serviceDetails");
  }

  //Get Call After search
  Future getCollegeOutput() async {
    debugPrint("printing ${widget.value}");
    debugPrint("printing ${selectedValue1}");
    debugPrint("printing ${selectedValue2}");
    debugPrint("printing ${selectedValue3}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString('userId') ?? '';
    debugPrint("came with UserId to National_pg : $userId");

    final response = await http.get(Uri.parse(
        '${Config.baseURL}listcollegesearch/${selectedValue1.toString()}/${selectedValue2.toString()}/${selectedValue3.toString()}'));
    final responseRecomended = await http.get(Uri.parse(
        '${Config.baseURL}intercollegerecommendations/${selectedValue1.toString()}/${selectedValue2.toString()}/${selectedValue3.toString()}'));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body)["getcolleges"];
      jsonData1 = jsonDecode(responseRecomended.body)["getcolleges"];
      setState(() {
        collegeList = jsonData
                .map<CollegeSearchResultModel>(
                    (data) => CollegeSearchResultModel.fromJson(data))
                .toList() ??
            [];
        recommendedCollegeList = jsonData1
                .map<CollegeSearchResultModel>(
                    (data) => CollegeSearchResultModel.fromJson(data))
                .toList() ??
            [];
        // debugPrint("Profile fullStateList collegeList ++ ${collegeList[0].collegeName}");
        // for(var i=0 ; i<collegeList.length ; i++){
        //   totalCollegeNames.add(collegeList[i].collegeName);
        // }
        // debugPrint("Printing name list::${totalCollegeNames}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Result(
                    totalCollegeList: collegeList,
                    recommendedCollege: recommendedCollegeList)));
      });

      debugPrint("Profile ::: Details:::: ++ ${jsonData}");
      debugPrint("Profile fullStateList ++ ${courseList}");
      debugPrint("Profile fullCourseList::(((( ++  ))))  ${fullCourseList}");
      debugPrint("Profile Details(((( ++  ))))  ${fullCourseList}");

      // debugPrint("Profile Details profId:: ++ ${jsonData['profiledetails']['profId']}");
    } else {
      debugPrint('get call error');
    }
  }

  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;

  @override
  void initState() {
    getCountryData();
    getCourseData();
    getBranchDetails();
    // TODO: implement initState
    super.initState();
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
                Image.asset(
                  'assets/images/collegeInformation.png',
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 17, left: 13, right: 13, top: 17),
                  child: Text(
                    'CAD Career Coach provides you with the whole collection of data '
                    'pertaining to universities, colleges to help your educational needs',
                    style: TextStyle(
                      fontSize: 11.sp,
                    ),
                  ),
                ),
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
                //Search
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
                            value: widget.value,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });

                              if (selectedValue == 'National') {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NationalFields(value: 'National')));
                              } else {
                                Navigator.pushReplacement(
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
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text('Search*',
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12,right: 24,top: 8,bottom: 8),
                      child: Container(
                        height: 5.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xffffffff),
                          border: Border.all(width: 1,
                            color:Color(0xfff1f1f1),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child:DropdownButton2(
                            icon: Icon(Icons.keyboard_arrow_down_rounded,
                              color: Color(0xff000000),
                            ),
                            // barrierColor: Color(0xfff0bf4e).withOpacity(0.2),
                            // selectedItemHighlightColor: Color(0xfff0bf4e).withOpacity(0.4),
                            isExpanded: true,
                            items: items.map((items)=>
                                DropdownMenuItem<String>(
                                  value: items,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Text(items,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        // fontWeight: FontWeight.bold,
                                        color: const Color(0xff38385E),
                                      ),
                                      //  overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                            ).toList(),
                            value: widget.value,
                            // value: selectedValue,
                            onChanged: (value){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> OurRecommendations()));
                              setState(() {
                                // selectedValue= value as String;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                        'Country*',
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 5.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xffffffff),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff1f1f1),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xff000000),
                            ),
                            // barrierColor: Color(0xfff0bf4e).withOpacity(0.2),
                            // selectedItemHighlightColor: Color(0xfff0bf4e).withOpacity(0.4),
                            selectedItemHighlightColor: Color(0xff8CB93D),
                            isExpanded: true,
                            items: countryList
                                .map(
                                  (items) => DropdownMenuItem<String>(
                                    value: items.countryId,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Text(
                                        items.countryName.toString(),
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
                            value: selectedValue1,
                            onChanged: (value) {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> OurRecommendations()));
                              setState(() {
                                selectedValue1 = value as String;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Degree/Course*',
                        style: TextStyle(
                          fontSize: 10.5.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 5.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xffffffff),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff1f1f1),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xff000000),
                            ),
                            // barrierColor: Color(0xfff0bf4e).withOpacity(0.2),
                            // selectedItemHighlightColor: Color(0xfff0bf4e).withOpacity(0.4),
                            selectedItemHighlightColor: Color(0xff8CB93D),
                            isExpanded: true,
                            items: courseList
                                .map(
                                  (items) => DropdownMenuItem<String>(
                                    value: items.courseId,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Text(
                                        items.courseName.toString(),
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
                            value: selectedValue2,
                            onChanged: (value) {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> OurRecommendations()));
                              setState(() {
                                selectedValue2 = value as String;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                        'Specialization/ \nBranch*',
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 5.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xffffffff),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff1f1f1),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xff000000),
                            ),
                            // barrierColor: Color(0xfff0bf4e).withOpacity(0.2),
                            // selectedItemHighlightColor: Color(0xfff0bf4e).withOpacity(0.4),
                            selectedItemHighlightColor: Color(0xff8CB93D),
                            isExpanded: true,
                            items: branchDropdown
                                .map(
                                  (items) => DropdownMenuItem<String>(
                                    value: items.id,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Text(
                                        items.cname.toString(),
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
                            value: selectedValue3,
                            onChanged: (value) {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> OurRecommendations()));
                              setState(() {
                                selectedValue3 = value as String;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 24, left: 250),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                     
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xff999999)),
                          borderRadius: BorderRadius.circular(7)),
                    ),
                    onPressed: () {
                      if (selectedValue1 != null) {
                        getCollegeOutput();
                      } else {
                        debugPrint("Value selectedValue1 not selected");
                      }

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Result()));
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
