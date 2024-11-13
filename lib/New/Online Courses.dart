import 'dart:convert';
import 'package:careercoach/Models/onlineCoursesModel.dart';
import 'package:careercoach/Widgets/App_Bar_Widget.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/pagination.dart';
import '../paymentScreen.dart';
import 'Online Course Explore.dart';
import 'package:http/http.dart' as http;

import 'OnlineCourse pdf.dart';

class OnlineCourses extends StatefulWidget {
  const OnlineCourses({Key? key}) : super(key: key);

  @override
  State<OnlineCourses> createState() => _OnlineCoursesState();
}

class _OnlineCoursesState extends State<OnlineCourses> {
  bool changeButtonColor = true;
  int widgetType = 1;
  List? onlinecourses;
  int selectedTile = -1;
  bool isVisible = true;
  int selectedPage = 1;
  String? userId;
  List<OnlineCoursesModel> onlineCourseList = [];
  List<MyCourseModel> myCourseList = [];
  List purchasedCourse = [];

 

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "Online Courses",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  numberOfPages1() {
    double pgNum = onlineCourseList.length / 5;
    return pgNum.ceil();
  }

  pageList1(page) {
    switch (page) {
      case 1:
        getOnlineCoursesDetails(0);
        break;
      case 2:
        getOnlineCoursesDetails(5);
        break;
      case 3:
        getOnlineCoursesDetails(10);
        break;
      case 4:
        getOnlineCoursesDetails(15);
        break;
      case 5:
        getOnlineCoursesDetails(20);
        break;
      case 6:
        getOnlineCoursesDetails(25);
        break;
      case 7:
        getOnlineCoursesDetails(30);
        break;
      case 8:
        getOnlineCoursesDetails(35);
        break;
      case 9:
        getOnlineCoursesDetails(40);
        break;
      case 10:
        getOnlineCoursesDetails(45);
        break;
      case 11:
        getOnlineCoursesDetails(50);
        break;
      case 12:
        getOnlineCoursesDetails(55);
        break;
      case 13:
        getOnlineCoursesDetails(60);
        break;
      case 14:
        getOnlineCoursesDetails(65);
        break;
      case 15:
        getOnlineCoursesDetails(70);
        break;
      case 16:
        getOnlineCoursesDetails(75);
        break;
      case 17:
        getOnlineCoursesDetails(80);
        break;
      case 18:
        getOnlineCoursesDetails(85);
        break;
      case 19:
        getOnlineCoursesDetails(90);
        break;
      case 20:
        getOnlineCoursesDetails(95);
        break;
      default:
        getOnlineCoursesDetails(100);
    }
  }

