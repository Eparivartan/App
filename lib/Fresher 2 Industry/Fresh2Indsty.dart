import 'dart:convert';
import 'package:careercoach/Fresher%202%20Industry/Fresher2Industry%20decription.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../Config.dart';
import '../Models/TechnologyFresherProfessionalModel.dart';
import '../Models/headerModel.dart';
import '../Models/softwareInUseModel.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';

class Fresh2Ind extends StatefulWidget {
  const Fresh2Ind({Key? key}) : super(key: key);

  @override
  State<Fresh2Ind> createState() => _Fresh2IndState();
}

class _Fresh2IndState extends State<Fresh2Ind> with TickerProviderStateMixin {
  String? career = "Career Guidelines";
  String? Data;
  bool changeButtonColor = true;
  int widgetType = 1;
  String? drophead;
  List? Details;
  List<TechnologyFresherProfessionalModel> fresherJobTypes = [];
  List<TechnologyFresherProfessionalModel> fresherJobTypes1 = [];
  List<TechnologyFresherProfessionalModel> fresherJobTypesList = [];
  List<TechnologyFresherProfessionalModel> fresherCareerGuideList = [];
  List<headerModel> headerList = [];
  TabController? _controller;
  String? selectedValue1;
  String? selectedValue2;
  String? img;
  List<BranchDropdownModel> branchDropdown = [];
  int val = 0;
  int? drpVal;

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "Fresher 2 Industry",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  @override
  void initState() {
    paginationList();
    saveToRecent();
    getDetailsJob();
    getDetailsCareer();
    getDropdownList();
    HeaderList();
    fresherCareerGuideList;
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller?.addListener(_handleTabSelection);
  }

  getJobDropdownValue() {
    debugPrint("Printing :: $selectedValue1");
    int val;
    if (selectedValue1 == 'Mechanical') {
      val = 1;
      drpVal = val;
      return getDetailsJob();
    } else if (selectedValue1 == 'Architecture') {
      val = 2;
      drpVal = val;
      return getDetailsJob();
    } else if (selectedValue1 == 'Civil') {
      val = 3;
      drpVal = val;
      return getDetailsJob();
    }
  }

  getCareerDropdownValue() {
    debugPrint("Printing :: $selectedValue2");
    int val;
    if (selectedValue2 == 'Mechanical') {
      val = 1;
      drpVal = val;
      return getDetailsCareer();
    } else if (selectedValue2 == 'Architecture') {
      val = 2;
      drpVal = val;
      return getDetailsCareer();
    } else if (selectedValue2 == 'Civil') {
      val = 3;
      drpVal = val;
      return getDetailsCareer();
    }
  }

  getDetailsJobList(from) async {
    debugPrint("printing the value got in drop down: $selectedValue1");
    debugPrint("printing the value got in drop down: $drpVal");
    fresherJobTypesList.clear();
    selectedPage = 1;
    final response = await http
        .get(Uri.parse('${Config.baseURL}listjobtypes/${drpVal}/$from/5'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["listjobtypes"];
      setState(() {
        fresherJobTypesList = jsonData
            .map<TechnologyFresherProfessionalModel>(
                (data) => TechnologyFresherProfessionalModel.fromJson(data))
            .toList();
      });
    } else {
      debugPrint('getDetailsJob listjobtypes/ get call error');
    }
  }

  getCareerGuideList(from) async {
    debugPrint("printing the value got in drop down: $selectedValue2");
    debugPrint("printing the value got in drop down: $drpVal");
    fresherCareerGuideList.clear();
    selectedPage = 1;
    final response = await http.get(
        Uri.parse('${Config.baseURL}listcareerguidelines/${drpVal}/$from/5'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["listcareerguidelines"];
      setState(() {
        fresherCareerGuideList = jsonData
            .map<TechnologyFresherProfessionalModel>(
                (data) => TechnologyFresherProfessionalModel.fromJson(data))
            .toList();
      });
    } else {
      debugPrint('getDetailsJob listcareerguidelines get call error');
    }
  }

  Future getDropdownList() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listcategory'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];
      setState(() {
        branchDropdown = jsonData
                .map<BranchDropdownModel>(
                    (data) => BranchDropdownModel.fromJson(data))
                .toList() ??
            [];
      });
    } else {
      debugPrint('get call error in getDropdownList()');
    }
  }

  Future HeaderList() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listheaders'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];

