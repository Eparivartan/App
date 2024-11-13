import 'dart:convert';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'Config.dart';
import 'Models/headerModel.dart';
import 'Models/jobOppModel.dart';
import 'Models/softwareInUseModel.dart';
import 'SqlLiteDB/db_helper.dart';
import 'Widgets/App_Bar_Widget.dart';
import 'Widgets/cc_button.dart';
import 'Widgets/pagination.dart';

class JobOppurtunities extends StatefulWidget {
  const JobOppurtunities({Key? key}) : super(key: key);

  @override
  State<JobOppurtunities> createState() => _JobOppurtunitiesState();
}

class _JobOppurtunitiesState extends State<JobOppurtunities>
    with TickerProviderStateMixin {
  int selectedPage = 1;
  late TabController _controller;
  late PageController _pageController;
  bool changeButtonColor = true;
  bool _isVisible = true;
  int widgetType = 1;
  List? data;
  String? head;
  String? sub;
  String? imagee;
  String? logo;
  String? discreption;
  List? expntile;
  String? evlbtnn1;
  String? evlbtnn2;
  List? drpvlue;
  String? drphed;
  String? valuue;
  String? jobfund;
  String? updte;
  String? userId;
  String? _value1;
  int selectedTile = -1;
  bool isVisible = true;
  List? fresherjobs;
  List? experiencejobs;
  String? activePage;
  List<JobOppurtunitesModel> jobOppFresh = [];
  List<JobOppurtunitesModel> jobOppExp = [];
  List<JobOppurtunitesModel> jobOppFreshersAll = [];
  List<JobOppurtunitesModel> jobOppFreshers = [];
  List<JobOppurtunitesModel> jobOppExperienced = [];
  List<AppliedJobModel> appliedJobsGetCall = [];
  List<BranchDropdownModel> branchDropdown = [];
  List appliedJobsAll = [];
  List AllAppliedJobs = [];

  getDropdownValue() {
    int val;
    if (selectedValue == 'Mechanical') {
      return val = 1;
    } else if (selectedValue == 'Architecture') {
      return val = 2;
    } else if (selectedValue == 'Civil') {
      return val = 3;
    }
  }

  getDropdownValue1() {
    int val;
    if (selectedValue1 == 'Mechanical') {
      return val = 1;
    } else if (selectedValue1 == 'Architecture') {
      return val = 2;
    } else if (selectedValue1 == 'Civil') {
      return val = 3;
    }
  }

  void _handleTabSelection() {
    setState(() {
      // getAppliedJobDetails();
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>JobOppurtunities()));
    });
  }

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  //Dropdown getCall..............
  Future getDetailsDrp1() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listcategory'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];
      // selectedValue1==null;
      // debugPrint("null:: ${selectedValue1}");
      // debugPrint("null:123: ${selectedValue}");

      setState(() {
        branchDropdown = jsonData
                .map<BranchDropdownModel>(
                    (data) => BranchDropdownModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success for get_Details');
      debugPrint('printing json data, $jsonData');
    } else {
      debugPrint('getDetails get call error');
    }
  }

  Future getDetailsDrp2() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listcategory'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];
      // selectedValue1==null;
      // debugPrint("null:: ${selectedValue1}");
      // debugPrint("null:123: ${selectedValue}");

      setState(() {
        branchDropdown = jsonData
                .map<BranchDropdownModel>(
                    (data) => BranchDropdownModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success for get_Details');
      debugPrint('printing json data, $jsonData');
    } else {
      debugPrint('getDetails get call error');
    }
  }

  //Post Call
  Future<void> applyPost(index, mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);
    debugPrint("PostTrail call with UserId: $userId");

    debugPrint("PostTrail call with JobOpp: ${jobOppFreshers[index].jobId}");
    debugPrint(
        "PostTrail call with JobOpp: ${jobOppFreshers[index].jobCode.toString()}");

    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/applyjob/endpoint.php');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': userId.toString(),
          'JOB_ID': (mode == 1)
              ? ("${jobOppFreshers[index].jobId.toString()}")
              : ("${jobOppExperienced[index].jobId.toString()}"),
        },
      );

      print(response.body.toString());
      print(response.statusCode.toString());

      if (response.statusCode == 200) {
        getAppliedJobDetails();
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Success!!",
                  ),
                  content: const Text("You have Applied successfully!!"),
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

  void showToast() {
    setState(() {
      isVisible = true;
    });
  }

  //Get call for job info.............
  Future getDetails1(val, from) async {
    debugPrint("printing Seelcted Value : $selectedValue");
    debugPrint("printing from : $from");
    final response = await http.get(Uri.parse(
        '${Config.baseURL}listfjobopportunities/$selectedValue/$from/5'));

    // selectedValue1 == null;
    // final serviceResponse = await http.get(Uri.parse(''));
    print(response.toString());
    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["jobopportunities"];
      setState(() {
        jobOppFreshers = jsonData
                .map<JobOppurtunitesModel>(
                    (data) => JobOppurtunitesModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint("printing getdetails1 : $jobOppFreshers");
      debugPrint('GetCall Success');
      debugPrint('printing json data, where selected value, $jsonData');
    } else {
      debugPrint('getDetails1 get call error');
    }
  }

  Future getDetails2(val, from) async {
    debugPrint("printing Seelcted Value : $selectedValue1");
    debugPrint("printing from : $from");

    final response = await http.get(Uri.parse(
        '${Config.baseURL}listexpjobopportunities/$selectedValue1/$from/5'));
    // selectedValue1 == null;
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["jobopportunities"];
      setState(() {
        jobOppExperienced = jsonData
                .map<JobOppurtunitesModel>(
                    (data) => JobOppurtunitesModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint("printing getdetails 2 : $jobOppExperienced");
      debugPrint('GetCall Success');
      debugPrint('printing json data, where selected value, $jsonData');
    } else {
      debugPrint('getDetails1 get call error');
    }
  }

  Future getAppliedJobDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);

    final response = await http
        .get(Uri.parse('https://psmprojects.net/cadworld/appliedjobs/$userId'));

    print(response.toString());
    print(response.body.toString());
    print(response.statusCode.toString());

    if (response.body != null) {
      final data = jsonDecode(response.body);
      print(data.toString() + 'datadatdatadatadat');
     ApplyJob applyJob = ApplyJob.fromJson(data);

      // Print or store the details as needed
      if (applyJob.appliedjobs != null) {
        applyJob.appliedjobs!.forEach((job) {
          print('ApplId: ${job.applId}');
          print('JobId: ${job.jobId}');
          print('UserId: ${job.userId}');
          print('AddedOn: ${job.addedOn}');
          print('------------------------');
        });
      } else {
        print('No applied jobs found.');
      }

    } else {
      throw Exception('Failed to load data');
    }
  }



  pageList(page) {
    switch (page) {
      case 1:
        getDetails1(getDropdownValue(), 0);
        break;
      case 2:
        getDetails1(getDropdownValue(), 5);
        break;
      case 3:
        getDetails1(getDropdownValue(), 10);
        break;
      case 4:
        getDetails1(getDropdownValue(), 15);
        break;
      case 5:
        getDetails1(getDropdownValue(), 20);
        break;
      case 6:
        getDetails1(getDropdownValue(), 25);
        break;
      case 7:
        getDetails1(getDropdownValue(), 30);
        break;
      case 8:
        getDetails1(getDropdownValue(), 35);
        break;
      case 9:
        getDetails1(getDropdownValue(), 40);
        break;
      case 10:
        getDetails1(getDropdownValue(), 45);
        break;
      case 11:
        getDetails1(getDropdownValue(), 50);
        break;
      case 12:
        getDetails1(getDropdownValue(), 55);
        break;
      case 13:
        getDetails1(getDropdownValue(), 60);
        break;
      case 14:
        getDetails1(getDropdownValue(), 65);
        break;
      case 15:
        getDetails1(getDropdownValue(), 70);
        break;
      case 16:
        getDetails1(getDropdownValue(), 75);
        break;
      case 17:
        getDetails1(getDropdownValue(), 80);
        break;
      case 18:
        getDetails1(getDropdownValue(), 85);
        break;
      case 19:
        getDetails1(getDropdownValue(), 90);
        break;
      case 20:
        getDetails1(getDropdownValue(), 95);
        break;
      default:
        getDetails1(getDropdownValue(), 100);
    }
  }

  pageList1(page) {
    switch (page) {
      case 1:
        getDetails2(getDropdownValue1(), 0);
        break;
      case 2:
        getDetails2(getDropdownValue1(), 5);
        break;
      case 3:
        getDetails2(getDropdownValue1(), 10);
        break;
      case 4:
        getDetails2(getDropdownValue1(), 15);
        break;
      case 5:
        getDetails2(getDropdownValue1(), 20);
        break;
      case 6:
        getDetails2(getDropdownValue1(), 25);
        break;
      case 7:
        getDetails2(getDropdownValue1(), 30);
        break;
      case 8:
        getDetails2(getDropdownValue1(), 35);
        break;
      case 9:
        getDetails2(getDropdownValue1(), 40);
        break;
      case 10:
        getDetails2(getDropdownValue1(), 45);
        break;
      case 11:
        getDetails2(getDropdownValue1(), 50);
        break;
      case 12:
        getDetails2(getDropdownValue1(), 55);
        break;
      case 13:
        getDetails2(getDropdownValue1(), 60);
        break;
      case 14:
        getDetails2(getDropdownValue1(), 65);
        break;
      case 15:
        getDetails2(getDropdownValue1(), 70);
        break;
      case 16:
        getDetails2(getDropdownValue1(), 75);
        break;
      case 17:
        getDetails2(getDropdownValue1(), 80);
        break;
      case 18:
        getDetails2(getDropdownValue1(), 85);
        break;
      case 19:
        getDetails2(getDropdownValue1(), 90);
        break;
      case 20:
        getDetails2(getDropdownValue1(), 95);
        break;
      default:
        getDetails2(getDropdownValue1(), 100);
    }
  }

  numberOfPages1() {
    double pgNum = jobOppFreshers.length / 5;
    return pgNum.ceil();
  }

  numberOfPages2() {
    double pgNum = jobOppExperienced.length / 5;
    return pgNum.ceil();
  }

  String? selectedValue;
  String? selectedValue1;

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "Job Oppurtunities",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  @override
  void initState() {
    getData1();
    getData2();
    saveToRecent();
    getDetailsDrp1();
    getDetailsDrp2();
    getAppliedJobDetails();
    _pageController = PageController();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(_handleTabSelection);
    super.initState();
  }

  // getMobileMail(index) {
  //   String? contactInfo = jobOppFreshers?[index].jobContact;
  //   return contactInfo;
  // }
  //
  // List<String> parts = contactInfo.split('Mail-ID : ');

  // List<String> parts = (jobOppFreshers?[index].jobContact).split('Mail-ID : ');

  Future getData1() async {
    String jsonString =
        await rootBundle.loadString('assets/files/fresherjobs.json');
    //debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      fresherjobs = jsonMap["details"];
    });
  }

  Future getData2() async {
    String jsonString =
        await rootBundle.loadString('assets/files/experiencedjobs.json');
    //debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      experiencejobs = jsonMap["details1"];
    });
  }

  paginationList() {
    if (_controller?.index == 0) {
      return PaginationWidget(
        numOfPages: numberOfPages1(),
        selectedPage: selectedPage,
        pagesVisible: 3,
        spacing: 0,
        onPageChanged: (page) {
          debugPrint("Sending page $page");
          pageList(page);
          setState(() {
            selectedPage = (page);
          });
        },
        nextIcon: const Icon(
          Icons.arrow_forward_ios,
          size: 12,
          color: Color(0xff000000),
        ),
        previousIcon: const Icon(
          Icons.arrow_back_ios,
          size: 12,
          color: Color(0xff000000),
        ),
        activeTextStyle: TextStyle(
          color: const Color(0xffffffff),
          fontSize: Config.font_size_12.sp,
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
    } else if (_controller?.index == 1) {
      return PaginationWidget(
        numOfPages: numberOfPages2(),
        selectedPage: selectedPage,
        pagesVisible: 3,
        spacing: 0,
        onPageChanged: (page) {
          debugPrint("Sending page $page");
          pageList1(page);
          setState(() {
            selectedPage = (page);
          });
        },
        nextIcon: const Icon(
          Icons.arrow_forward_ios,
          size: 12,
          color: Color(0xff000000),
        ),
        previousIcon: const Icon(
          Icons.arrow_back_ios,
          size: 12,
          color: Color(0xff000000),
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
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: App_Bar_widget(title: 'Oppurtunities/ Jobs'),
        ),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: (fresherjobs == null)
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: ListView(
                    children: [
                      DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TabBar(
                                  isScrollable: false,
                                  padding: EdgeInsets.zero,
                                  labelPadding: EdgeInsets.zero,
                                  controller: _controller,
                                  unselectedLabelColor: Colors.black,
                                  indicatorColor: Config.containerGreenColor,
                                  labelColor: Config.whiteColor,
                                  labelStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                    color: Config.primaryTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.sp,
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Container(
                                      height: 4.h,
                                      width: 46.w,
                                      //margin: EdgeInsets.only(left: 30, right: 30),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          color: _controller?.index == 0
                                              ? Config.containerGreenColor
                                              : Config.mainBorderColor),
                                      child: Tab(
                                        key: UniqueKey(),
                                        child: Text(
                                          'Freshers',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 4.h,
                                      width: 46.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          color: _controller.index == 1
                                              ? Config.containerGreenColor
                                              : Config.mainBorderColor),
                                      child: Tab(
                                        // key: UniqueKey(),
                                        child: Text(
                                          'Experienced',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            //color: _controller.index == 1 ? Config
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            //const Divider(thickness: 6, color: Config.containerGreenColor,),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 3.8.w, right: 3.8.w),
                              height: 0.5.h,
                              width: 100.w,
                              decoration: const BoxDecoration(
                                color: Config.containerGreenColor,
                              ),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.25.h,
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: _controller,
                                children: <Widget>[
                                  //Freshers
                                  Column(
                                    children: [
                                      //Select Branch
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.w, right: 4.w, top: 3.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Branch*",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Config.font_size_12.sp),
                                            ),
                                            (branchDropdown.length == 0)
                                                ? Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Loading',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15.sp,
                                                            color: Config
                                                                .primaryTextColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        const CupertinoActivityIndicator(
                                                          radius: 10,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : DropdownButton2(
                                                    dropdownElevation: 5,
                                                    isExpanded: true,
                                                    hint: Text(
                                                      ' Select',
                                                      style: TextStyle(
                                                        fontSize: Config
                                                            .font_size_12.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    selectedItemHighlightColor:
                                                        Colors.lightGreen,
                                                    underline: Container(),
                                                    items: branchDropdown
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item.id,
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        0.8.h,
                                                                  ),
                                                                  //Divider(thickness: 2,),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 1
                                                                            .w),
                                                                    child: Text(
                                                                      "${item.cname}" ??
                                                                          "",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color: Colors
                                                                            .black,
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
                                                        selectedValue =
                                                            value as String;
                                                        getDetails1(
                                                            getDropdownValue(),
                                                            0);
                                                        // getDropdownValue();
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_outlined,
                                                      size: 5.w,
                                                    ),
                                                    iconSize: 30,
                                                    iconEnabledColor:
                                                        Colors.black,
                                                    buttonHeight: 4.h,
                                                    buttonWidth: 68.5.w,
                                                    buttonPadding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    buttonDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Config
                                                              .mainBorderColor),
                                                      color: Colors.white,
                                                    ),
                                                    buttonElevation: 0,
                                                    itemHeight: 30,
                                                    itemPadding:
                                                        const EdgeInsets.only(
                                                            left: 1,
                                                            right: 1,
                                                            top: 0,
                                                            bottom: 0),
                                                    dropdownWidth: 68.5.w,
                                                    dropdownMaxHeight: 100.h,
                                                    dropdownPadding: null,
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                      color:
                                                          Colors.grey.shade100,
                                                    ),
                                                    offset: const Offset(0, 0),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      //No of jobs and post date
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.w, right: 4.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: 'Total Jobs Found: ',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Color(0XFF999999)),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${jobOppFreshers.length}",
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Config
                                                          .primaryTextColor),
                                                ),
                                              ]),
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: 'Last post on: ',
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0XFF999999)),
                                              ),
                                              TextSpan(
                                                text: formatted,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Config
                                                        .primaryTextColor),
                                              ),
                                            ])),
                                          ],
                                        ),
                                      ),
                                      //Divider
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.w, right: 4.w),
                                        child: Divider(),
                                      ),
                                      //Content of application
                                      jobOppFreshers.isEmpty
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 25.h,
                                                ),
                                                Container(
                                                    height: 50.h,
                                                    child: Text(
                                                      "No records to show\nPlease select branch",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 24.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .grey.shade300),
                                                    )),
                                              ],
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              itemCount:
                                                  jobOppFreshers.length ?? 0,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 3.w,
                                                      right: 3.w,
                                                      top: 0.4.h,
                                                      bottom: 0.5.h),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffF1F1F1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3.w,
                                                          right: 3.w,
                                                          top: 3.w),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            jobOppFreshers[
                                                                        index]
                                                                    .jobProfilename ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: Config
                                                                    .font_size_12
                                                                    .sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Color(
                                                                    0XFF1C65A3)),
                                                          ),
                                                          SizedBox(height: 1.h),
                                                          //Job ID && #Jobs
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'Job ID: ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp),
                                                                  ),
                                                                  Text(
                                                                    jobOppFreshers[index]
                                                                            .jobCode ??
                                                                        '0000',
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      '# of jobs:',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  Text(
                                                                    fresherjobs?[index]
                                                                            [
                                                                            "JOBS"] ??
                                                                        '0',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize: Config
                                                                          .font_size_12
                                                                          .sp,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //QUALIFICATION
                                                          Container(
                                                            width: 85.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Qualification:  ',
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                  TextSpan(
                                                                    text: jobOppFreshers?[
                                                                            index]
                                                                        .jobQualification,
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                ])),
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //Job Title
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Job Title: ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: Config
                                                                        .font_size_12
                                                                        .sp),
                                                              ),
                                                              Text(
                                                                jobOppFreshers?[
                                                                            index]
                                                                        .jobTitle ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontSize: Config
                                                                        .font_size_12
                                                                        .sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //Job Profile
                                                          Container(
                                                            width: 85.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Job profile: ',
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                  TextSpan(
                                                                    text: jobOppFreshers?[
                                                                            index]
                                                                        .jobProfile,
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                ])),
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //Contact
                                                          Row(
                                                            children: [
                                                              Container(
                                                                height: 4.h,
                                                                child: Text(
                                                                  'Contact: ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: Config
                                                                          .font_size_12
                                                                          .sp),
                                                                ),
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    width: 60.w,
                                                                    child: Text(
                                                                      (jobOppFreshers?[index].jobContact?.substring(
                                                                              0,
                                                                              23)) ??
                                                                          '',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 60.w,
                                                                    child: Text(
                                                                      (jobOppFreshers?[index]
                                                                              .jobContact
                                                                              ?.substring(23)) ??
                                                                          '',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          2,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                              // Container(
                                                              //   width: 55.w,
                                                              //   child: Text((jobOppFreshers?[index].jobContact?.substring(0, 23)) ?? '',
                                                              //     style: TextStyle(
                                                              //       fontSize: Config.font_size_12.sp,
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                          Divider(),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //bottom posted on and show interest button
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Posted on: ${jobOppFreshers?[index].postedOn}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        9.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Color(
                                                                        0XFF999999)),
                                                              ),
                                                              // (jobOppFreshers[index].jobId.toString() == appliedJobsGetCall[index].jobId.toString()) &&
                                                              (AllAppliedJobs.contains(
                                                                      jobOppFreshers?[
                                                                              index]
                                                                          .jobId
                                                                          .toString()))
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                AlertDialog(
                                                                                  title: const Text(
                                                                                    "Applied!!",
                                                                                  ),
                                                                                  content: const Text("You have Already Applied To This Job!!"),
                                                                                  actions: <Widget>[
                                                                                    ElevatedButton(
                                                                                      onPressed: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Config.careerCoachButtonColor),
                                                                                      //return false when click on "NO"
                                                                                      child: const Text('OK'),
                                                                                    ),
                                                                                  ],
                                                                                ));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            37.w,
                                                                        height:
                                                                            3.h,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(30),
                                                                            border: Border.all(width: 0.5, color: Color(0XFFCCCCCC))),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 8, right: 4.0, top: 4, bottom: 4),
                                                                              child: Text(
                                                                                'Apply/Show Intrest',
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                            (jobOppFreshers.isEmpty)
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.only(right: 3),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.grey.shade300,
                                                                                        borderRadius: BorderRadius.circular(50),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                        child: Icon(
                                                                                          Icons.thumb_up_alt_outlined,
                                                                                          size: 4.w,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Padding(
                                                                                    padding: const EdgeInsets.only(right: 3),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: (jobOppExperienced.isEmpty) ? Config.containerGreenColor : Colors.grey.shade300,
                                                                                        borderRadius: BorderRadius.circular(50),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                        child: (jobOppExperienced.isEmpty)
                                                                                            ? Icon(
                                                                                                Icons.thumb_up_alt_outlined,
                                                                                                size: 4.w,
                                                                                                color: Colors.white,
                                                                                              )
                                                                                            : Icon(
                                                                                                Icons.thumb_up_alt_outlined,
                                                                                                size: 4.w,
                                                                                                color: Colors.black,
                                                                                              ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : InkWell(
                                                                      onTap:
                                                                          () {
                                                                        applyPost(
                                                                            index,
                                                                            1);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            35.w,
                                                                        height:
                                                                            3.h,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(30),
                                                                            border: Border.all(width: 0.5, color: Color(0XFFCCCCCC))),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 8, right: 4.0, top: 4, bottom: 4),
                                                                              child: Text(
                                                                                'Apply/Show Intrest',
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3),
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Config.containerGreenColor,
                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(2.0),
                                                                                  child: Icon(
                                                                                    Icons.thumb_up_alt_outlined,
                                                                                    size: 4.w,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                    ],
                                  ),
                                  //Experienced
                                  Column(
                                    children: [
                                      //Select Branch
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.w, right: 4.w, top: 3.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Branch*",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Config.font_size_12.sp),
                                            ),
                                            (branchDropdown.length == 0)
                                                ? Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Loading',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15.sp,
                                                            color: Config
                                                                .primaryTextColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        const CupertinoActivityIndicator(
                                                          radius: 10,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : DropdownButton2(
                                                    dropdownElevation: 5,
                                                    isExpanded: true,
                                                    hint: Text(
                                                      ' Select',
                                                      style: TextStyle(
                                                        fontSize: Config
                                                            .font_size_12.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    selectedItemHighlightColor:
                                                        Colors.lightGreen,
                                                    underline: Container(),
                                                    items: branchDropdown
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item.id,
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        0.8.h,
                                                                  ),
                                                                  //Divider(thickness: 2,),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 1
                                                                            .w),
                                                                    child: Text(
                                                                      item.cname ??
                                                                          "",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color: Colors
                                                                            .black,
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
                                                    value: selectedValue1,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedValue1 =
                                                            value as String;
                                                        print(selectedValue1
                                                            .toString());
                                                        getDetails2(
                                                            getDropdownValue1(),
                                                            0);
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_outlined,
                                                      size: 5.w,
                                                    ),
                                                    iconSize: 30,
                                                    iconEnabledColor:
                                                        Colors.black,
                                                    buttonHeight: 4.h,
                                                    buttonWidth: 68.5.w,
                                                    buttonPadding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    buttonDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Config
                                                              .mainBorderColor),
                                                      color: Colors.white,
                                                    ),
                                                    buttonElevation: 0,
                                                    itemHeight: 30,
                                                    itemPadding:
                                                        const EdgeInsets.only(
                                                            left: 1,
                                                            right: 1,
                                                            top: 0,
                                                            bottom: 0),
                                                    dropdownWidth: 68.5.w,
                                                    dropdownMaxHeight: 100.h,
                                                    dropdownPadding: null,
                                                    //EdgeInsets.all(1),
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                      color:
                                                          Colors.grey.shade100,
                                                    ),
                                                    offset: const Offset(0, 0),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      //No of jobs and post date
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.w, right: 4.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: 'Total Jobs Found: ',
                                                  style: TextStyle(
                                                      fontSize: Config
                                                          .font_size_12.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: const Color(
                                                          0XFF999999)),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${jobOppExperienced.length}",
                                                  style: TextStyle(
                                                      fontSize: Config
                                                          .font_size_12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Config
                                                          .primaryTextColor),
                                                ),
                                              ]),
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: 'Last post on: ',
                                                style: TextStyle(
                                                    fontSize:
                                                        Config.font_size_12.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0XFF999999)),
                                              ),
                                              TextSpan(
                                                text: formatted,
                                                style: TextStyle(
                                                    fontSize:
                                                        Config.font_size_12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Config
                                                        .primaryTextColor),
                                              ),
                                            ])),
                                          ],
                                        ),
                                      ),
                                      //Divider
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.w, right: 4.w),
                                        child: Divider(),
                                      ),
                                      //Content of application
                                      jobOppExperienced.isEmpty
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 25.h,
                                                ),
                                                Container(
                                                    height: 50.h,
                                                    child: Text(
                                                      "No records to show\nPlease select branch",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 24.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .grey.shade300),
                                                    )),
                                              ],
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              //const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  jobOppExperienced?.length ??
                                                      0,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 3.w,
                                                      right: 3.w,
                                                      top: 0.4.h),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffF1F1F1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3.w,
                                                          right: 3.w,
                                                          top: 3.w),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            jobOppExperienced[
                                                                        index]
                                                                    .jobProfilename ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: Config
                                                                    .font_size_12
                                                                    .sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0XFF1C65A3)),
                                                          ),
                                                          SizedBox(height: 1.h),
                                                          //Job ID && Jobs
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      'Job ID:',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  Text(
                                                                    jobOppExperienced[index]
                                                                            .jobCode ??
                                                                        '0000',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize: Config
                                                                          .font_size_12
                                                                          .sp,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '# of jobs:',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp),
                                                                  ),
                                                                  Text(
                                                                    experiencejobs?[index]
                                                                            [
                                                                            "JOBS"] ??
                                                                        '0',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize: Config
                                                                          .font_size_12
                                                                          .sp,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //Experience
                                                          Container(
                                                            width: 85.w,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Experience: ',
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                  TextSpan(
                                                                    text: jobOppExperienced[
                                                                            index]
                                                                        .jobExperience,
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //QUALIFICATION
                                                          Container(
                                                            width: 85.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Qualification:  ',
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                  TextSpan(
                                                                    text: jobOppExperienced[
                                                                            index]
                                                                        .jobQualification,
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                ])),
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //Job Title
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Job Title: ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: Config
                                                                        .font_size_12
                                                                        .sp),
                                                              ),
                                                              Text(
                                                                jobOppExperienced[
                                                                            index]
                                                                        .jobTitle ??
                                                                    '',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: Config
                                                                      .font_size_12
                                                                      .sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //Job Profile
                                                          Container(
                                                            width: 85.w,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Job profile: ',
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                  TextSpan(
                                                                    text: jobOppExperienced[
                                                                            index]
                                                                        .jobProfile,
                                                                    style: TextStyle(
                                                                        fontSize: Config
                                                                            .font_size_12
                                                                            .sp,
                                                                        color: Config
                                                                            .primaryTextColor),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          //Contact
                                                          Row(
                                                            children: [
                                                              Container(
                                                                height: 4.h,
                                                                child: Text(
                                                                  'Contact: ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: Config
                                                                          .font_size_12
                                                                          .sp),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 50.w,
                                                                child: Text(
                                                                  jobOppExperienced[
                                                                              index]
                                                                          .jobContact ??
                                                                      '',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: Config
                                                                        .font_size_12
                                                                        .sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(),
                                                          SizedBox(
                                                              height: 0.5.h),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Posted on: ${jobOppExperienced[index].postedOn}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        8.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Color(
                                                                        0XFF999999)),
                                                              ),
                                                              (AllAppliedJobs.contains(
                                                                      jobOppExperienced[
                                                                              index]
                                                                          .jobId
                                                                          .toString()))
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                AlertDialog(
                                                                                  title: const Text(
                                                                                    "Applied!!",
                                                                                  ),
                                                                                  content: const Text("You have Already Applied To This Job!!"),
                                                                                  actions: <Widget>[
                                                                                    ElevatedButton(
                                                                                      onPressed: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Config.careerCoachButtonColor),
                                                                                      //return false when click on "NO"
                                                                                      child: const Text('OK'),
                                                                                    ),
                                                                                  ],
                                                                                ));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            35.w,
                                                                        height:
                                                                            3.h,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(30),
                                                                            border: Border.all(width: 0.5, color: Color(0XFFCCCCCC))),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 8, right: 4.0, top: 4, bottom: 4),
                                                                              child: Text(
                                                                                'Apply/Show Intrest',
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                            (jobOppExperienced.isEmpty)
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.only(right: 3),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.grey.shade300,
                                                                                        borderRadius: BorderRadius.circular(50),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                        child: Icon(
                                                                                          Icons.thumb_up_alt_outlined,
                                                                                          size: 4.w,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Padding(
                                                                                    padding: const EdgeInsets.only(right: 3),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: (jobOppExperienced.isEmpty) ? Config.containerGreenColor : Colors.grey.shade300,
                                                                                        borderRadius: BorderRadius.circular(50),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                        child: (jobOppExperienced.isEmpty)
                                                                                            ? Icon(
                                                                                                Icons.thumb_up_alt_outlined,
                                                                                                size: 4.w,
                                                                                                color: Colors.white,
                                                                                              )
                                                                                            : Icon(
                                                                                                Icons.thumb_up_alt_outlined,
                                                                                                size: 4.w,
                                                                                                color: Colors.black,
                                                                                              ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : InkWell(
                                                                      onTap:
                                                                          () {
                                                                        applyPost(
                                                                            index,
                                                                            2);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            35.w,
                                                                        height:
                                                                            3.h,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(30),
                                                                            border: Border.all(width: 0.5, color: Color(0XFFCCCCCC))),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 8, right: 4.0, top: 4, bottom: 4),
                                                                              child: Text(
                                                                                'Apply/Show Intrest',
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 3),
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Config.containerGreenColor,
                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(2.0),
                                                                                  child: Icon(
                                                                                    Icons.thumb_up_alt_outlined,
                                                                                    size: 4.w,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 0.5.h)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        //Pagination
        bottomNavigationBar: BottomAppBar(
          child: paginationList(),
        ),
      ),
    );
  }
}


class ApplyJob {
  List<Appliedjobs>? appliedjobs;

  ApplyJob({this.appliedjobs});

  ApplyJob.fromJson(Map<String, dynamic> json) {
    if (json['appliedjobs'] != null) {
      appliedjobs = <Appliedjobs>[];
      json['appliedjobs'].forEach((v) {
        appliedjobs!.add(new Appliedjobs.fromJson(v));
      });
    }
  }
}

class Appliedjobs {
  String? applId;
  String? jobId;
  String? userId;
  String? addedOn;

  Appliedjobs({this.applId, this.jobId, this.userId, this.addedOn});

  Appliedjobs.fromJson(Map<String, dynamic> json) {
    applId = json['applId'];
    jobId = json['jobId'];
    userId = json['userId'];
    addedOn = json['addedOn'];
  }
}