  Future getOnlineCoursesDetails(int from) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);
    print(userId.toString() + 'id+id+id');

    final response = await http
        .get(Uri.parse('${Config.baseURL}listonlinecourses/$from/5/$userId'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["onlinecourses"];
      var jsonData1 = jsonDecode(response.body)["mycourses"];
      setState(() {
        onlineCourseList = jsonData
                .map<OnlineCoursesModel>(
                    (data) => OnlineCoursesModel.fromJson(data))
                .toList() ??
            [];
        myCourseList = jsonData1
                .map<MyCourseModel>((data) => MyCourseModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json data, $jsonData1');
      debugPrint('printing json Model ReviewModel, $OnlineCoursesModel');

      for (var i = 0; i < myCourseList.length; i++) {
        purchasedCourse.add(myCourseList[i].courseId);
      }
    } else {
      debugPrint('get call error');
    }
    debugPrint("Fresher2Industry123 : $onlineCourseList");
    // debugPrint("Service Details : $serviceDetails");
  }

  paginationList() {
    return PaginationWidget(
      numOfPages: numberOfPages1(),
      selectedPage: selectedPage,
      pagesVisible: 3,
      spacing: 0,
      onPageChanged: (page) {
        debugPrint("Sending page $page");
        // pageList1(page);
        setState(() {
          selectedPage = (page);
        });
      },
      nextIcon: Icon(
        Icons.arrow_forward_ios,
        size: 12,
        color:
            selectedPage == numberOfPages1() ? Colors.grey : Color(0xff000000),
      ),
      previousIcon: Icon(
        Icons.arrow_back_ios,
        size: 12,
        color: selectedPage == 1 ? Colors.grey : Color(0xff000000),
      ),
      activeTextStyle: TextStyle(
        color: const Color(0xffffffff),
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
      ),
      activeBtnStyle: ButtonStyle(
        visualDensity: const VisualDensity(horizontal: -4),
        backgroundColor: MaterialStateProperty.all(const Color(0xff8cb93d)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
        shadowColor: MaterialStateProperty.all(
          const Color(0xfff1f1f1),
        ),
      ),
      inactiveBtnStyle: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        visualDensity: const VisualDensity(horizontal: 0),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          const Color(0xfff9f9fb),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Color(0xffffffff),
              width: 10,
            ),
          ),
        ),
      ),
      inactiveTextStyle: const TextStyle(
        fontSize: 15,
        color: Color(0xff333333),
        fontWeight: FontWeight.w700,
      ),
    );
  }

  @override
  void initState() {
  
    getData();
    saveToRecent();
    getOnlineCoursesDetails(0);
    super.initState();
  }

  changeColor(index) {
    if (index == 0 ||
        index == 5 ||
        index == 10 ||
        index == 15 ||
        index == 20 ||
        index == 25 ||
        index == 30 ||
        index == 35) {
      return const Color(0XFFFFDEB2);
    } else if (index == 1 ||
        index == 6 ||
        index == 11 ||
        index == 16 ||
        index == 21 ||
        index == 26 ||
        index == 31 ||
        index == 36) {
      return const Color(0XFFF3F5E0);
    } else if (index == 2 ||
        index == 7 ||
        index == 12 ||
        index == 17 ||
        index == 22 ||
        index == 27 ||
        index == 32 ||
        index == 37) {
      return const Color(0XFFF5D1F2);
    } else if (index == 3 ||
        index == 8 ||
        index == 13 ||
        index == 18 ||
        index == 23 ||
        index == 28 ||
        index == 33 ||
        index == 38) {
      return const Color(0XFFD0E5FF);
    } else if (index == 4 ||
        index == 9 ||
        index == 14 ||
        index == 19 ||
        index == 24 ||
        index == 29 ||
        index == 34 ||
        index == 39) {
      return const Color(0XFFFDD3D3);
    } else {
      return const Color(0XFFFFFFFF);
    }
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/OnlineCourses.json');

    //debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      onlinecourses = jsonMap["details"];

      print(onlinecourses.toString() + '?????//////>>>>>.....');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Config.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget(title: 'Online Courses'),
      ),
      body: SafeArea(
        child: (onlineCourseList.length == 0)
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
                  Padding(
                    padding: EdgeInsets.only(
                        left: 3.w, right: 3.w, top: 2.h, bottom: 2.h),
                    child: Container(
                      width: 70.w,
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'External Training Videos ',
                          style: TextStyle(
                              fontSize: Config.font_size_12.sp,
                              fontWeight: FontWeight.bold,
                              color: Config.primaryTextColor),
                        ),
                        TextSpan(
                          text: 'contains all the '
                              'collected videos from e-content and other important '
                              'university syllabus……',
                          style: TextStyle(
                              fontSize: Config.font_size_12.sp,
                              fontWeight: FontWeight.normal,
                              color: Config.primaryTextColor),
                        ),
                      ])),
                    ),
                  ),
                  (onlineCourseList.length == 0)
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
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          //const NeverScrollableScrollPhysics(),
                          itemCount: onlineCourseList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 3.w, right: 3.w, top: 0.6.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: changeColor(index),
                                  // border: Border.all(width: 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(3.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Topic Name
                                      Text(
                                        onlineCourseList?[index].courseName ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      //About
                                      Container(
                                        width: 85.w,
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: 'About: ',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Config.primaryTextColor),
                                          ),
                                          TextSpan(
                                            text: onlineCourseList?[index]
                                                .courseDescription,
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Config.primaryTextColor),
                                          ),
                                        ])),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      //Course
                                      Row(
                                        children: [
                                          Text(
                                            'Course by: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            onlineCourseList?[index].courseBy ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      //Duration
                                      Row(
                                        children: [
                                          Text('Duration: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            onlineCourseList?[index]
                                                    .courseDuration ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      //Medium
                                      Row(
                                        children: [
                                          Text('Medium of Teaching: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            onlineCourseList?[index]
                                                    .courseTraining ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      //Validity
                                      Row(
                                        children: [
                                          Text('Validity: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            onlineCourseList?[index]
                                                    .courseValidity ??
                                                'N/A',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      //Completion
                                      Row(
                                        children: [
                                          Text('Completion Certificate: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            onlineCourseList?[index]
                                                    .courseCertificate ??
                                                'N/A',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      //SME Support
                                      Row(
                                        children: [
                                          Text('SME Support/Resolving doubts: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Container(
                                            //height: 2.h,
                                            width: 20.w,
                                            child: Text(
                                              onlineCourseList?[index]
                                                      .smeSupport ??
                                                  '',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      //Course Content
                                      Row(
                                        children: [
                                          Text('Course Content: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          InkWell(
                                            onTap: () {
                                              debugPrint("Tapped on download");
                                              String urlLink =
                                                  "${Config.imageURL}${onlineCourseList?[index].courseContent.toString()}";
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OnlineCoursesPdfViewer(
                                                              url: urlLink)));
                                              debugPrint("Tapped on download");
                                            },
                                            child: Text(
                                              onlineCourseList?[index]
                                                      .courseContent ??
                                                  'N/A',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                          SizedBox(width: 1.w),
                                          Icon(Icons.file_copy, size: 4.w)
                                        ],
                                      ),
                                      SizedBox(height: 1.h),
                                      //EXPLORE
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(""),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 3.7.w),
                                            child: Container(
                                              width: 27.7.w,
                                              height: 5.h,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  debugPrint("hello");
                                                  // Navigator.of(context).push(
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             Payment()));
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OnlineCourseExplore(
                                                        purchasedCourses:
                                                            purchasedCourse,
                                                        courseId:
                                                            onlineCourseList[
                                                                    index]
                                                                .courseId
                                                                .toString(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 2,
                                                    shadowColor:
                                                        Color(0XFF00000029),
                                                    backgroundColor:
                                                        Config.whiteColor,
                                                    shape: RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xff999999)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7))),
                                                child: Text(
                                                  'Explore',
                                                  style: TextStyle(
                                                      color: Config
                                                          .primaryTextColor,
                                                      fontSize: 12.sp),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                  /*PaginationWidget(
              numOfPages: 5,
              selectedPage: selectedPage,
              pagesVisible: 3,
              spacing: 0,
              onPageChanged: (page) {
                //pageList(page);
                setState(() {
                  selectedPage = page;
                });
              },
              nextIcon: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              previousIcon: const Icon(
                Icons.arrow_back_ios,
                size: 15,
              ),
              activeTextStyle: const TextStyle(
                color: Color(0xffffffff),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              activeBtnStyle: ButtonStyle(
                visualDensity:
                const VisualDensity(horizontal: -4),
                backgroundColor:
                MaterialStateProperty.all(
                    const Color(0xff8cb93d)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xfff1f1f1),
                      width: 2,
                    ),
                  ),
                ),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.all(12)),
                shadowColor:
                MaterialStateProperty.all(
                  const Color(0xfff1f1f1),
                ),
              ),
              inactiveBtnStyle: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.all(20)),
                visualDensity:
                const VisualDensity(horizontal: 0),
                elevation:
                MaterialStateProperty.all(0),
                backgroundColor:
                MaterialStateProperty.all(
                  const Color(0xfff9f9fb),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                    side: const BorderSide(
                      color: Color(0xffffffff),
                      width: 10,
                    ),
                  ),
                ),
              ),
              inactiveTextStyle: const TextStyle(
                fontSize: 15,
                color: Color(0xff333333),
                fontWeight: FontWeight.w700,
              ),
            ),*/
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: paginationList(),
      ),
    );
  }
}
