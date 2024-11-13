import 'dart:convert';
import 'package:careercoach/techtrends1.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'Config.dart';
import 'Models/TechnologyFresherProfessionalModel.dart';
import 'Models/headerModel.dart';
import 'SqlLiteDB/db_helper.dart';
import 'Widgets/App_Bar_Widget.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'Widgets/pagination.dart';

class TechnologyTrends extends StatefulWidget {
  const TechnologyTrends({Key? key}) : super(key: key);

  @override
  State<TechnologyTrends> createState() => _TechnologyTrendsState();
}

class _TechnologyTrendsState extends State<TechnologyTrends>
    with SingleTickerProviderStateMixin {
  int selectedPage = 1;
  late TabController _controller;
  late PageController _pageController;
  List? details;
  List? details2;
  List? details3;
  String? activePage;
  List? details1;
  List? tab2data;
  List? tab3data;
  List? onlineList;

  List<TechnologyFresherProfessionalModel> listlatesttech = [];
  List<TechnologyFresherProfessionalModel> listsoftwarereleases = [];
  List<TechnologyFresherProfessionalModel> sotwareversions = [];
  List<TechnologyFresherProfessionalModel> technologyTrendsList1 = [];
  List<TechnologyFresherProfessionalModel> technologyTrendsList2 = [];
  List<TechnologyFresherProfessionalModel> technologyTrendsList3 = [];
  
  List<headerModel> headerList = [];

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "Technology Trends",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  @override
  void initState() {
    loadJson();
    saveToRecent();
    getDetails();
    HeaderList();
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(_handleTabSelection);
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

  void _handleTabSelection() {
    setState(() {
      debugPrint('Tapped on tab && tab Changes');
      //technologyTrends(0);
      getDetails();
      paginationList();
      selectedPage = 1;
    });
  }

  numberOfPages1() {
    double pgNum = listlatesttech.length / 5;
    return pgNum.ceil();
  }

  numberOfPages2() {
    double pgNum = listsoftwarereleases.length / 5;
    return pgNum.ceil();
  }

  numberOfPages3() {
    double pgNum = sotwareversions.length / 5;
    return pgNum.ceil();
  }

  Future getDetails() async {
    final response = await http.get(
      Uri.parse('${Config.baseURL}listlatesttech/0/50000'),
    );
    final responseReleases = await http.get(
      Uri.parse('${Config.baseURL}listsoftwarereleases/0/50000'),
    );
    // final responseVersion = await http.get(
    //   Uri.parse('${Config.baseURL}listsoftwareversions/0/50000'),
    // );
    debugPrint('coming to link');
    debugPrint('response.body');
    if (response.statusCode == 200) {
      debugPrint("list: ${response.body}");
      var jsonData = jsonDecode(response.body)["listlatesttech"];
      var jsonDataReleases =
          jsonDecode(responseReleases.body)["listsoftwarereleases"];
      // var jsonDataVersion = jsonDecode(responseVersion.body)["sotwareversions"];
      setState(() {
        listlatesttech = jsonData
            .map<TechnologyFresherProfessionalModel>(
                (data) => TechnologyFresherProfessionalModel.fromJson(data))
            .toList();
        listsoftwarereleases = jsonDataReleases
            .map<TechnologyFresherProfessionalModel>(
                (data) => TechnologyFresherProfessionalModel.fromJson(data))
            .toList();
        // sotwareversions = jsonDataVersion
        //     .map<TechnologyFresherProfessionalModel>(
        //         (data) => TechnologyFresherProfessionalModel.fromJson(data))
        //     .toList();
      });
      technologyTrends(0);
    } else {
      debugPrint('get call error');
    }
  }

  technologyTrends(from) async {
    technologyTrendsList1.clear();
    technologyTrendsList2.clear();
    // technologyTrendsList3.clear();
    final response = await http.get(
      Uri.parse('${Config.baseURL}listlatesttech/$from/5'),
    );
    final responseReleases = await http.get(
      Uri.parse('${Config.baseURL}listsoftwarereleases/$from/5'),
    );
    // final responseVersion = await http.get(
    //   Uri.parse('${Config.baseURL}listsoftwareversions/$from/5'),
    // );

    if (response.statusCode == 200) {
      // debugPrint("list: ${responseVersion.body}");
      var jsonData = jsonDecode(response.body)["listlatesttech"];
      var jsonDataReleases =
          jsonDecode(responseReleases.body)["listsoftwarereleases"];
      // var jsonDataVersion = jsonDecode(responseVersion.body)["sotwareversions"];
      setState(() {
        technologyTrendsList1 = jsonData
            .map<TechnologyFresherProfessionalModel>(
                (data) => TechnologyFresherProfessionalModel.fromJson(data))
            .toList();
        technologyTrendsList2 = jsonDataReleases
            .map<TechnologyFresherProfessionalModel>(
                (data) => TechnologyFresherProfessionalModel.fromJson(data))
            .toList();
        // technologyTrendsList3 = jsonDataVersion
        //     .map<TechnologyFresherProfessionalModel>(
        //         (data) => TechnologyFresherProfessionalModel.fromJson(data))
        //     .toList();
      });
    } else {
      debugPrint('get call error');
    }
  }

  pageList(page) {
    switch (page) {
      case 1:
        technologyTrends(0);
        break;
      case 2:
        technologyTrends(5);
        break;
      case 3:
        technologyTrends(10);
        break;
      case 4:
        technologyTrends(15);
        break;
      case 5:
        technologyTrends(20);
        break;
      case 6:
        technologyTrends(25);
        break;
      case 7:
        technologyTrends(30);
        break;
      case 8:
        technologyTrends(35);
        break;
      case 9:
        technologyTrends(40);
        break;
      case 10:
        technologyTrends(45);
        break;
      case 11:
        technologyTrends(50);
        break;
      case 12:
        technologyTrends(55);
        break;
      case 13:
        technologyTrends(60);
        break;
      case 14:
        technologyTrends(65);
        break;
      case 15:
        technologyTrends(70);
        break;
      case 16:
        technologyTrends(75);
        break;
      case 17:
        technologyTrends(80);
        break;
      case 18:
        technologyTrends(85);
        break;
      case 19:
        technologyTrends(90);
        break;
      case 20:
        technologyTrends(95);
        break;
      default:
        technologyTrends(100);
    }
  }

  paginationList() {
    if (_controller.index == 0) {
      pageList(0);
      return PaginationWidget(
        numOfPages: numberOfPages1(),
        selectedPage: selectedPage,
        pagesVisible: 3,
        spacing: 0,
        onPageChanged: (page) {
          pageList(page);
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
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
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
      );
    } else if (_controller.index == 1) {
      pageList(0);
      technologyTrendsList1.clear();
      technologyTrendsList3.clear();
      return PaginationWidget(
        numOfPages: numberOfPages2(),
        selectedPage: selectedPage,
        pagesVisible: 3,
        spacing: 0,
        onPageChanged: (page) {
          pageList(page);
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
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
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
      );
    }
   
  }

  Future loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/techTrends.json');
    debugPrint("Checking map: jsonMap");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      details = jsonMap["data"];
      details2 = jsonMap["data1"];
      details3 = jsonMap["data2"];
      details1 = jsonMap["topics"];
      tab2data = jsonMap["tab2info"];
      tab3data = jsonMap["tab3info"];
      print(details);
      print(details1);
      print(tab2data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: const App_Bar_widget(title: 'Technology Trends'),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: (listlatesttech.isEmpty)
              ? const Center(
                  child: CupertinoActivityIndicator(
                    radius: 25,
                    color: Colors.black,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: ListView(
                    children: [
                      DefaultTabController(
                        length: 3,
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // Tab bar container
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TabBar(
                                physics: const NeverScrollableScrollPhysics(),
                                isScrollable: false,
                                padding: EdgeInsets.zero,
                                labelPadding: EdgeInsets.zero,
                                controller: _controller,
                                unselectedLabelColor: Colors.black,
                                indicatorColor: Config.containerGreenColor,
                                labelColor: Config.whiteColor,
                                indicatorPadding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 0, bottom: 0),
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
                                    height: 5.6.h,
                                    width: 46.w,
                                    //margin: EdgeInsets.only(left: 30, right: 30),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        color: _controller.index == 0
                                            ? Config.containerGreenColor
                                            : Config.mainBorderColor),
                                    child: Tab(
                                      key: UniqueKey(),
                                      child: Container(
                                        width: 21.w,
                                        height: 5.2.h,
                                        child: Center(
                                          child: Text(
                                            headerList.isNotEmpty
                                                ? (headerList[3].headerName ??
                                                    '')
                                                : '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 5.6.h,
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
                                        headerList.isNotEmpty
                                            ? (headerList[4].headerName ?? '')
                                            : '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          //color: _controller.index == 1 ? Config
                                        ),
                                      ),
                                    ),
                                  ),
                                 
                                ],
                              ),
                            ),
                            //const Divider(thickness: 6, color: Config.containerGreenColor,),
                            //green line
                            Container(
                              margin:
                                  EdgeInsets.only(left: 3.8.w, right: 3.8.w),
                              height: 0.5.h,
                              width: 100.w,
                              decoration: const BoxDecoration(
                                color: Config.containerGreenColor,
                              ),
                            ),
                            //tab content
                            Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.80,
                                  child: TabBarView(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: _controller,
                                    children: <Widget>[
                                      // Latest Technology tab
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(3.8.w),
                                            child: Column(children: [
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                headerList.isNotEmpty
                                                    ? (headerList[3]
                                                            .headerContent ??
                                                        '')
                                                    : '',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black),
                                              ),
                                            ]),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 3.8.w, right: 3.8.w),
                                              child: PageView.builder(
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  itemCount: 1,
                                                  controller: _pageController,
                                                  onPageChanged: (page) {
                                                    setState(() {
                                                      activePage =
                                                          page as String?;
                                                    });
                                                  },
                                                  itemBuilder:
                                                      (context, pagePosition) {
                                                    return (technologyTrendsList1
                                                            .isEmpty)
                                                        ? const Center(
                                                            child:
                                                                CupertinoActivityIndicator(
                                                              radius: 25,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        : ListView.builder(
                                                            physics:
                                                                const ClampingScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                technologyTrendsList1
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Column(
                                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  InkWell(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          11.h,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        border: Border.all(
                                                                            color:
                                                                                Config.mainBorderColor),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            'assets/images/img.png',
                                                                            height:
                                                                                11.5.h,
                                                                            width:
                                                                                26.6.w,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                          SizedBox(
                                                                              width: 2.w),
                                                                          Flexible(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(height: 1.w),
                                                                                Container(
                                                                                  height: 4.4.h,
                                                                                  child: Text(
                                                                                    technologyTrendsList1[index].postTitle.toString() ?? '',
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 2,
                                                                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height: 1.w),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 50.w,
                                                                                      height: 4.4.h,
                                                                                      child: Text(
                                                                                        technologyTrendsList1[index].postContent.toString() ?? '',
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        maxLines: 2,
                                                                                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                                                      ),
                                                                                    ),
                                                                                    Column(
                                                                                      children: [
                                                                                        Container(
                                                                                          height: 2.h,
                                                                                        ),
                                                                                        Container(
                                                                                          height: 1.5.h,
                                                                                          child: Align(
                                                                                              alignment: Alignment.bottomRight,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.only(right: 8.0),
                                                                                                child: Image.asset('assets/images/DoubleArrowIcon.png', width: 5.w),
                                                                                              )),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 0.1.w,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      Navigator.of(context).push(MaterialPageRoute(
                                                                          builder: (context) => TopicTitle(
                                                                                content: technologyTrendsList1[index].postContent.toString() ?? '',
                                                                                title: technologyTrendsList1[index].postTitle.toString() ?? '',
                                                                                topic: 'Latest Technology',
                                                                              )));
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                    height: 1.h,
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                  }),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                            child: PaginationWidget(
                                              numOfPages: numberOfPages1(),
                                              selectedPage: selectedPage,
                                              pagesVisible: 3,
                                              spacing: 0,
                                              onPageChanged: (page) {
                                                pageList(page);
                                                setState(() {
                                                  selectedPage = page;
                                                });
                                              },
                                              nextIcon: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12,
                                                color: selectedPage ==
                                                        numberOfPages1()
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
                                                visualDensity: VisualDensity(
                                                    horizontal: -4),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xff8cb93d)),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    // side: const BorderSide(
                                                    //  // color: Color(0xfff1f1f1),
                                                    //   width: 1,
                                                    // ),
                                                  ),
                                                ),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.all(
                                                            12)),
                                                // shadowColor:
                                                // MaterialStateProperty.all(
                                                //   const Color(0xfff1f1f1),
                                                // ),
                                              ),
                                              inactiveBtnStyle: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.all(
                                                            10)),
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: 0),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                // backgroundColor:
                                                // MaterialStateProperty.all(
                                                //   const Color(0xfff9f9fb),
                                                // ),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                              ),
                                              inactiveTextStyle:
                                                  const TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // New S/W Releases tab
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 3.8.w,
                                                right: 3.8.w,
                                                top: 3.8.w),
                                            child: Column(children: [
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                headerList.isNotEmpty
                                                    ? (headerList[4]
                                                            .headerContent ??
                                                        '')
                                                    : '',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ]),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 3.8.w,
                                                  right: 3.8.w,
                                                  top: 3.8.w),
                                              child: PageView.builder(
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  itemCount: 1,
                                                  controller: _pageController,
                                                  onPageChanged: (page) {
                                                    setState(() {
                                                      activePage =
                                                          page as String?;
                                                    });
                                                  },
                                                  itemBuilder:
                                                      (context, pagePosition) {
                                                    return (technologyTrendsList2
                                                            .isEmpty)
                                                        ? const Center(
                                                            child:
                                                                CupertinoActivityIndicator(
                                                              radius: 25,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        : ListView.builder(
                                                            physics:
                                                                const ClampingScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                technologyTrendsList2
                                                                        .length ??
                                                                    0,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Column(
                                                                children: [
                                                                  InkWell(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          11.h,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        border: Border.all(
                                                                            color:
                                                                                Config.mainBorderColor),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            'assets/images/img.png',
                                                                            height:
                                                                                11.5.h,
                                                                            width:
                                                                                26.6.w,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                2.w,
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(height: 1.w),
                                                                                Container(
                                                                                  height: 4.4.h,
                                                                                  child: Text(
                                                                                    technologyTrendsList2[index].postTitle.toString() ?? '',
                                                                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height: 1.w),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 50.w,
                                                                                      height: 4.4.h,
                                                                                      child: Text(
                                                                                        technologyTrendsList2[index].postContent.toString() ?? '',
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        maxLines: 2,
                                                                                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                                                      ),
                                                                                    ),
                                                                                    Column(
                                                                                      children: [
                                                                                        Container(
                                                                                          height: 2.h,
                                                                                        ),
                                                                                        Container(
                                                                                          height: 1.5.h,
                                                                                          child: Align(
                                                                                              alignment: Alignment.bottomRight,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.only(right: 8.0),
                                                                                                child: Image.asset('assets/images/DoubleArrowIcon.png', width: 5.w),
                                                                                              )),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      Navigator.of(context).push(MaterialPageRoute(
                                                                          builder: (context) => TopicTitle(
                                                                                content: technologyTrendsList2[index].postContent.toString() ?? '',
                                                                                title: technologyTrendsList2[index].postTitle.toString() ?? '',
                                                                                topic: 'New S/w releases',
                                                                              )));
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          1.h)
                                                                ],
                                                              );
                                                            });
                                                  }),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                            child: PaginationWidget(
                                              numOfPages: numberOfPages2(),
                                              selectedPage: selectedPage,
                                              pagesVisible: 3,
                                              spacing: 0,
                                              onPageChanged: (page) {
                                                pageList(page);
                                                setState(() {
                                                  selectedPage = page;
                                                });
                                              },
                                              nextIcon: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12,
                                                color: selectedPage ==
                                                        numberOfPages2()
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
                                                visualDensity: VisualDensity(
                                                    horizontal: -4),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xff8cb93d)),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    // side: const BorderSide(
                                                    //  // color: Color(0xfff1f1f1),
                                                    //   width: 1,
                                                    // ),
                                                  ),
                                                ),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.all(
                                                            12)),
                                                // shadowColor:
                                                // MaterialStateProperty.all(
                                                //   const Color(0xfff1f1f1),
                                                // ),
                                              ),
                                              inactiveBtnStyle: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.all(
                                                            10)),
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: 0),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                // backgroundColor:
                                                // MaterialStateProperty.all(
                                                //   const Color(0xfff9f9fb),
                                                // ),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                              ),
                                              inactiveTextStyle:
                                                  const TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