      setState(() {
        headerList = jsonData
                .map<headerModel>((data) => headerModel.fromJson(data))
                .toList() ??
            [];
        //  Map<String, dynamic> extractData = jsonDecode(response.body);
        //  FresherJobTypes = extractData["recordset"];
        //  var showLoading = false;
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data headers, $jsonData');
      debugPrint('printing header List, ${headerList[0].headerName}');
    } else {
      debugPrint('get call error');
    }
    //debugPrint("Fresher2Industry123 : $professional");
    // debugPrint("Service Details : $serviceDetails");
  }

  pageList1(page) {
    switch (page) {
      case 1:
        getDetailsJobList(0);
        break;
      case 2:
        getDetailsJobList(5);
        break;
      case 3:
        getDetailsJobList(10);
        break;
      case 4:
        getDetailsJobList(15);
        break;
      case 5:
        getDetailsJobList(20);
        break;
      case 6:
        getDetailsJobList(25);
        break;
      case 7:
        getDetailsJobList(30);
        break;
      case 8:
        getDetailsJobList(35);
        break;
      case 9:
        getDetailsJobList(40);
        break;
      case 10:
        getDetailsJobList(45);
        break;
      case 11:
        getDetailsJobList(50);
        break;
      case 12:
        getDetailsJobList(55);
        break;
      case 13:
        getDetailsJobList(60);
        break;
      case 14:
        getDetailsJobList(65);
        break;
      case 15:
        getDetailsJobList(70);
        break;
      case 16:
        getDetailsJobList(75);
        break;
      case 17:
        getDetailsJobList(80);
        break;
      case 18:
        getDetailsJobList(85);
        break;
      case 19:
        getDetailsJobList(90);
        break;
      case 20:
        getDetailsJobList(95);
        break;
      default:
        getDetailsJobList(100);
    }
  }

  pageList2(page) {
    switch (page) {
      case 1:
        getCareerGuideList(0);
        break;
      case 2:
        getCareerGuideList(5);
        break;
      case 3:
        getCareerGuideList(10);
        break;
      case 4:
        getCareerGuideList(15);
        break;
      case 5:
        getCareerGuideList(20);
        break;
      case 6:
        getCareerGuideList(25);
        break;
      case 7:
        getCareerGuideList(30);
        break;
      case 8:
        getCareerGuideList(35);
        break;
      case 9:
        getCareerGuideList(40);
        break;
      case 10:
        getCareerGuideList(45);
        break;
      case 11:
        getCareerGuideList(50);
        break;
      case 12:
        getCareerGuideList(55);
        break;
      case 13:
        getCareerGuideList(60);
        break;
      case 14:
        getCareerGuideList(65);
        break;
      case 15:
        getCareerGuideList(70);
        break;
      case 16:
        getCareerGuideList(75);
        break;
      case 17:
        getCareerGuideList(80);
        break;
      case 18:
        getCareerGuideList(85);
        break;
      case 19:
        getCareerGuideList(90);
        break;
      case 20:
        getCareerGuideList(95);
        break;
      default:
        getCareerGuideList(100);
    }
  }

