import 'dart:convert';

import 'package:careercoach/Fresher%202%20Industry/Fresh2Indsty.dart';
import 'package:careercoach/Home%20Page.dart';
import 'package:careercoach/JobOpp.dart';
import 'package:careercoach/Learn%20Assist/learn_assist.dart';
import 'package:careercoach/Technology_Trends.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../All About Engg/All About Engg.dart';
import '../Ask Our Experts/ask_our_experts_query_form.dart';
import '../College Information/college_information.dart';
import '../Config.dart';
import 'package:http/http.dart' as http;
import '../Dhyan/dhyan.dart';
import '../For Professionals/Professional.dart';
import '../Interview Prep/interviewPrep.dart';
import '../Models/myActivityModel.dart';
import '../New/Online Courses.dart';
import '../Software_in_use.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/App_Bar_Widget.dart';

class Favorate {
  List<Myfavourites>? myfavourites;

  Favorate({this.myfavourites});

  Favorate.fromJson(Map<String, dynamic> json) {
    if (json['myfavourites'] != null) {
      myfavourites = <Myfavourites>[];
      json['myfavourites'].forEach((v) {
        myfavourites!.add(Myfavourites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myfavourites != null) {
      data['myfavourites'] = this.myfavourites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Myfavourites {
  String? favId;
  String? userId;
  String? favPath;
  String? addedOn;

  Myfavourites({this.favId, this.userId, this.favPath, this.addedOn});

  Myfavourites.fromJson(Map<String, dynamic> json) {
    favId = json['favId'];
    userId = json['userId'];
    favPath = json['favPath'];
    addedOn = json['addedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favId'] = this.favId;
    data['userId'] = this.userId;
    data['favPath'] = this.favPath;
    data['addedOn'] = this.addedOn;
    return data;
  }
}

class My_Activity extends StatefulWidget {
  const My_Activity({Key? key}) : super(key: key);

  @override
  State<My_Activity> createState() => _My_ActivityState();
}

class _My_ActivityState extends State<My_Activity> {
  final ScrollController _scrollController = ScrollController();

  late Future<List<dynamic>> futureFavorites;

  final List<String> items = ['AutoCAD 2D', 'AutoCAD 3D', 'Revit 2D'];
  bool colorBool = false;
  String? Useridnum;
  var jsonData;
  var rootData;
  List<String> viewed = [];
  List<String> uniqueList = [];
  List<Map<String, dynamic>> recentlyViewed = [];
  Favorate? favorateData;
  bool isLoading = true;

  Future<void> _loadUserId() async {
    Useridnum = (await SharedPreferencesHelper.getUserId()) ?? "Not set";

    setState(() {
      print(Useridnum.toString() +
          '-------------------------------->>>>>>>>>>>>>');
    });
  }

  Future<void> fetchData() async {
    Useridnum = (await SharedPreferencesHelper.getUserId()) ?? "Not set";
    final response = await http.get(
        Uri.parse('https://psmprojects.net/cadworld/myfavourites/$Useridnum'));
    print(response.body.toString());
    print(response.statusCode.toString());
    print(response.contentLength.toString());

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        favorateData = Favorate.fromJson(jsonResponse);
        isLoading = false;

        print(response.body.toString() + 'tostring');
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    fetchData();
    totalRecentActivityList();
    // TODO: implement initState
    super.initState();
  }

  void clearList() {
    setState(() {
      favorateData?.myfavourites?.clear();
    });
  }

  totalRecentActivityList() async {
    // var ids = [1, 4, 4, 4, 5, 6, 6];
    // var distinctIds = ids.toSet().toList();
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    // List<Map<String, dynamic>>? localData = await DatabaseHelper.deleteData();
    print(localData);
    var distinctIds = localData?.toSet().toList();
    debugPrint("Printing total list : $localData");
    debugPrint("Printing total distinctIds list : $distinctIds");
    recentlyViewed = localData!;

    List<Map<String, dynamic>> data = localData;

    List<String> uniqueNames = [];

    data.forEach((map) {
      String name = map["VIEWED_TAB"];
      if (!uniqueNames.contains(name)) {
        uniqueNames.add(name);
      }
    });

    print(uniqueNames);

    uniqueList = uniqueNames.toList();
    debugPrint("----+++----$uniqueList");
    debugPrint("----+++----${uniqueList.reversed}");
    // uniqueList = uniqueNames;
  }

  removeRecentActivity() async {
    // List<dynamic> localData;
    List<Map<String, dynamic>>? localData = await DatabaseHelper.deleteData();
    // List<Map<String, dynamic>>? localData = await DatabaseHelper.deleteData();
    print(localData);
    var distinctIds = localData?.toSet().toList();
    debugPrint("Printing total list : $localData");
    debugPrint("Printing total distinctIds list : $distinctIds");
    recentlyViewed = localData!;

    List<Map<String, dynamic>> data = localData;
    // localData = DatabaseHelper.deleteData() as List;
    // List<Map<String, dynamic>>? localData = await DatabaseHelper.deleteData();
    print(localData);

    // var distinctIds = localData?.toSet().toList();
  }

  recentlyViewedRoute(index) {
    if (uniqueList[index] == "Interview Prep") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => InterviewPrep()));
    } else if (uniqueList[index] == "Online Courses") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnlineCourses()));
    } else if (uniqueList[index] == "College Information") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CollegeInformation()));
    } else if (uniqueList[index] == "Job Oppurtunities") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => JobOppurtunities()));
    } else if (uniqueList[index] == "Fresher 2 Industry") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Fresh2Ind()));
    } else if (uniqueList[index] == "Learn Assist") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LearnAssist()));
    } else if (uniqueList[index] == "All About Engineering") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AllAboutEngineers()));
    } else if (uniqueList[index] == "Dhyan") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()));
    } else if (uniqueList[index] == "Software In Use And Commands") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SoftwareInUse()));
    } else if (uniqueList[index] == "Technology Trends") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => TechnologyTrends()));
    } else if (uniqueList[index] == "For Professionals") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Professionals()));
    } else if (uniqueList[index] == "Ask Our Experts") {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ExpertsQuery()));
    } else {
      return Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: AppBar(
          elevation: 0,
          backgroundColor: Config.containerColor,
          leadingWidth: 85,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: InkWell(
              child: Image.asset(
                'assets/images/pg12-1.png',
                height: 6.1.h,
                width: 22.6.w,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                  child: Text('My Activity',
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Config.primaryTextColor))),
            ),
            SizedBox(
              width: 1.w,
            ),
          ],
        ),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(0xffffffff),
                border: Border.all(width: 1, color: Color(0xffEBEBEB)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Favourates',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.sp),
                        ),
                        InkWell(
                          onTap: () {
                            clearList();
                          },
                          child: Text(
                            'Clear All',
                            style: TextStyle(
                                fontSize: 10.sp,
                                decoration: TextDecoration.underline,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    isLoading
    ? Center(child: CircularProgressIndicator())
    : favorateData?.myfavourites == null || favorateData!.myfavourites!.isEmpty
        ? Center(child: Text('No favourites available'))
        : ListView.builder(
            itemCount: favorateData!.myfavourites!.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = favorateData!.myfavourites![index];
              var favPath = item.favPath ?? 'No Path';
              
              // Splitting the string
              var splittedPath = favPath.split('{"ROOT1":"');
              var displayPath = splittedPath.length > 1
                  ? splittedPath[1].split('"')[0]
                  : 'No Path';

              return Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(displayPath);
                      },
                      child: Text(
                        displayPath,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 11.sp,
                          decoration: TextDecoration.underline,
                          color: Config.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          )

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey.shade100),
                ),
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: (uniqueList == null)
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
                                radius: 15,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Recently Visited',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      (uniqueList.length == 0)
                                          ? null
                                          : removeRecentActivity();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  My_Activity()));
                                    },
                                    child: Text(
                                      'Clear All',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          decoration: TextDecoration.underline,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: (uniqueList.length > 10)
                                    ? 10
                                    : uniqueList.length,
                                // itemCount: trainingVideosList.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          debugPrint("Printing index: $index");
                                          recentlyViewedRoute(index);
                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>jsonDecode(jsonData[1]["favPath"])["ROOT2"](index: jsonDecode(jsonData[1]["favPath"])["INDEX"])));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              // '${(jsonDecode(jsonData[1]["favPath"])["ROOT2"] == null ? '' : jsonDecode(jsonData[1]["favPath"])["ROOT2"]) ?? ''}',
                                              '${uniqueList[index]}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Config.blue),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//favouyrate list model


