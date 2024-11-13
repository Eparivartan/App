import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Config.dart';
import '../Models/allAboutEngineeringModel.dart';
import '../Models/headerModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'Engineering Branches decription.dart';

class EngineeringBranches extends StatefulWidget {
  var mode;
  var index1;
  EngineeringBranches({Key? key, required this.mode, this.index1})
      : super(key: key);

  @override
  State<EngineeringBranches> createState() => _EngineeringBranchesState();
}

class _EngineeringBranchesState extends State<EngineeringBranches>
    with TickerProviderStateMixin {
  List? data;
  String? head;
  String? sub;
  String? imagee;
  String? logo;
  String? discreption;
  String? discreption1;
  String? discreption2;
  List? expntile;
  List? expntile1;
  List? expntile2;
  int selectedTile = -1;
  String? activePage;
  bool isVisible = true;
  PageController? _pageController;
  List<EngineeringBranchesModel> engineeringBranches = [];
  List<EngineeringBranchesModel> engineeringBranchesArchitectureList = [];
  List<EngineeringBranchesModel> engineeringBranchesCivilList = [];
  List<EngineeringBranchesModel> engineeringBranchesMecanicalList = [];
  List<headerModel> headerList = [];
  List<String> recentlyView = [];
  List<String> viewed = [];

  // late TabController _tabController;
  TabController? _controller;

  @override
  void initState() {
    debugPrint(
        "Printing mode cmg to Engineering Branches &&& Index is :   ${widget.mode}   &&&   ${widget.index1}");
    // (widget.mode == 1) ? Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => EngineeringBranchesDec(
    //         title:
    //         engineeringBranchesCivilList[index].postTitle ??
    //             '',
    //         content1:
    //         engineeringBranchesCivilList[index].postContent ??
    //             '',
    //         root1:
    //         "AllAboutEngineers",
    //         root2:
    //         "EngineeringBranches",
    //         index:
    //         "${index}",
    //         branch:
    //         "Engineering Branches"))) : null ;
    getData();
    getDetails();
    getDetails1();
    getDetails2();
    HeaderList();
    (widget.mode == 1 && widget.index1 != null)
        ? Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EngineeringBranchesDec(
                title: engineeringBranchesArchitectureList[widget.index1]
                        .postTitle ??
                    '',
                content1: engineeringBranchesArchitectureList[widget.index1]
                        .postContent ??
                    '',
                root1: "All_About_Engineering",
                root2: "Engineering_Branches",
                index: "${widget.index1}",
                branch: "Engineering_Branches")))
        : null;
    super.initState();
    // _tabController = TabController(vsync: this, length: 3);
    _controller = TabController(length: 3, vsync: this);
    _controller?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      paginationList();
      selectedPage = 1;
    });
  }

  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
      isVisible = true;
    });
  }

  engineeringBranchesArchitecture(from) async {
    engineeringBranchesMecanicalList.clear();
    engineeringBranchesCivilList.clear();
    final response =
        await http.get(Uri.parse('${Config.baseURL}listengbranches/2/$from/5'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["engineeringbranchtopics"];
      setState(() {
        engineeringBranchesArchitectureList = jsonData
            .map<EngineeringBranchesModel>(
                (data) => EngineeringBranchesModel.fromJson(data))
            .toList();
      });
    } else {
      debugPrint('getDetailsJob get call error');
    }
  }

  engineeringBranchesCivil(from) async {
    engineeringBranchesArchitectureList.clear();
    engineeringBranchesMecanicalList.clear();
    final response =
        await http.get(Uri.parse('${Config.baseURL}listengbranches/3/$from/5'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["engineeringbranchtopics"];
      setState(() {
        engineeringBranchesCivilList = jsonData
            .map<EngineeringBranchesModel>(
                (data) => EngineeringBranchesModel.fromJson(data))
            .toList();
      });
    } else {
      debugPrint('getDetailsJob get call error');
    }
  }

  engineeringBranchesMecanical(from) async {
    engineeringBranchesArchitectureList.clear();
    engineeringBranchesCivilList.clear();
    final response =
        await http.get(Uri.parse('${Config.baseURL}listengbranches/1/$from/5'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["engineeringbranchtopics"];
      setState(() {
        engineeringBranchesMecanicalList = jsonData
            .map<EngineeringBranchesModel>(
                (data) => EngineeringBranchesModel.fromJson(data))
            .toList();
      });
    } else {
      debugPrint('getDetailsJob get call error');
    }
  }

  //Architecture ---- 2
  Future getDetails() async {
    final response =
        await http.get(Uri.parse('${Config.baseURL}listengbranches/2/0/10000'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["engineeringbranchtopics"];

      setState(() {
        engineeringBranchesArchitectureList = jsonData
            .map<EngineeringBranchesModel>(
                (data) => EngineeringBranchesModel.fromJson(data))
            .toList();
      });
      engineeringBranchesArchitecture(0);
      debugPrint('GetCall Success');
      debugPrint('Engg 123: ${engineeringBranchesArchitectureList.length}');
    } else {
      debugPrint('get call error');
    }
    debugPrint(
        "Fresher2IndustryArchitecture : $engineeringBranchesArchitectureList");
    // debugPrint("Service Details : $serviceDetails");
  }

  //Civil ---- 3
  Future getDetails1() async {
    final response =
        await http.get(Uri.parse('${Config.baseURL}listengbranches/3/0/10000'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData1 = jsonDecode(response.body)["engineeringbranchtopics"];

      setState(() {
        engineeringBranchesCivilList = jsonData1
            .map<EngineeringBranchesModel>(
                (data) => EngineeringBranchesModel.fromJson(data))
            .toList();
      });
      engineeringBranchesCivil(0);
      debugPrint('GetCall Success');
      debugPrint('Engg civil: ${engineeringBranchesCivilList.length}');
    } else {
      debugPrint('get call error');
    }
    debugPrint("Fresher2IndustryCivil : ${engineeringBranchesCivilList}");
    // debugPrint("Service Details : $serviceDetails");
  }

  //Mechanical ---- 1
  Future getDetails2() async {
    final response =
        await http.get(Uri.parse('${Config.baseURL}listengbranches/1/0/10000'));
    // final serviceResponse = await http.get(Uri.parse(''));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var viewed = (await prefs.getString('recentlyView'));
    debugPrint("Recently Viewed: --->  ${viewed}");
    // viewed?.add("EngineeringBranches");
    debugPrint("Recently Viewed: --->  ${viewed}");
    await prefs.setString("${viewed}", "${viewed.toString()}");
    // await prefs.setString("${viewed}", "${viewed.toString()}");
    if (response.statusCode == 200) {
      var jsonData2 = jsonDecode(response.body)["engineeringbranchtopics"];

      setState(() {
        engineeringBranchesMecanicalList = jsonData2
            .map<EngineeringBranchesModel>(
                (data) => EngineeringBranchesModel.fromJson(data))
            .toList();
      });
      engineeringBranchesMecanical(0);
      debugPrint('GetCall Success');
      debugPrint('Engg mechanical: ${engineeringBranchesMecanicalList.length}');
    } else {
      debugPrint('get call error');
    }
    debugPrint(
        "Fresher2IndustryMechanical : $engineeringBranchesMecanicalList");
    // debugPrint("Service Details : $serviceDetails");
  }

  Future HeaderList() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listheaders'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];

      setState(() {
        headerList = jsonData
                .map<headerModel>((data) => headerModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data headers, $jsonData');
      debugPrint('printing header List, ${headerList[6].headerName}');
    } else {
      debugPrint('get call error');
    }
  }

  pageList1(page) {
    switch (page) {
      case 1:
        engineeringBranchesArchitecture(0);
        break;
      case 2:
        engineeringBranchesArchitecture(5);
        break;
      case 3:
        engineeringBranchesArchitecture(10);
        break;
      case 4:
        engineeringBranchesArchitecture(15);
        break;
      case 5:
        engineeringBranchesArchitecture(20);
        break;
      case 6:
        engineeringBranchesArchitecture(25);
        break;
      case 7:
        engineeringBranchesArchitecture(30);
        break;
      case 8:
        engineeringBranchesArchitecture(35);
        break;
      case 9:
        engineeringBranchesArchitecture(40);
        break;
      case 10:
        engineeringBranchesArchitecture(45);
        break;
      case 11:
        engineeringBranchesArchitecture(50);
        break;
      case 12:
        engineeringBranchesArchitecture(55);
        break;
      case 13:
        engineeringBranchesArchitecture(60);
        break;
      case 14:
        engineeringBranchesArchitecture(65);
        break;
      case 15:
        engineeringBranchesArchitecture(70);
        break;
      case 16:
        engineeringBranchesArchitecture(75);
        break;
      case 17:
        engineeringBranchesArchitecture(80);
        break;
      case 18:
        engineeringBranchesArchitecture(85);
        break;
      case 19:
        engineeringBranchesArchitecture(90);
        break;
      case 20:
        engineeringBranchesArchitecture(95);
        break;
      default:
        engineeringBranchesArchitecture(100);
    }
  }

  pageList2(page) {
    switch (page) {
      case 1:
        engineeringBranchesCivil(0);
        break;
      case 2:
        engineeringBranchesCivil(5);
        break;
      case 3:
        engineeringBranchesCivil(10);
        break;
      case 4:
        engineeringBranchesCivil(15);
        break;
      case 5:
        engineeringBranchesCivil(20);
        break;
      case 6:
        engineeringBranchesCivil(25);
        break;
      case 7:
        engineeringBranchesCivil(30);
        break;
      case 8:
        engineeringBranchesCivil(35);
        break;
      case 9:
        engineeringBranchesCivil(40);
        break;
      case 10:
        engineeringBranchesCivil(45);
        break;
      case 11:
        engineeringBranchesCivil(50);
        break;
      case 12:
        engineeringBranchesCivil(55);
        break;
      case 13:
        engineeringBranchesCivil(60);
        break;
      case 14:
        engineeringBranchesCivil(65);
        break;
      case 15:
        engineeringBranchesCivil(70);
        break;
      case 16:
        engineeringBranchesCivil(75);
        break;
      case 17:
        engineeringBranchesCivil(80);
        break;
      case 18:
        engineeringBranchesCivil(85);
        break;
      case 19:
        engineeringBranchesCivil(90);
        break;
      case 20:
        engineeringBranchesCivil(95);
        break;
      default:
        engineeringBranchesCivil(100);
    }
  }

  pageList3(page) {
    switch (page) {
      case 1:
        engineeringBranchesMecanical(0);
        break;
      case 2:
        engineeringBranchesMecanical(5);
        break;
      case 3:
        engineeringBranchesMecanical(10);
        break;
      case 4:
        engineeringBranchesMecanical(15);
        break;
      case 5:
        engineeringBranchesMecanical(20);
        break;
      case 6:
        engineeringBranchesMecanical(25);
        break;
      case 7:
        engineeringBranchesMecanical(30);
        break;
      case 8:
        engineeringBranchesMecanical(35);
        break;
      case 9:
        engineeringBranchesMecanical(40);
        break;
      case 10:
        engineeringBranchesMecanical(45);
        break;
      case 11:
        engineeringBranchesMecanical(50);
        break;
      case 12:
        engineeringBranchesMecanical(55);
        break;
      case 13:
        engineeringBranchesMecanical(60);
        break;
      case 14:
        engineeringBranchesMecanical(65);
        break;
      case 15:
        engineeringBranchesMecanical(70);
        break;
      case 16:
        engineeringBranchesMecanical(75);
        break;
      case 17:
        engineeringBranchesMecanical(80);
        break;
      case 18:
        engineeringBranchesMecanical(85);
        break;
      case 19:
        engineeringBranchesMecanical(90);
        break;
      case 20:
        engineeringBranchesMecanical(95);
        break;
      default:
        engineeringBranchesMecanical(100);
    }
  }

  numberOfPages1() {
    double pgNum = engineeringBranchesArchitectureList.length / 5;
    return pgNum.ceil();
  }

  numberOfPages2() {
    double pgNum = engineeringBranchesCivilList.length / 5;
    return pgNum.ceil();
  }

  numberOfPages3() {
    double pgNum = engineeringBranchesMecanicalList.length / 5;
    return pgNum.ceil();
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/EngineeringBranches.json');
    //debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      head = jsonMap['main'];
      imagee = jsonMap["Immage"];
      discreption = jsonMap["heading"];
      discreption1 = jsonMap["heading1"];
      discreption2 = jsonMap["heading2"];
      expntile = jsonMap["categories"];
      var content = jsonMap["Topics"];
      expntile1 = jsonMap["categories"];
      expntile2 = jsonMap["categories"];
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
          pageList1(page);
          setState(() {
            selectedPage = (page);
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
    } else if (_controller?.index == 1) {
      return PaginationWidget(
        numOfPages: numberOfPages2(),
        selectedPage: selectedPage,
        pagesVisible: 3,
        spacing: 0,
        onPageChanged: (page) {
          debugPrint("Sending page $page");
          pageList2(page);
          setState(() {
            selectedPage = (page);
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
    } else {
      return PaginationWidget(
        numOfPages: numberOfPages3(),
        selectedPage: selectedPage,
        pagesVisible: 3,
        spacing: 0,
        onPageChanged: (page) {
          debugPrint("Sending page $page");
          pageList3(page);
          setState(() {
            selectedPage = (page);
          });
        },
        nextIcon: Icon(
          Icons.arrow_forward_ios,
          size: 12,
          color: selectedPage == numberOfPages3()
              ? Colors.grey
              : Color(0xff000000),
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
  }

  @override
  Widget build(BuildContext context) {
    // // Retrieve the arguments.
    // Map<String, dynamic> args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //
    // // Access the arguments.
    // widget.mode = args['mode'];
    // widget.index1 = args['index1'];

    // TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: App_Bar_widget2(title: head ?? ''),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (expntile == null)
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
            : DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 1.h,
                      ),
                      TabBar(
                        isScrollable: false,
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        controller: _controller,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Config.whiteColor,
                        labelColor: Config.whiteColor,
                        // indicatorSize: TabBarIndicatorSize.label,
                        //indicatorPadding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                        labelStyle: TextStyle(
                            fontSize: 11.sp, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: TextStyle(
                          color: Config.primaryTextColor,
                          fontSize: 10.sp,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Container(
                            width: 30.w,
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
                                ' Architecture ',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            width: 30.w,
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
                                ' Civil ',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            width: 30.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(7),
                                color: _controller?.index == 2
                                    ? Config.containerGreenColor
                                    : Config.mainBorderColor),
                            child: Tab(
                              key: UniqueKey(),
                              child: Text(
                                ' Mechanical ',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: Config.mainBorderColor,
                      ),
                      Expanded(
                        // flex: 4,
                        // height: 120.h,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _controller,
                          children: <Widget>[
                            //Architecture
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    headerList.isNotEmpty
                                        ? (headerList[8].headerContent ?? '')
                                        : '',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.black),
                                  ),
                                  Flexible(
                                    child: PageView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: 1,
                                        controller: _pageController,
                                        onPageChanged: (page) {
                                          setState(() {
                                            activePage = page as String?;
                                          });
                                        },
                                        itemBuilder: (context, pagePosition) {
                                          return (engineeringBranchesArchitectureList
                                                  .isEmpty)
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
                                              : ListView.builder(
                                                  key: Key(
                                                      selectedTile.toString()),
                                                  shrinkWrap: true,
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  //const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      engineeringBranchesArchitectureList
                                                              .length ??
                                                          0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Config
                                                                .mainBorderColor),
                                                      ),
                                                      child: Theme(
                                                          data: Theme.of(
                                                                  context)
                                                              .copyWith(
                                                                  dividerColor:
                                                                      Colors
                                                                          .transparent),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (context) => EngineeringBranchesDec(
                                                                      title:
                                                                          engineeringBranchesArchitectureList[index].postTitle ??
                                                                              '',
                                                                      content1:
                                                                          engineeringBranchesArchitectureList[index].postContent ??
                                                                              '',
                                                                      root1:
                                                                          "All_About_Engineering",
                                                                      root2:
                                                                          "Engineering_Branches",
                                                                      index:
                                                                          "${index}",
                                                                      branch:
                                                                          "Engineering_Branches")));
                                                            },
                                                            child: Container(
                                                              width: 92.w,
                                                              height: 5.h,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      color: Config
                                                                          .mainBorderColor,
                                                                      width:
                                                                          1)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 80.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: 2
                                                                              .w,
                                                                          top: 1
                                                                              .h,
                                                                          bottom:
                                                                              1.h),
                                                                      child:
                                                                          Text(
                                                                        engineeringBranchesArchitectureList[index].postTitle ??
                                                                            '',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right: 4
                                                                            .w),
                                                                    child: Image.asset(
                                                                        'assets/images/DoubleArrowIcon.png',
                                                                        width: 3
                                                                            .w),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                    );
                                                  });
                                        }),
                                  ),
                                  SizedBox(
                                    height: 5.h,
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
                                        color: selectedPage == 1
                                            ? Colors.grey
                                            : Color(0xff000000),
                                      ),
                                      activeTextStyle: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      activeBtnStyle: ButtonStyle(
                                        visualDensity:
                                            VisualDensity(horizontal: -4),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xff8cb93d)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            // side: const BorderSide(
                                            //  // color: Color(0xfff1f1f1),
                                            //   width: 1,
                                            // ),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(12)),
                                        // shadowColor:
                                        // MaterialStateProperty.all(
                                        //   const Color(0xfff1f1f1),
                                        // ),
                                      ),
                                      inactiveBtnStyle: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(10)),
                                        visualDensity:
                                            const VisualDensity(horizontal: 0),
                                        elevation: MaterialStateProperty.all(0),
                                        // backgroundColor:
                                        // MaterialStateProperty.all(
                                        //   const Color(0xfff9f9fb),
                                        // ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      inactiveTextStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Civil
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    headerList.isNotEmpty
                                        ? (headerList[8].headerContent ?? '')
                                        : '',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.black),
                                  ),
                                  Flexible(
                                    child: PageView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: 1,
                                        controller: _pageController,
                                        onPageChanged: (page) {
                                          setState(() {
                                            activePage = page as String?;
                                          });
                                        },
                                        itemBuilder: (context, pagePosition) {
                                          return (engineeringBranchesCivilList
                                                  .isEmpty)
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
                                              : ListView.builder(
                                                  key: Key(
                                                      selectedTile.toString()),
                                                  shrinkWrap: true,
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  //const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      engineeringBranchesCivilList
                                                              .length ??
                                                          0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Config
                                                                .mainBorderColor),
                                                      ),
                                                      child: Theme(
                                                          data: Theme.of(
                                                                  context)
                                                              .copyWith(
                                                                  dividerColor:
                                                                      Colors
                                                                          .transparent),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (context) => EngineeringBranchesDec(
                                                                      title:
                                                                          engineeringBranchesCivilList[index].postTitle ??
                                                                              '',
                                                                      content1:
                                                                          engineeringBranchesCivilList[index].postContent ??
                                                                              '',
                                                                      root1:
                                                                          "AllAboutEngineers",
                                                                      root2:
                                                                          "EngineeringBranches",
                                                                      index:
                                                                          "${index}",
                                                                      branch:
                                                                          "Engineering Branches")));
                                                            },
                                                            child: Container(
                                                              width: 92.w,
                                                              height: 5.h,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      color: Config
                                                                          .mainBorderColor,
                                                                      width:
                                                                          1)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 80.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: 2
                                                                              .w,
                                                                          top: 1
                                                                              .h,
                                                                          bottom:
                                                                              1.h),
                                                                      child:
                                                                          Text(
                                                                        engineeringBranchesCivilList[index].postTitle ??
                                                                            '',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right: 4
                                                                            .w),
                                                                    child: Image.asset(
                                                                        'assets/images/DoubleArrowIcon.png',
                                                                        width: 3
                                                                            .w),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                    );
                                                  });
                                        }),
                                  ),
                                  SizedBox(
                                    height: 5.h,
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
                                        color: selectedPage == 1
                                            ? Colors.grey
                                            : Color(0xff000000),
                                      ),
                                      activeTextStyle: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      activeBtnStyle: ButtonStyle(
                                        visualDensity:
                                            VisualDensity(horizontal: -4),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xff8cb93d)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            // side: const BorderSide(
                                            //  // color: Color(0xfff1f1f1),
                                            //   width: 1,
                                            // ),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(12)),
                                        // shadowColor:
                                        // MaterialStateProperty.all(
                                        //   const Color(0xfff1f1f1),
                                        // ),
                                      ),
                                      inactiveBtnStyle: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(10)),
                                        visualDensity:
                                            const VisualDensity(horizontal: 0),
                                        elevation: MaterialStateProperty.all(0),
                                        // backgroundColor:
                                        // MaterialStateProperty.all(
                                        //   const Color(0xfff9f9fb),
                                        // ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      inactiveTextStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Mechanical
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    headerList.isNotEmpty
                                        ? (headerList[8].headerContent ?? '')
                                        : '',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.black),
                                  ),
                                  Flexible(
                                    child: PageView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: 1,
                                        controller: _pageController,
                                        onPageChanged: (page) {
                                          setState(() {
                                            activePage = page as String?;
                                          });
                                        },
                                        itemBuilder: (context, pagePosition) {
                                          return (engineeringBranchesMecanicalList
                                                  .isEmpty)
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
                                              : ListView.builder(
                                                  key: Key(
                                                      selectedTile.toString()),
                                                  shrinkWrap: true,
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  //const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      engineeringBranchesMecanicalList
                                                              .length ??
                                                          0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Config
                                                                .mainBorderColor),
                                                      ),
                                                      child: Theme(
                                                          data: Theme.of(
                                                                  context)
                                                              .copyWith(
                                                                  dividerColor:
                                                                      Colors
                                                                          .transparent),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (context) => EngineeringBranchesDec(
                                                                      title:
                                                                          engineeringBranchesMecanicalList[index].postTitle ??
                                                                              '',
                                                                      content1:
                                                                          engineeringBranchesMecanicalList[index].postContent ??
                                                                              '',
                                                                      root1:
                                                                          "AllAboutEngineers",
                                                                      root2:
                                                                          "EngineeringBranches",
                                                                      index:
                                                                          "${index}",
                                                                      branch:
                                                                          "Engineering Branches")));
                                                            },
                                                            child: Container(
                                                              width: 92.w,
                                                              height: 5.h,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      color: Config
                                                                          .mainBorderColor,
                                                                      width:
                                                                          1)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 80.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: 2
                                                                              .w,
                                                                          top: 1
                                                                              .h,
                                                                          bottom:
                                                                              1.h),
                                                                      child:
                                                                          Text(
                                                                        engineeringBranchesMecanicalList[index].postTitle ??
                                                                            '',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right: 4
                                                                            .w),
                                                                    child: Image.asset(
                                                                        'assets/images/DoubleArrowIcon.png',
                                                                        width: 3
                                                                            .w),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                    );
                                                  });
                                        }),
                                  ),
                                  SizedBox(
                                    height: 5.h,
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
                                        color: selectedPage == 1
                                            ? Colors.grey
                                            : Color(0xff000000),
                                      ),
                                      activeTextStyle: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      activeBtnStyle: ButtonStyle(
                                        visualDensity:
                                            VisualDensity(horizontal: -4),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xff8cb93d)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            // side: const BorderSide(
                                            //  // color: Color(0xfff1f1f1),
                                            //   width: 1,
                                            // ),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(12)),
                                        // shadowColor:
                                        // MaterialStateProperty.all(
                                        //   const Color(0xfff1f1f1),
                                        // ),
                                      ),
                                      inactiveBtnStyle: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(10)),
                                        visualDensity:
                                            const VisualDensity(horizontal: 0),
                                        elevation: MaterialStateProperty.all(0),
                                        // backgroundColor:
                                        // MaterialStateProperty.all(
                                        //   const Color(0xfff9f9fb),
                                        // ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      inactiveTextStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // //Civil
                            // Container(
                            //   child: ListView(
                            //     children: [
                            //       Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(headerList.isNotEmpty  ? (headerList[8].headerContent ?? '') : '',
                            //             textAlign: TextAlign.left,
                            //             style: TextStyle(
                            //               fontSize: 11.sp,
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //           SizedBox(height: 0.5.h),
                            //           (engineeringBranchesCivilList.isEmpty)
                            //               ? Center(
                            //             child: Row(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //               children: [
                            //                 Text(
                            //                   'Loading',
                            //                   style: TextStyle(
                            //                     fontWeight: FontWeight.bold,
                            //                     fontSize: 15.sp,
                            //                     color: Config.primaryTextColor,
                            //                   ),
                            //                 ),
                            //                 SizedBox(
                            //                   width: 2.w,
                            //                 ),
                            //                 const CupertinoActivityIndicator(
                            //                   radius: 25,
                            //                   color: Colors.black,
                            //                 ),
                            //               ],
                            //             ),
                            //           )
                            //               :ListView.builder(
                            //               key: Key(selectedTile.toString()),
                            //               shrinkWrap: true,
                            //               physics: const ClampingScrollPhysics(),
                            //               //const NeverScrollableScrollPhysics(),
                            //               itemCount: engineeringBranchesCivilList.length ?? 0,
                            //               itemBuilder: (context, index) {
                            //                 return Container(
                            //                   margin: const EdgeInsets.only(top: 10, bottom: 5),
                            //                   decoration: BoxDecoration(
                            //                     borderRadius: BorderRadius.circular(10),
                            //                     border: Border.all(color: Config.mainBorderColor),
                            //                   ),
                            //                   child: Theme(
                            //                       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            //                       child: InkWell(
                            //                         onTap: () {
                            //                           Navigator.of(context).push(
                            //                               MaterialPageRoute(builder: (context)=>
                            //                                   EngineeringBranchesDec(title: engineeringBranchesCivilList[index].postTitle ?? '',
                            //                                     content: engineeringBranchesCivilList[index].postContent ?? '',
                            //                                       branch: "Engineering Branches") ));
                            //                         },
                            //                         child: Container(
                            //                           width: 92.w, height: 5.h,
                            //                           decoration: BoxDecoration(
                            //                               borderRadius: BorderRadius.circular(10),
                            //                               border: Border.all(color: Config.mainBorderColor,width: 1)
                            //                           ),
                            //                           child: Row(
                            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                             children: [
                            //                               Container(
                            //                                 width: 80.w,
                            //                                 child: Padding(
                            //                                   padding: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.h),
                            //                                   child: Text(engineeringBranchesCivilList[index].postTitle ?? '',
                            //                                     overflow: TextOverflow.ellipsis,
                            //                                     maxLines: 1,
                            //                                     style: TextStyle(
                            //                                         fontSize: 12.sp,
                            //                                         fontWeight: FontWeight.w600
                            //                                     ),),
                            //                                 ),
                            //                               ),
                            //                               Padding(
                            //                                 padding: EdgeInsets.only(right: 4.w),
                            //                                 child: InkWell(
                            //                                     child: Image.asset('assets/images/DoubleArrowIcon.png',width: 3.w),
                            //                                   onTap: () {
                            //                                     Navigator.of(context).push(
                            //                                         MaterialPageRoute(builder: (context)=>
                            //                                             EngineeringBranchesDec(title: engineeringBranchesCivilList[index].postTitle ?? '',
                            //                                               content: engineeringBranchesCivilList[index].postContent ?? '',
                            //                                                 branch: "Engineering Branches") ));
                            //                                   },),
                            //                               )
                            //                             ],
                            //                           ),
                            //                         ),
                            //                       )
                            //                   ),
                            //                 );
                            //               }),
                            //           SizedBox(height: 1.w,),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            //
                            // //Mechanical
                            // Container(
                            //   child: ListView(
                            //     children: [
                            //       Column(
                            //         crossAxisAlignment:
                            //         CrossAxisAlignment.start,
                            //         children: [
                            //           Text(headerList.isNotEmpty  ? (headerList[8].headerContent ?? '') : '',
                            //             textAlign: TextAlign.left,
                            //             style: TextStyle(
                            //               fontSize: 11.sp,
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //           SizedBox(height: 0.5.h),
                            //           (engineeringBranchesMecanicalList.isEmpty)
                            //               ? Center(
                            //             child: Row(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //               children: [
                            //                 Text(
                            //                   'Loading',
                            //                   style: TextStyle(
                            //                     fontWeight: FontWeight.bold,
                            //                     fontSize: 15.sp,
                            //                     color: Config.primaryTextColor,
                            //                   ),
                            //                 ),
                            //                 SizedBox(
                            //                   width: 2.w,
                            //                 ),
                            //                 const CupertinoActivityIndicator(
                            //                   radius: 25,
                            //                   color: Colors.black,
                            //                 ),
                            //               ],
                            //             ),
                            //           )
                            //               :ListView.builder(
                            //               key: Key(selectedTile.toString()),
                            //               shrinkWrap: true,
                            //               physics: const ClampingScrollPhysics(),
                            //               //const NeverScrollableScrollPhysics(),
                            //               itemCount: engineeringBranchesMecanicalList.length ?? 0,
                            //               itemBuilder: (context, index) {
                            //                 return Container(
                            //                   margin: const EdgeInsets.only(
                            //                       top: 10, bottom: 5),
                            //                   decoration: BoxDecoration(
                            //                     borderRadius:
                            //                     BorderRadius.circular(10),
                            //                     border: Border.all(color: Config.mainBorderColor),
                            //                   ),
                            //                   child: Theme(
                            //                       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            //                       child: InkWell(
                            //                         onTap: () {
                            //                           Navigator.of(context).push(
                            //                               MaterialPageRoute(builder: (context)=>
                            //                                   EngineeringBranchesDec(title: engineeringBranchesMecanicalList[index].postTitle ?? '',
                            //                                     content: engineeringBranchesMecanicalList[index].postContent ?? '',
                            //                                       branch: "Engineering Branches") ));
                            //                         },
                            //                         child: Container(
                            //                           width: 92.w, height: 5.h,
                            //                           decoration: BoxDecoration(
                            //                               borderRadius: BorderRadius.circular(10),
                            //                               border: Border.all(color: Config.mainBorderColor,width: 1)
                            //                           ),
                            //                           child: Row(
                            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                             children: [
                            //                               Container(
                            //                                 width: 80.w,
                            //                                 child: Padding(
                            //                                   padding: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.h),
                            //                                   child: Text(engineeringBranchesMecanicalList[index].postTitle ?? '',
                            //                                     overflow: TextOverflow.ellipsis,
                            //                                     maxLines: 1,
                            //                                     style: TextStyle(
                            //                                         fontSize: 12.sp,
                            //                                         fontWeight: FontWeight.w600,
                            //                                     ),),
                            //                                 ),
                            //                               ),
                            //                               Padding(
                            //                                 padding: EdgeInsets.only(right: 4.w),
                            //                                 child: InkWell(
                            //                                   child: Image.asset('assets/images/DoubleArrowIcon.png',width: 3.w),
                            //                                   onTap: () {
                            //                                     Navigator.of(context).push(
                            //                                         MaterialPageRoute(builder: (context)=>
                            //                                             EngineeringBranchesDec(title: engineeringBranchesMecanicalList[index].postTitle ?? '',
                            //                                               content: engineeringBranchesMecanicalList[index].postContent ?? '',
                            //                                                 branch: "Engineering Branches") ));
                            //                                   },),
                            //                               )
                            //                             ],
                            //                           ),
                            //                         ),
                            //                       )
                            //                   ),
                            //                 );
                            //               }),
                            //           SizedBox(height: 1.w,),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: (engineeringBranches.length > 5) ? paginationList() : null,
      ),
    );
  }
}
