import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import 'package:http/http.dart' as http;
import '../Models/interviewPrepModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';

class InterviewType extends StatefulWidget {
  const InterviewType({Key? key}) : super(key: key);

  @override
  State<InterviewType> createState() => _InterviewTypeState();
}

class _InterviewTypeState extends State<InterviewType>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final ScrollController _scrollController = ScrollController();
  String? head;
  List? Que;
  List? Quee;
  List? Queee;
  String? image;
  String? immage;
  String? data1;
  String? data2;
  String? data3;
  String? data;
  String? dataa;
  late PageController _pageController;
  List<InterviewTypeModel> interviewTypeItems = [];
  List<InterviewTypeModel> interviewTypeItems1len = [];
  List<InterviewTypeModel> interviewTypeItems2len = [];
  List<InterviewTypeModel> interviewTypeItems3len = [];
  List<InterviewTypeModel> interviewTypeItems1 = [];
  List<InterviewTypeModel> interviewTypeItems2 = [];
  List<InterviewTypeModel> interviewTypeItems3 = [];
  int selectedPage = 1;

  setSelectedPage(int, index) {
    setState(() {
      selectedPage = index;
    });
  }

  numberOfPages1() {
    double pgNum = interviewTypeItems1len.length / 5;
    return pgNum.ceil();
  }

  numberOfPages2() {
    double pgNum = interviewTypeItems2len.length / 5;
    return pgNum.ceil();
  }

  numberOfPages3() {
    double pgNum = interviewTypeItems3len.length / 5;
    return pgNum.ceil();
  }

  Future getDetails() async {
    final response = await http.get(
      Uri.parse('${Config.baseURL}interviewformat/1/0/50000'),
    );
    final responseReleases = await http.get(
      Uri.parse('${Config.baseURL}interviewformat/2/0/50000'),
    );
    final responseVersion = await http.get(
      Uri.parse('${Config.baseURL}interviewformat/3/0/50000'),
    );
    debugPrint('coming to link');
    debugPrint('response.body');
    if (response.statusCode == 200) {
      debugPrint("list: ${response.body}");
      var jsonData = jsonDecode(response.body)["Interviewformat"];
      var jsonDataReleases =
          jsonDecode(responseReleases.body)["Interviewformat"];
      var jsonDataVersion = jsonDecode(responseVersion.body)["Interviewformat"];
      setState(() {
        interviewTypeItems1len = jsonData
            .map<InterviewTypeModel>(
                (data) => InterviewTypeModel.fromJson(data))
            .toList();
        interviewTypeItems2len = jsonDataReleases
            .map<InterviewTypeModel>(
                (data) => InterviewTypeModel.fromJson(data))
            .toList();
        interviewTypeItems3len = jsonDataVersion
            .map<InterviewTypeModel>(
                (data) => InterviewTypeModel.fromJson(data))
            .toList();
      });
    } else {
      debugPrint('get call error');
    }
  }

  pageList1(page) {
    switch (page) {
      case 1:
        PopularTypeList(0);
        break;
      case 2:
        PopularTypeList(5);
        break;
      case 3:
        PopularTypeList(10);
        break;
      case 4:
        PopularTypeList(15);
        break;
      case 5:
        PopularTypeList(20);
        break;
      case 6:
        PopularTypeList(25);
        break;
      case 7:
        PopularTypeList(30);
        break;
      case 8:
        PopularTypeList(35);
        break;
      case 9:
        PopularTypeList(40);
        break;
      case 10:
        PopularTypeList(45);
        break;
      case 11:
        PopularTypeList(50);
        break;
      case 12:
        PopularTypeList(55);
        break;
      case 13:
        PopularTypeList(60);
        break;
      case 14:
        PopularTypeList(65);
        break;
      case 15:
        PopularTypeList(70);
        break;
      case 16:
        PopularTypeList(75);
        break;
      case 17:
        PopularTypeList(80);
        break;
      case 18:
        PopularTypeList(85);
        break;
      case 19:
        PopularTypeList(90);
        break;
      case 20:
        PopularTypeList(95);
        break;
      default:
        PopularTypeList(100);
    }
  }

  pageList2(page) {
    switch (page) {
      case 1:
        TrendingTypeList(0);
        break;
      case 2:
        TrendingTypeList(5);
        break;
      case 3:
        TrendingTypeList(10);
        break;
      case 4:
        TrendingTypeList(15);
        break;
      case 5:
        TrendingTypeList(20);
        break;
      case 6:
        TrendingTypeList(25);
        break;
      case 7:
        TrendingTypeList(30);
        break;
      case 8:
        TrendingTypeList(35);
        break;
      case 9:
        TrendingTypeList(40);
        break;
      case 10:
        TrendingTypeList(45);
        break;
      case 11:
        TrendingTypeList(50);
        break;
      case 12:
        TrendingTypeList(55);
        break;
      case 13:
        TrendingTypeList(60);
        break;
      case 14:
        TrendingTypeList(65);
        break;
      case 15:
        TrendingTypeList(70);
        break;
      case 16:
        TrendingTypeList(75);
        break;
      case 17:
        TrendingTypeList(80);
        break;
      case 18:
        TrendingTypeList(85);
        break;
      case 19:
        TrendingTypeList(90);
        break;
      case 20:
        TrendingTypeList(95);
        break;
      default:
        TrendingTypeList(100);
    }
  }

  pageList3(page) {
    switch (page) {
      case 1:
        NewTypeList(0);
        break;
      case 2:
        NewTypeList(5);
        break;
      case 3:
        NewTypeList(10);
        break;
      case 4:
        NewTypeList(15);
        break;
      case 5:
        NewTypeList(20);
        break;
      case 6:
        NewTypeList(25);
        break;
      case 7:
        NewTypeList(30);
        break;
      case 8:
        NewTypeList(35);
        break;
      case 9:
        NewTypeList(40);
        break;
      case 10:
        NewTypeList(45);
        break;
      case 11:
        NewTypeList(50);
        break;
      case 12:
        NewTypeList(55);
        break;
      case 13:
        NewTypeList(60);
        break;
      case 14:
        NewTypeList(65);
        break;
      case 15:
        NewTypeList(70);
        break;
      case 16:
        NewTypeList(75);
        break;
      case 17:
        NewTypeList(80);
        break;
      case 18:
        NewTypeList(85);
        break;
      case 19:
        NewTypeList(90);
        break;
      case 20:
        NewTypeList(95);
        break;
      default:
        NewTypeList(100);
    }
  }

  pageList(page) {
    switch (page) {
      case 1:
        InterviewTypeList(0);
        break;
      case 2:
        InterviewTypeList(5);
        break;
      case 3:
        InterviewTypeList(10);
        break;
      case 4:
        InterviewTypeList(15);
        break;
      case 5:
        InterviewTypeList(20);
        break;
      case 6:
        InterviewTypeList(25);
        break;
      case 7:
        InterviewTypeList(30);
        break;
      case 8:
        InterviewTypeList(35);
        break;
      case 9:
        InterviewTypeList(40);
        break;
      case 10:
        InterviewTypeList(45);
        break;
      case 11:
        InterviewTypeList(50);
        break;
      case 12:
        InterviewTypeList(55);
        break;
      case 13:
        InterviewTypeList(60);
        break;
      case 14:
        InterviewTypeList(65);
        break;
      case 15:
        InterviewTypeList(70);
        break;
      case 16:
        InterviewTypeList(75);
        break;
      case 17:
        InterviewTypeList(80);
        break;
      case 18:
        InterviewTypeList(85);
        break;
      case 19:
        InterviewTypeList(90);
        break;
      case 20:
        InterviewTypeList(95);
        break;
      default:
        InterviewTypeList(100);
    }
  }

  //
  paginationList1() {
    if (_controller?.index == 0) {
      // interviewTypeItems3.clear();
      // interviewTypeItems2.clear();
      return SizedBox(
        height: 7.h,
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
    } else if (_controller?.index == 1) {
      interviewTypeItems1.clear();
      // interviewTypeItems3.clear();
      return SizedBox(
        height: 7.h,
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
    } else {
      // interviewTypeItems1.clear();
      interviewTypeItems2.clear();
      return SizedBox(
        height: 7.h,
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

  //
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
      interviewTypeItems1.clear();
      interviewTypeItems3.clear();
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
    } else if (_controller.index == 2) {
      pageList(0);
      interviewTypeItems1.clear();
      interviewTypeItems2.clear();
      return PaginationWidget(
        numOfPages: numberOfPages3(),
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

  //GET CALL FOR ALL TABS
  InterviewTypeList(from) async {
    interviewTypeItems1.clear();
    interviewTypeItems2.clear();
    interviewTypeItems3.clear();
    final response = await http.get(
      Uri.parse('${Config.baseURL}interviewformat/1/$from/5'),
    );
    final responseReleases = await http.get(
      Uri.parse('${Config.baseURL}interviewformat/2/$from/5'),
    );
    final responseVersion = await http.get(
      Uri.parse('${Config.baseURL}interviewformat/3/$from/5'),
    );

    if (response.statusCode == 200) {
      debugPrint("list: ${responseVersion.body}");
      var jsonDataPopular = jsonDecode(response.body)["Interviewformat"];
      var jsonDataTrending =
          jsonDecode(responseReleases.body)["Interviewformat"];
      var jsonDataNew = jsonDecode(responseVersion.body)["Interviewformat"];
      setState(() {
        interviewTypeItems1 = jsonDataPopular
            .map<InterviewTypeModel>(
                (data) => InterviewTypeModel.fromJson(data))
            .toList();
        interviewTypeItems2 = jsonDataTrending
            .map<InterviewTypeModel>(
                (data) => InterviewTypeModel.fromJson(data))
            .toList();
        interviewTypeItems3 = jsonDataNew
            .map<InterviewTypeModel>(
                (data) => InterviewTypeModel.fromJson(data))
            .toList();
      });
      // InterviewTypeList(0);
    } else {
      debugPrint('get call error');
    }
  }

  PopularTypeList(from) async {
    final response = await http.get(
      Uri.parse('${Config.baseURL}interviewformat/1/$from/5'),
    );
    if (response.statusCode == 200) {
      // debugPrint("list: ${responseVersion.body}");
      var jsonDataPopular = jsonDecode(response.body)["Interviewformat"];
      setState(() {
        interviewTypeItems1 = jsonDataPopular
            .map<InterviewTypeModel>(
                (data) => InterviewTypeModel.fromJson(data))
            .toList();
      });
      // InterviewTypeList(0);
    } else {
      debugPrint('get call error in interviewTypeItems1');
    }
  }

  TrendingTypeList(from) async {
    final responseReleases = await http.get(
      Uri.parse('${Config.baseURL}interviewformat/2/$from/5'),
    );
    if (responseReleases.statusCode == 200) {
      // debugPrint("list: ${responseVersion.body}");
      var jsonDataTrending =
          jsonDecode(responseReleases.body)["Interviewformat"];
      setState(() {
        interviewTypeItems2 = jsonDataTrending
            .map<InterviewTypeModel>(
                (data) => InterviewTypeModel.fromJson(data))
            .toList();
      });
      // InterviewTypeList(0);
    } else {
      debugPrint('get call error in interviewTypeItems2');
    }
  }

  NewTypeList(from) async {
    final responseVersion = await http.get(
      Uri.parse('${Config.baseURL}interviewformat/3/$from/5'),
    );
    if (responseVersion.statusCode == 200) {
      var jsonDataNew = jsonDecode(responseVersion.body)["Interviewformat"];
      setState(() {
        interviewTypeItems3 = jsonDataNew
            .map<InterviewTypeModel>(
                (data) => InterviewTypeModel.fromJson(data))
            .toList();
      });
      // InterviewTypeList(0);
    } else {
      debugPrint('get call error in interviewTypeItems3');
    }
  }

  //Get Call
  // InterviewTypeDetailList() async{
  //   final response = await http.get(Uri.parse('${Config.baseURL}interviewformat/1/0/5'));
  //   // https://psmprojects.net/cadworld/interviewformat/1/0/5
  //   if(response.statusCode == 200){
  //     var jsonData = jsonDecode(response.body)["Interviewformat"];
  //     setState(() {
  //       interviewTypeItems = jsonData.map<InterviewTypeModel>((data)=>InterviewTypeModel.fromJson(data)).toList();
  //     });
  //     debugPrint('GetCall in interviewType was Success');
  //     debugPrint('printing json data headers, $jsonData');
  //     // debugPrint('printing header List, ${interviewTypeItems}');
  //   }else{
  //     debugPrint('get call error');
  //   }
  //
  // }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/interviewtype.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      Que = jsonMap['Questions'];
      Quee = jsonMap['Questions2'];
      Queee = jsonMap["Questions3"];
      immage = jsonMap["image"];
      data1 = jsonMap["para1"];
      data2 = jsonMap["para2"];
      data3 = jsonMap["para3"];
      data = jsonMap["para"];
      dataa = jsonMap["paraa"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    // InterviewTypeDetailList();
    InterviewTypeList(0);
    getDetails();
    _pageController = PageController();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      InterviewTypeList(0);
      selectedPage = 1;
      // numberOfPages2();
      // numberOfPages3();
      paginationList();
    });
  }

//final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.3.h),
            child: const App_Bar_widget1(
              title: 'Interview Types/Formats',
            )),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: (interviewTypeItems1?.length == 0)
              ? const Center(
                  child: CupertinoActivityIndicator(
                    radius: 25,
                    color: Colors.black,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 15, bottom: 5),
                  child: Container(
                    height: 90.h,
                    child: ListView(
                      children: <Widget>[
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
                                      height: 4.h,
                                      width: 32.6.w,
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
                                              'Popular',
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
                                      height: 4.h,
                                      width: 32.6.w,
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
                                          'Trending',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            //color: _controller.index == 1 ? Config
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 4.h,
                                      width: 32.7.w,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          color: _controller.index == 2
                                              ? Config.containerGreenColor
                                              : Config.mainBorderColor),
                                      child: Tab(
                                        key: UniqueKey(),
                                        child: Text(
                                          'New',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11.sp,
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
                              Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * 1,
                                    child: TabBarView(
                                      controller: _controller,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const SizedBox(height: 5),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: Config
                                                            .font_size_12.sp),
                                                    text: (data1 ?? ''),
                                                    children: [
                                                      TextSpan(
                                                        text: data2 ?? '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      TextSpan(
                                                          text: data3 ?? ''),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    bottom: 5,
                                                    left: 5,
                                                    right: 5),
                                                child: ListView.builder(
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        interviewTypeItems1
                                                            ?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        margin:
                                                            EdgeInsets.all(3),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          border: Border.all(
                                                              color: Config
                                                                  .containerColor),
                                                        ),
                                                        child: Container(
                                                          width: 91.w,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Theme(
                                                            data: Theme.of(
                                                                    context)
                                                                .copyWith(
                                                                    dividerColor:
                                                                        Colors
                                                                            .transparent),
                                                            child:
                                                                ExpansionTile(
                                                              iconColor:
                                                                  Colors.black,
                                                              collapsedBackgroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Config
                                                                      .containerColor,
                                                              title: Text(
                                                                interviewTypeItems1?[
                                                                            index]
                                                                        .postTitle ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12.sp),
                                                              ),
                                                              children: [
                                                                Divider(
                                                                  thickness: 1,
                                                                  color: Config
                                                                      .gradientBottom,
                                                                ),
                                                                Scrollbar(
                                                                 
                                                                  controller:
                                                                      _scrollController,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    // controller: _scrollController,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    child: (interviewTypeItems1?.length ==
                                                                            0)
                                                                        ? Center(
                                                                            child:
                                                                                Row(
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
                                                                        : Container(
                                                                            height:
                                                                                10.h,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              scrollDirection: Axis.vertical,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top: 0, bottom: 8, left: 16, right: 14),
                                                                                child: Text(
                                                                                  interviewTypeItems1?[index].postContent ?? '',
                                                                                  style: TextStyle(
                                                                                    fontSize: 12.sp,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              // SizedBox(
                                              //   height: 5.h,
                                              //   child: PaginationWidget(
                                              //     numOfPages:
                                              //         numberOfPages1(),
                                              //     selectedPage: selectedPage,
                                              //     pagesVisible: 3,
                                              //     spacing: 0,
                                              //     onPageChanged: (page) {
                                              //       pageList(page);
                                              //       setState(() {
                                              //         selectedPage = page;
                                              //       });
                                              //     },
                                              //     nextIcon: Icon(
                                              //       Icons.arrow_forward_ios,
                                              //       size: 12,
                                              //       color: selectedPage ==
                                              //               numberOfPages1()
                                              //           ? Colors.grey
                                              //           : Color(0xff000000),
                                              //     ),
                                              //     previousIcon: Icon(
                                              //       Icons.arrow_back_ios,
                                              //       size: 12,
                                              //       color: selectedPage == 1
                                              //           ? Colors.grey
                                              //           : Color(0xff000000),
                                              //     ),
                                              //     activeTextStyle: TextStyle(
                                              //       color: Color(0xffffffff),
                                              //       fontSize: 11.sp,
                                              //       fontWeight:
                                              //           FontWeight.w700,
                                              //     ),
                                              //     activeBtnStyle: ButtonStyle(
                                              //       visualDensity:
                                              //           VisualDensity(
                                              //               horizontal: -4),
                                              //       backgroundColor:
                                              //           MaterialStateProperty
                                              //               .all(const Color(
                                              //                   0xff8cb93d)),
                                              //       shape:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //         RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(7),
                                              //           // side: const BorderSide(
                                              //           //  // color: Color(0xfff1f1f1),
                                              //           //   width: 1,
                                              //           // ),
                                              //         ),
                                              //       ),
                                              //       padding:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //                   const EdgeInsets
                                              //                       .all(12)),
                                              //       // shadowColor:
                                              //       // MaterialStateProperty.all(
                                              //       //   const Color(0xfff1f1f1),
                                              //       // ),
                                              //     ),
                                              //     inactiveBtnStyle:
                                              //         ButtonStyle(
                                              //       padding:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //                   const EdgeInsets
                                              //                       .all(10)),
                                              //       visualDensity:
                                              //           const VisualDensity(
                                              //               horizontal: 0),
                                              //       elevation:
                                              //           MaterialStateProperty
                                              //               .all(0),
                                              //       // backgroundColor:
                                              //       // MaterialStateProperty.all(
                                              //       //   const Color(0xfff9f9fb),
                                              //       // ),
                                              //       shape:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //         RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(15),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     inactiveTextStyle:
                                              //         const TextStyle(
                                              //       fontSize: 15,
                                              //       color: Color(0xff333333),
                                              //       fontWeight:
                                              //           FontWeight.w700,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        //
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 5),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                        text: (data1 ?? ''),
                                                        children: [
                                                      TextSpan(
                                                          text: data ?? '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text: data3 ?? '')
                                                    ])),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    bottom: 5,
                                                    left: 5,
                                                    right: 5),
                                                child: ListView.builder(
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: interviewTypeItems2
                                                      ?.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      width: 91.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                                dividerColor: Colors
                                                                    .transparent),
                                                        child: ExpansionTile(
                                                          iconColor:
                                                              Colors.black,
                                                          collapsedBackgroundColor:
                                                              Colors.white,
                                                          backgroundColor: Config
                                                              .containerColor,
                                                          title: Text(
                                                            interviewTypeItems2?[
                                                                        index]
                                                                    .postTitle ??
                                                                '',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    12.sp),
                                                          ),
                                                          children: [
                                                            Divider(
                                                              thickness: 1,
                                                              color: Config
                                                                  .gradientBottom,
                                                            ),
                                                            Scrollbar(
                                                        
                                                              controller:
                                                                  _scrollController,
                                                              child:
                                                                  SingleChildScrollView(
                                                                // controller: _scrollController,
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                child: (interviewTypeItems2
                                                                            ?.length ==
                                                                        0)
                                                                    ? Center(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
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
                                                                    : Container(
                                                                        height:
                                                                            10.h,
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.vertical,
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                top: 0,
                                                                                bottom: 8,
                                                                                left: 16,
                                                                                right: 14),
                                                                            child:
                                                                                Text(
                                                                              interviewTypeItems2?[index].postContent ?? '',
                                                                              style: TextStyle(
                                                                                fontSize: 12.sp,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              // SizedBox(
                                              //   height: 5.h,
                                              //   child: PaginationWidget(
                                              //     numOfPages:
                                              //         numberOfPages1(),
                                              //     selectedPage: selectedPage,
                                              //     pagesVisible: 3,
                                              //     spacing: 0,
                                              //     onPageChanged: (page) {
                                              //       pageList(page);
                                              //       setState(() {
                                              //         selectedPage = page;
                                              //       });
                                              //     },
                                              //     nextIcon: Icon(
                                              //       Icons.arrow_forward_ios,
                                              //       size: 12,
                                              //       color: selectedPage ==
                                              //               numberOfPages1()
                                              //           ? Colors.grey
                                              //           : Color(0xff000000),
                                              //     ),
                                              //     previousIcon: Icon(
                                              //       Icons.arrow_back_ios,
                                              //       size: 12,
                                              //       color: selectedPage == 1
                                              //           ? Colors.grey
                                              //           : Color(0xff000000),
                                              //     ),
                                              //     activeTextStyle: TextStyle(
                                              //       color: Color(0xffffffff),
                                              //       fontSize: 11.sp,
                                              //       fontWeight:
                                              //           FontWeight.w700,
                                              //     ),
                                              //     activeBtnStyle: ButtonStyle(
                                              //       visualDensity:
                                              //           VisualDensity(
                                              //               horizontal: -4),
                                              //       backgroundColor:
                                              //           MaterialStateProperty
                                              //               .all(const Color(
                                              //                   0xff8cb93d)),
                                              //       shape:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //         RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(7),
                                              //           // side: const BorderSide(
                                              //           //  // color: Color(0xfff1f1f1),
                                              //           //   width: 1,
                                              //           // ),
                                              //         ),
                                              //       ),
                                              //       padding:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //                   const EdgeInsets
                                              //                       .all(12)),
                                              //       // shadowColor:
                                              //       // MaterialStateProperty.all(
                                              //       //   const Color(0xfff1f1f1),
                                              //       // ),
                                              //     ),
                                              //     inactiveBtnStyle:
                                              //         ButtonStyle(
                                              //       padding:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //                   const EdgeInsets
                                              //                       .all(10)),
                                              //       visualDensity:
                                              //           const VisualDensity(
                                              //               horizontal: 0),
                                              //       elevation:
                                              //           MaterialStateProperty
                                              //               .all(0),
                                              //       // backgroundColor:
                                              //       // MaterialStateProperty.all(
                                              //       //   const Color(0xfff9f9fb),
                                              //       // ),
                                              //       shape:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //         RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(15),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     inactiveTextStyle:
                                              //         const TextStyle(
                                              //       fontSize: 15,
                                              //       color: Color(0xff333333),
                                              //       fontWeight:
                                              //           FontWeight.w700,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        //
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(13.0),
                                                child: RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                        text: (data1 ?? ''),
                                                        children: [
                                                      TextSpan(
                                                          text: dataa ?? '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text: data3 ?? '')
                                                    ])),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    bottom: 5,
                                                    left: 5,
                                                    right: 5),
                                                child: ListView.builder(
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        interviewTypeItems3
                                                            ?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        width: 91.w,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: Config
                                                                  .containerColor),
                                                        ),
                                                        child: Theme(
                                                          data: Theme.of(
                                                                  context)
                                                              .copyWith(
                                                                  dividerColor:
                                                                      Colors
                                                                          .transparent),
                                                          child: ExpansionTile(
                                                            iconColor:
                                                                Colors.black,
                                                            collapsedBackgroundColor:
                                                                Colors.white,
                                                            backgroundColor: Config
                                                                .containerColor,
                                                            title: Text(
                                                              interviewTypeItems3?[
                                                                          index]
                                                                      .postTitle ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      12.sp),
                                                            ),
                                                            // trailing: const Icon(Icons.keyboard_arrow_down_outlined,color: Config.primaryTextColor,),
                                                            children: [
                                                              Divider(
                                                                thickness: 1,
                                                                color: Config
                                                                    .gradientBottom,
                                                              ),
                                                              Scrollbar(
                                                              
                                                                controller:
                                                                    _scrollController,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  // controller: _scrollController,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  child: (interviewTypeItems3
                                                                              ?.length ==
                                                                          0)
                                                                      ? Center(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
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
                                                                      : Container(
                                                                          height:
                                                                              10.h,
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(top: 0, bottom: 8, left: 16, right: 14),
                                                                              child: Text(
                                                                                interviewTypeItems3?[index].postContent ?? '',
                                                                                style: TextStyle(
                                                                                  fontSize: 12.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              // SizedBox(
                                              //   height: 5.h,
                                              //   child: PaginationWidget(
                                              //     numOfPages:
                                              //         numberOfPages1(),
                                              //     selectedPage: selectedPage,
                                              //     pagesVisible: 3,
                                              //     spacing: 0,
                                              //     onPageChanged: (page) {
                                              //       pageList(page);
                                              //       setState(() {
                                              //         selectedPage = page;
                                              //       });
                                              //     },
                                              //     nextIcon: Icon(
                                              //       Icons.arrow_forward_ios,
                                              //       size: 12,
                                              //       color: selectedPage ==
                                              //               numberOfPages1()
                                              //           ? Colors.grey
                                              //           : Color(0xff000000),
                                              //     ),
                                              //     previousIcon: Icon(
                                              //       Icons.arrow_back_ios,
                                              //       size: 12,
                                              //       color: selectedPage == 1
                                              //           ? Colors.grey
                                              //           : Color(0xff000000),
                                              //     ),
                                              //     activeTextStyle: TextStyle(
                                              //       color: Color(0xffffffff),
                                              //       fontSize: 11.sp,
                                              //       fontWeight:
                                              //           FontWeight.w700,
                                              //     ),
                                              //     activeBtnStyle: ButtonStyle(
                                              //       visualDensity:
                                              //           VisualDensity(
                                              //               horizontal: -4),
                                              //       backgroundColor:
                                              //           MaterialStateProperty
                                              //               .all(const Color(
                                              //                   0xff8cb93d)),
                                              //       shape:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //         RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(7),
                                              //           // side: const BorderSide(
                                              //           //  // color: Color(0xfff1f1f1),
                                              //           //   width: 1,
                                              //           // ),
                                              //         ),
                                              //       ),
                                              //       padding:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //                   const EdgeInsets
                                              //                       .all(12)),
                                              //       // shadowColor:
                                              //       // MaterialStateProperty.all(
                                              //       //   const Color(0xfff1f1f1),
                                              //       // ),
                                              //     ),
                                              //     inactiveBtnStyle:
                                              //         ButtonStyle(
                                              //       padding:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //                   const EdgeInsets
                                              //                       .all(10)),
                                              //       visualDensity:
                                              //           const VisualDensity(
                                              //               horizontal: 0),
                                              //       elevation:
                                              //           MaterialStateProperty
                                              //               .all(0),
                                              //       // backgroundColor:
                                              //       // MaterialStateProperty.all(
                                              //       //   const Color(0xfff9f9fb),
                                              //       // ),
                                              //       shape:
                                              //           MaterialStateProperty
                                              //               .all(
                                              //         RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(15),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     inactiveTextStyle:
                                              //         const TextStyle(
                                              //       fontSize: 15,
                                              //       color: Color(0xff333333),
                                              //       fontWeight:
                                              //           FontWeight.w700,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
/*
                            Padding(
                              padding: const EdgeInsets.only(left: 8,right: 7,top: 8,bottom: 30),
                              child: Container(
                                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffDBEBE2)),
                                    borderRadius: BorderRadius.circular(8), color: Color(0xffF3F6F4)),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Like what you see? Further training needs?'
                                          'reach us below:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 14.sp, height: 1.5),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 1.w,),
                                        Image.asset('assets/images/call.png',height: 2.5.h,),
                                        SizedBox(width: 1.w,),
                                        Text("   +91 9X9X9X9X9X; 040-24892489"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 1.w,),
                                        Icon(Icons.mail,size: 20.sp,),
                                        SizedBox(width: 2.8.w,),
                                        Text('support@cadcareercoach.com\nenquiry@gmail.com'),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
*/
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: SizedBox(
          height: 35.h,
          child: Column(
            children: [
              // Container(
              //   height: 2.h,
              // ),
              // paginationList(),
              paginationList1(),
              // Container(
              //   height: 2.h,
              // ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 7, top: 8, bottom: 30),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffDBEBE2)),
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffF3F6F4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Like what you see? Further training needs?'
                        'reach us below:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            height: 1.5),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 1.w,
                          ),
                          Image.asset(
                            'assets/images/call.png',
                            height: 2.5.h,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("   +91 9X9X9X9X9X; 040-24892489"),
                        ],
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 1.w,
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.mail,
                                size: 20.sp,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Column(
                            children: [
                              Text(
                                  'support@cadcareercoach.com\nenquiry@gmail.com'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            // (engineeringBranches.length > 5) ? paginationList() : null,
            ),
      ),
    );
  }
}
