import 'dart:convert';
import 'package:careercoach/techtrends1.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'Config.dart';
import 'Models/TechnologyFresherProfessionalModel.dart';
import 'Widgets/App_Bar_Widget.dart';
import 'package:http/http.dart' as http;

import 'Widgets/pagination.dart';

class TechnologyTrends__ extends StatefulWidget {
  const TechnologyTrends__({Key? key}) : super(key: key);

  @override
  State<TechnologyTrends__> createState() => _TechnologyTrends__State();
}

class _TechnologyTrends__State extends State<TechnologyTrends__>
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
    // final  controller = CarouselController();

  @override
  void initState() {
    loadJson();
    getDetails();
    technologyTrends(0);
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(_handleTabSelection1);
    _controller.addListener(_handleTabSelection2);
    _controller.addListener(_handleTabSelection3);
  }

  void _handleTabSelection1() {
    setState(() {
      numberOfPages1();
      //dispose();
      pageList(0);
      technologyTrendsList1.clear();
      technologyTrendsList2.clear();
      technologyTrendsList3.clear();
    });
  }
  void _handleTabSelection2() {
    setState(() {
      numberOfPages2();
      pageList(0);
      technologyTrendsList1.clear();
      technologyTrendsList2.clear();
      technologyTrendsList3.clear();
    });
  }
  void _handleTabSelection3() {
    setState(() {
      numberOfPages3();
      pageList(0);
      technologyTrendsList1.clear();
      technologyTrendsList2.clear();
      technologyTrendsList3.clear();
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
    final response = await http.get(Uri.parse
      ('${Config.baseURL}listlatesttech/0/50'),
    );
    final responseReleases = await http.get(
      Uri.parse('${Config.baseURL}listsoftwarereleases/0/50'),
    );
    final responseVersion = await http.get(
      Uri.parse('${Config.baseURL}listsoftwareversions/0/50'),
    );
    debugPrint('coming to link');
    debugPrint('response.body');
    if (response.statusCode == 200) {
      debugPrint("list: ${response.body}");
      var jsonData = jsonDecode(response.body)["listlatesttech"];
      var jsonDataReleases =
      jsonDecode(responseReleases.body)["listsoftwarereleases"];
      var jsonDataVersion = jsonDecode(responseVersion.body)["sotwareversions"];
      setState(() {
        listlatesttech = jsonData.map<TechnologyFresherProfessionalModel>(
                (data) => TechnologyFresherProfessionalModel.fromJson(data))
            .toList();
        listsoftwarereleases =
            jsonDataReleases.map<TechnologyFresherProfessionalModel>(
                    (data) => TechnologyFresherProfessionalModel.fromJson(data))
                .toList();
        sotwareversions =
            jsonDataVersion.map<TechnologyFresherProfessionalModel>(
                    (data) => TechnologyFresherProfessionalModel.fromJson(data))
                .toList();
      });
      technologyTrends(0);
    } else {
      debugPrint('get call error');
    }
  }

  technologyTrends(from) async {
    technologyTrendsList1.clear();
    technologyTrendsList2.clear();
    technologyTrendsList3.clear();
    final response = await http.get(
      Uri.parse('${Config.baseURL}listlatesttech/$from/5'),
    );
    final responseReleases = await http.get(
      Uri.parse('${Config.baseURL}listsoftwarereleases/$from/5'),
    );
    final responseVersion = await http.get(
      Uri.parse('${Config.baseURL}listsoftwareversions/$from/5'),
    );

    if (response.statusCode == 200) {
      debugPrint("list: ${responseVersion.body}");
      var jsonData = jsonDecode(response.body)["listlatesttech"];
      var jsonDataReleases =
      jsonDecode(responseReleases.body)["listsoftwarereleases"];
      var jsonDataVersion = jsonDecode(responseVersion.body)["sotwareversions"];
      setState(() {
        technologyTrendsList1 =
            jsonData.map<TechnologyFresherProfessionalModel>(
                    (data) => TechnologyFresherProfessionalModel.fromJson(data))
                .toList();
        technologyTrendsList2 =
            jsonDataReleases.map<TechnologyFresherProfessionalModel>(
                    (data) => TechnologyFresherProfessionalModel.fromJson(data))
                .toList();
        technologyTrendsList3 =
            jsonDataVersion.map<TechnologyFresherProfessionalModel>(
                    (data) => TechnologyFresherProfessionalModel.fromJson(data))
                .toList();
      });
    } else {
      debugPrint('get call error');
    }
  }

  pageList(page) {
    switch (page) {
      case 1:
        technologyTrends(1);
        break;
      case 2:
        technologyTrends(6);
        break;
      case 3:
        technologyTrends(11);
        break;
      case 4:
        technologyTrends(16);
        break;
      case 5:
        technologyTrends(21);
        break;
      case 6:
        technologyTrends(26);
        break;
      case 7:
        technologyTrends(31);
        break;
      default:
        technologyTrends(36);
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

  int pageIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late bool _showCartBadge;
  Color color = const Color(0xfff7d78c);
  String? image;
  // final CarouselController carouselController = CarouselController();
  int Bottom_selectedIndex1 = 0;

  void _onItemTapped(int index) {
    setState(() {
      Bottom_selectedIndex1 = index;
      technologyTrends(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetoptions = <Widget>[
      // Latest Technology tab
      Column(
        children: [
          Padding(
            padding: EdgeInsets.all(3.8.w),
            child: Column(children: [
              Text(
                'In the fields of ACM there are revolutionary technologies evolving to solve the worldly needs…\n\n Some of the niche technologies to look out for :',
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
            ]),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 3.8.w, right: 3.8.w),
              child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: 1,
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page as String?;
                    });
                  },
                  itemBuilder:
                      (context, pagePosition) {
                    return (technologyTrendsList1
                        .isEmpty) ? const Center(
                      child: CupertinoActivityIndicator(
                        radius: 25,
                        color: Colors.black,
                      ),)
                        : ListView.builder(
                        physics:
                        const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: technologyTrendsList1
                            .length ?? 0,
                        itemBuilder:
                            (BuildContext context,
                            int index) {
                          return Column(
                            children: [
                              InkWell(
                                child: Container(
                                  height: 11.h,
                                  decoration:
                                  BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(8),
                                    border: Border
                                        .all(
                                        color: Config
                                            .mainBorderColor),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/img.png',
                                        height: 11.5
                                            .h,
                                        width: 26.6.w,
                                        fit: BoxFit
                                            .fill,),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Flexible(
                                        child:
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              technologyTrendsList1[index]
                                                  .postTitle
                                                  .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 4
                                                      .w,
                                                  fontWeight: FontWeight
                                                      .w600),
                                            ),
                                            SizedBox(
                                              height:
                                              1.w,
                                            ),
                                            Text(
                                              technologyTrendsList1[index]
                                                  .postContent
                                                  .toString() ??
                                                  '',
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 4
                                                      .w,
                                                  fontWeight: FontWeight
                                                      .w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 10.h,
                                        child: Align(
                                            alignment: Alignment
                                                .bottomRight,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .only(
                                                  right: 8.0),
                                              child: Image
                                                  .asset(
                                                  'assets/images/DoubleArrowIcon.png',
                                                  width: 3
                                                      .w),
                                            )),
                                      )
                                      // child: Icon(Icons.keyboard_double_arrow_right_rounded,size: 20.sp,))
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(
                                      context).push(
                                      MaterialPageRoute(
                                          builder: (
                                              context) =>
                                              TopicTitle(
                                                content:
                                                technologyTrendsList1[index]
                                                    .postContent
                                                    .toString() ??
                                                    '',
                                                title:
                                                technologyTrendsList1[index]
                                                    .postTitle
                                                    .toString() ??
                                                    '',
                                                topic:
                                                'Latest Technology',
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
          PaginationWidget(
                            numOfPages: numberOfPages1(),
                            selectedPage: selectedPage,
                            pagesVisible: 3,
                            spacing: 0,
                            onPageChanged: (page) {
                              debugPrint("Sending page $page");
                              pageList(page);
                              setState(() {
                                selectedPage = page;
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
                          ),
        ],
      ),
      // New S/W Releases tab
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3.8.w,
                right: 3.8.w,
                top: 3.8.w),
            child: Column(children: [
              Text(
                "In the fields of ACM based on the automation needs and technologies, there has been a tremendous NEW Software releases. some of the new softwares to look out for:",
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
            ]),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 3.8.w,
                  right: 3.8.w,
                  top: 3.8.w),
              child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: 1,
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page as String?;
                    });
                  },
                  itemBuilder:
                      (context, pagePosition) {
                    return (technologyTrendsList2
                        .isEmpty) ? const Center(
                        child: CircularProgressIndicator())
                        : ListView.builder(
                        physics:
                        const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: technologyTrendsList2
                            .length ?? 0,
                        itemBuilder: (
                            BuildContext context,
                            int index) {
                          return Column(
                            children: [
                              InkWell(
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(8),
                                    border: Border
                                        .all(
                                        color: Config
                                            .mainBorderColor),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/img.png',
                                        height: 11.5
                                            .h,
                                        width: 26.6.w,
                                        fit: BoxFit
                                            .fill,),
                                      // Image.asset(
                                      //   technologyTrendsList2[index].postImage ??'',
                                      //   height: 12.h,
                                      //   width: 26.w,
                                      //   fit: BoxFit.fill,
                                      // ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Flexible(
                                        child:
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              technologyTrendsList2[index]
                                                  .postTitle
                                                  .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 4
                                                      .w,
                                                  fontWeight: FontWeight
                                                      .w600),
                                            ),
                                            Text(
                                              technologyTrendsList2[index]
                                                  .postContent
                                                  .toString() ??
                                                  '',
                                              overflow:
                                              TextOverflow
                                                  .ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 4
                                                      .w,
                                                  fontWeight: FontWeight
                                                      .w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 10.h,
                                        width: 5.w,
                                        child: Align(
                                            alignment: Alignment
                                                .bottomRight,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .only(
                                                  right: 8.0),
                                              child: Image
                                                  .asset(
                                                  'assets/images/DoubleArrowIcon.png',
                                                  width: 3
                                                      .w),
                                            )),
                                      )
                                      // child: Icon(Icons.keyboard_double_arrow_right_rounded,size: 20.sp,))
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(
                                      context).push(
                                      MaterialPageRoute(
                                          builder: (
                                              context) =>
                                              TopicTitle(
                                                content:
                                                technologyTrendsList2[index]
                                                    .postContent
                                                    .toString() ??
                                                    '',
                                                title:
                                                technologyTrendsList2[index]
                                                    .postTitle
                                                    .toString() ??
                                                    '',
                                                topic:
                                                'New S/w releases',
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
          PaginationWidget(
            numOfPages: numberOfPages2(),
            selectedPage: selectedPage,
            pagesVisible: 3,
            spacing: 0,
            onPageChanged: (page) {
              debugPrint("Sending page $page");
              pageList(page);
              setState(() {
                selectedPage = page;
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
          ),
        ],
      ),
      // S/W Versions (by latest) tab
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3.8.w,
                right: 3.8.w,
                top: 3.8.w),
            child: Column(children: [
              Text(
                'The latest S/W versions for the established software\'s in the ACM fields are as below',
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
            ]),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 3.8.w,
                  right: 3.8.w,
                  top: 3.8.w),
              child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: 1,
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page as String?;
                    });
                  },
                  itemBuilder:
                      (context, pagePosition) {
                    return (technologyTrendsList3
                        .isEmpty) ? const Center(
                        child: CircularProgressIndicator())
                        : ListView.builder(
                        physics:
                        const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: technologyTrendsList3
                            .length ?? 0,
                        itemBuilder: (
                            BuildContext context,
                            int index) {
                          return Column(
                            children: [
                              InkWell(
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(8),
                                    border: Border
                                        .all(
                                        color: Config
                                            .mainBorderColor),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/img.png',
                                        height: 11.5
                                            .h,
                                        width: 26.6.w,
                                        fit: BoxFit
                                            .fill,),
                                      // Image.asset(
                                      //   technologyTrendsList3[index].postImage ?? '',
                                      //   height: 12.h,
                                      //   width: 26.w,
                                      //   fit: BoxFit.fill,
                                      // ),
                                      SizedBox(
                                        width: 2.w,),
                                      Flexible(
                                        child:
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              technologyTrendsList3[index]
                                                  .postTitle
                                                  .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 4
                                                      .w,
                                                  fontWeight: FontWeight
                                                      .w600),
                                            ),
                                            Text(
                                              technologyTrendsList3[index]
                                                  .availableFrom
                                                  .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 4
                                                      .w,
                                                  fontWeight: FontWeight
                                                      .w400),
                                            ),
                                            Text(
                                              technologyTrendsList3[index]
                                                  .downloadLink
                                                  .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 4
                                                      .w,
                                                  fontWeight: FontWeight
                                                      .w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 10.h,
                                        child: Align(
                                            alignment: Alignment
                                                .bottomRight,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .only(
                                                  right: 8.0),
                                              child: Image
                                                  .asset(
                                                  'assets/images/DoubleArrowIcon.png',
                                                  width: 3
                                                      .w),
                                            )),
                                      )
                                      // child: Icon(Icons.keyboard_double_arrow_right_rounded,size: 20.sp,))
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(
                                      context).push(
                                      MaterialPageRoute(
                                          builder: (
                                              context) =>
                                              TopicTitle(
                                                content:
                                                technologyTrendsList3[index]
                                                    .downloadLink
                                                    .toString() ??
                                                    '',
                                                title:
                                                technologyTrendsList3[index]
                                                    .postTitle
                                                    .toString() ??
                                                    '',
                                                topic:
                                                'S/W versions (by latest)',
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
          PaginationWidget(
            numOfPages: numberOfPages3(),
            selectedPage: selectedPage,
            pagesVisible: 3,
            spacing: 0,
            onPageChanged: (page) {
              debugPrint("Sending page $page");
              pageList(page);
              setState(() {
                selectedPage = page;
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
          ),
        ],
      )
    ];
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(7.h),
      child: App_Bar_widget(title: 'Technology Trends',)),
      body: SafeArea(
        child: widgetoptions.elementAt(Bottom_selectedIndex1),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        unselectedItemColor: Config.mainBorderColor,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text(
              'Latest \n Technology',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'New S/w \n releases',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'S/W versions \n (by latest)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
              ),
            ),
            label: '',
          ),
        ],
        currentIndex: Bottom_selectedIndex1,
        selectedItemColor: Config.containerGreenColor,
        onTap: _onItemTapped,
      ),
    );
    
    
    
  }
  }