  Future getDetailsJob() async {
    (_controller?.index == 0);
    final response = await http
        .get(Uri.parse('${Config.baseURL}listjobtypes/${drpVal}/0/5000'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["listjobtypes"];

      setState(() {
        fresherJobTypes = jsonData
            .map<TechnologyFresherProfessionalModel>(
                (data) => TechnologyFresherProfessionalModel.fromJson(data))
            .toList();
      });
      debugPrint('getDetailsJob GetCall Success');
      debugPrint('printing json data, $jsonData');
      getDetailsJobList(0);
      // getDetailsJobList(0);
      // getDetailsJobList(0);
      // getDetailsJobList(0);
    } else {
      debugPrint('getDetailsJob get call error');
    }
    //debugPrint("Fresher2Industry123 : $fresherJobTypes");
  }

  Future getDetailsCareer() async {
    (_controller?.index == 0);
    final response = await http
        .get(Uri.parse('${Config.baseURL}listcareerguidelines/${drpVal}/0/50'));
    if (response.statusCode == 200) {
      debugPrint("Coming 2 call ${response.body}");
      var jsonData = jsonDecode(response.body)["listcareerguidelines"];
      //var jsonData = (jsonDecode(response.body) as List).map((e) => Fresher2IndustryJobTypesModel.fromJson(e)).toList();

      setState(() {
        fresherJobTypes1 = jsonData
            .map<TechnologyFresherProfessionalModel>(
                (data) => TechnologyFresherProfessionalModel.fromJson(data))
            .toList();
      });
      debugPrint('getDetailsCareer GetCall Success');
      debugPrint('printing json data2, $jsonData');
      getCareerGuideList(0);
    } else {
      debugPrint('get call error');
    }
    //debugPrint("Fresher2Industry123 : $fresherJobTypes1");
    // debugPrint("Service Details : $serviceDetails");
  }

  void _handleTabSelection() {
    setState(() {
      getDetailsJobList(0);
      getDropdownList();
      // selectedValue1 = '';
      // selectedValue2 = '';
      selectedPage = 1;
      numberOfPages2();
      paginationList();
    });
  }

  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  numberOfPages1() {
    double pgNum = fresherJobTypes.length / 5;
    return pgNum.ceil();
  }

  numberOfPages2() {
    double pgNum = fresherJobTypes1.length / 5;
    return pgNum.ceil();
  }

  paginationList() {
    if (_controller?.index == 0) {
      return SizedBox(
        height: 7.h,
        child: PaginationWidget(
          numOfPages: numberOfPages1(),
          selectedPage: selectedPage,
          pagesVisible: 3,
          spacing: 0,
          onPageChanged: (page) {
            pageList1(page);
            setState(() {
              selectedPage = page;
            });
          },
          nextIcon: Icon(
            Icons.arrow_forward_ios,
            size: 12,
            color: selectedPage == numberOfPages1()
                ? Colors.grey
                : Color(0xff000000),
          ),
          previousIcon: Icon(
            Icons.arrow_back_ios,
            size: 12,
            color: selectedPage == 1 ? Colors.grey : Color(0xff000000),
          ),
          activeTextStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
          activeBtnStyle: ButtonStyle(
            visualDensity: VisualDensity(horizontal: -4),
            backgroundColor: MaterialStateProperty.all(const Color(0xff8cb93d)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                // side: const BorderSide(
                //  // color: Color(0xfff1f1f1),
                //   width: 1,
                // ),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            // shadowColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff1f1f1),
            // ),
          ),
          inactiveBtnStyle: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            visualDensity: const VisualDensity(horizontal: 0),
            elevation: MaterialStateProperty.all(0),
            // backgroundColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff9f9fb),
            // ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          inactiveTextStyle: const TextStyle(
            fontSize: 15,
            color: Color(0xff333333),
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    } else {
      fresherJobTypesList.clear();
      return SizedBox(
        height: 7.h,
        child: PaginationWidget(
          numOfPages: numberOfPages2(),
          selectedPage: selectedPage,
          pagesVisible: 3,
          spacing: 0,
          onPageChanged: (page) {
            pageList2(page);
            setState(() {
              selectedPage = page;
            });
          },
          nextIcon: Icon(
            Icons.arrow_forward_ios,
            size: 12,
            color: selectedPage == numberOfPages2()
                ? Colors.grey
                : Color(0xff000000),
          ),
          previousIcon: Icon(
            Icons.arrow_back_ios,
            size: 12,
            color: selectedPage == 1 ? Colors.grey : Color(0xff000000),
          ),
          activeTextStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
          activeBtnStyle: ButtonStyle(
            visualDensity: VisualDensity(horizontal: -4),
            backgroundColor: MaterialStateProperty.all(const Color(0xff8cb93d)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                // side: const BorderSide(
                //  // color: Color(0xfff1f1f1),
                //   width: 1,
                // ),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            // shadowColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff1f1f1),
            // ),
          ),
          inactiveBtnStyle: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            visualDensity: const VisualDensity(horizontal: 0),
            elevation: MaterialStateProperty.all(0),
            // backgroundColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff9f9fb),
            // ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          inactiveTextStyle: const TextStyle(
            fontSize: 15,
            color: Color(0xff333333),
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: const App_Bar_widget(
              title: "Fresher 2 Industry\n(Students career builder)"),
        ),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                //TABS
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  //margin: const EdgeInsets.all(10),
                  child: TabBar(
                    isScrollable: false,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    controller: _controller,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Config.whiteColor,
                    labelColor: Config.whiteColor,
                    // indicatorSize: TabBarIndicatorSize.label,
                    //indicatorPadding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                    labelStyle:
                        TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(
                      color: Config.primaryTextColor,
                      fontSize: 10.sp,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Container(
                        width: 45.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(7),
                            color: _controller?.index == 0
                                ? Config.containerGreenColor
                                : Config.mainBorderColor),
                        child: Tab(
                          key: UniqueKey(),
                          child: Text(
                            headerList.isNotEmpty
                                ? (headerList[0].headerName ?? '')
                                : '',
                            style: TextStyle(
                                fontSize: 11.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: 45.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(7),
                            color: _controller?.index == 1
                                ? Config.containerGreenColor
                                : Config.mainBorderColor),
                        child: Tab(
                          key: UniqueKey(),
                          child: Text(
                            headerList.isNotEmpty
                                ? (headerList[1].headerName ?? '')
                                : '',
                            style: TextStyle(
                                fontSize: 11.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //DIVIDER
                Padding(
                  padding: EdgeInsets.only(left: 3.75.w, right: 3.75.w),
                  child: Divider(),
                ),
                //Content
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _controller,
                    children: <Widget>[
                      //JOB TYPE
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4.w, right: 4.w),
                              child: Text(
                                headerList.isNotEmpty
                                    ? (headerList[0].headerContent ?? '')
                                    : '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            //Branch DropDown
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0.h, left: 4.w, right: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Branch',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                                    ),
                                    selectedItemHighlightColor:
                                        Colors.lightGreen,
                                    underline: Container(),
                                    items: branchDropdown
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item.cname,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Text(
                                                  item.cname ?? "",
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue1,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue1 = value as String;
                                        getJobDropdownValue();
                                      });
                                    },
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    iconSize: 30,
                                    iconEnabledColor: Colors.black,
                                    //barrierColor: Colors.green.withOpacity(0.2),
                                    // iconDisabledColor: Colors.grey,
                                    buttonHeight: 4.h,
                                    buttonWidth: 65.06.w,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border:
                                          Border.all(color: Color(0XFFF1F1F1)),
                                      color: Colors.white,
                                    ),
                                    buttonElevation: 0,
                                    itemHeight: 30,
                                    itemPadding: const EdgeInsets.only(
                                        left: 1, right: 1, top: 0, bottom: 0),
                                    dropdownWidth: 65.06.w,
                                    dropdownMaxHeight: 100.h,
                                    dropdownPadding: null,
                                    //EdgeInsets.all(1),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.grey.shade100,
                                    ),
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            (selectedValue1 == null || selectedValue1 == '')
                                ? Center(
                                    child: Container(
                                      height: 50.h,
                                      child: Center(
                                        child: Text(
                                          "Please Select Branch",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp,
                                              color: Colors.grey.shade400),
                                        ),
                                      ),
                                    ),
                                  )
                                : (fresherJobTypesList.isEmpty ||
                                        fresherJobTypesList == null ||
                                        fresherJobTypesList.length == 0)
                                    ? const Center(
                                        child: CupertinoActivityIndicator(
                                          radius: 25,
                                          color: Colors.black,
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: fresherJobTypesList.length,
                                        itemBuilder: (context, index) {
                                          img = fresherJobTypesList[index]
                                                  .postImage
                                                  .toString() ??
                                              '';
                                          return (fresherJobTypesList.isEmpty)
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
                                                        radius: 25,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 1.w,
                                                      bottom: 1.h,
                                                      right: 3.75.w,
                                                      left: 3.75.w),
                                                  child: InkWell(
                                                    child: Container(
                                                      height: 9.5.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Config
                                                                .mainBorderColor),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0.8.h,
                                                                bottom: 0.3.h,
                                                                right: 3.w,
                                                                left: 3.w),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 2.5.h,
                                                              child: Text(
                                                                fresherJobTypesList[
                                                                            index]
                                                                        .postTitle
                                                                        .toString() ??
                                                                    '',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12.sp),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 1.h),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  height: 4.5.h,
                                                                  width: 70.w,
                                                                  //height: 3.h,
                                                                  child: Text(
                                                                    fresherJobTypesList?[index]
                                                                            .postContent
                                                                            .toString() ??
                                                                        '',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12.sp),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          1.h,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              2.w),
                                                                      child: fresherJobTypesList?[index].postImage.toString() ==
                                                                              null
                                                                          ? Image.asset(
                                                                              'assets/images/DoubleArrowIcon.png',
                                                                              width: 3.w)
                                                                          : Image.network('https://psmprojects.net/cadworld/uploads/$img'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => Fresher2IndustryDec(
                                                              content:
                                                                  fresherJobTypesList[
                                                                          index]
                                                                      .postContent
                                                                      .toString(),
                                                              title:
                                                                  fresherJobTypesList[
                                                                          index]
                                                                      .postTitle
                                                                      .toString(),
                                                              type:
                                                                  "Job Type")));
                                                    },
                                                  ),
                                                );
                                        },
                                      ),
                          ],
                        ),
                      ),
                      //CAREER GUIDELINES
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4.w, right: 4.w),
                              child: Text(
                                headerList.isNotEmpty
                                    ? (headerList[1].headerContent ?? '')
                                    : '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            //Branch DropDown
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0.h, left: 4.w, right: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Branch',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                                    ),
                                    selectedItemHighlightColor:
                                        Colors.lightGreen,
                                    underline: Container(),
                                    items: branchDropdown
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item.cname,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Text(
                                                  item.cname ?? "",
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue2,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue2 = value as String;
                                        getCareerDropdownValue();
                                        // getCareerGuideList(0);
                                      });
                                    },
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    iconSize: 30,
                                    iconEnabledColor: Colors.black,
                                    //barrierColor: Colors.green.withOpacity(0.2),
                                    // iconDisabledColor: Colors.grey,
                                    buttonHeight: 4.h,
                                    buttonWidth: 65.06.w,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border:
                                          Border.all(color: Color(0XFFF1F1F1)),
                                      color: Colors.white,
                                    ),
                                    buttonElevation: 0,
                                    itemHeight: 30,
                                    itemPadding: const EdgeInsets.only(
                                        left: 1, right: 1, top: 0, bottom: 0),
                                    dropdownWidth: 65.06.w,
                                    dropdownMaxHeight: 100.h,
                                    dropdownPadding: null,
                                    //EdgeInsets.all(1),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.grey.shade100,
                                    ),
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            (selectedValue2 == null || selectedValue2 == '')
                                ? Center(
                                    child: Container(
                                      height: 50.h,
                                      child: Center(
                                        child: Text(
                                          "Please Select Branch",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp,
                                              color: Colors.grey.shade400),
                                        ),
                                      ),
                                    ),
                                  )
                                : (fresherCareerGuideList.isEmpty ||
                                        fresherCareerGuideList == null ||
                                        fresherCareerGuideList.length == 0)
                                    ? const Center(
                                        child: CupertinoActivityIndicator(
                                          radius: 25,
                                          color: Colors.black,
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        //const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            fresherCareerGuideList.length,
                                        // itemCount: fresherCareerGuideList.isEmpty ? 0 : fresherCareerGuideList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 1.w,
                                                bottom: 1.h,
                                                right: 3.75.w,
                                                left: 3.75.w),
                                            child: InkWell(
                                              child: Container(
                                                height: 9.5.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Config
                                                          .mainBorderColor),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.8.h,
                                                      bottom: 0.3.h,
                                                      right: 3.w,
                                                      left: 3.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 2.5.h,
                                                        child: Text(
                                                          fresherCareerGuideList[
                                                                      index]
                                                                  .postTitle ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height: 4.5.h,
                                                            width: 70.w,
                                                            child: Text(
                                                              fresherCareerGuideList[
                                                                          index]
                                                                      .postContent
                                                                      .toString() ??
                                                                  '',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp),
                                                            ),
                                                          ),
                                                          //arrow icon
                                                          Column(
                                                            children: [
                                                              Container(
                                                                height: 1.h,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: 2
                                                                            .w),
                                                                child: Image.asset(
                                                                    'assets/images/DoubleArrowIcon.png',
                                                                    width: 3.w),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Fresher2IndustryDec(
                                                              content: fresherCareerGuideList[
                                                                          index]
                                                                      .postContent
                                                                      .toString() ??
                                                                  '',
                                                              title:
                                                                  fresherCareerGuideList[
                                                                          index]
                                                                      .postTitle
                                                                      .toString(),
                                                              type:
                                                                  'Career Guidelines',
                                                            )));
                                              },
                                            ),
                                          );
                                        }),
                            SizedBox(
                              height: 1.w,
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
        bottomNavigationBar: Container(
          height: 7.h,
          child: BottomAppBar(
            elevation: 0,
            child: paginationList(),
          ),
        ),
      ),
    );
  }
}
