import 'dart:convert';
import 'package:careercoach/Models/headerModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../Config.dart';
import '../Models/allAboutEngineeringModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'Engineering Basics decription.dart';
import 'Engineering Branches decription.dart';

class EngineeringBasics extends StatefulWidget {
  const EngineeringBasics({Key? key}) : super(key: key);

  @override
  State<EngineeringBasics> createState() => _EngineeringBasicsState();
}

class _EngineeringBasicsState extends State<EngineeringBasics>
    with SingleTickerProviderStateMixin {
  List? data;
  String? head;
  String? sub;
  String? imagee;
  String? logo;
  String? discreption;
  List? expntile;
  int selectedTile = -1;
  List<EngineeringBasicsModel> engineeringBasics = [];
  List<EngineeringBasicsModel> engineeringBasicsList = [];
  List<headerModel>headerList = [];



  late TabController _controller;

  @override
  void initState() {
    getData();
    getDetails();
    HeaderList();
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  Future HeaderList() async{

    final response = await http.get(Uri.parse('${Config.baseURL}listheaders'));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["categories"];

      setState(() {
        headerList = jsonData.map<headerModel>((data) =>headerModel.fromJson(data)).toList() ?? [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data headers, $jsonData');
      debugPrint('printing header List, ${headerList[10].headerName}');
    }else{
      debugPrint('get call error');
    }

  }


  engineeringBasicsDetails(from) async{
    engineeringBasicsList.clear();
    final response = await http.get(Uri.parse('${Config.baseURL}listengineeringbasics/$from/5'));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["proffessionals"];
      setState(() {
        engineeringBasicsList = jsonData.map<EngineeringBasicsModel>((data)=>EngineeringBasicsModel.fromJson(data)).toList();
      });
    }else{
      debugPrint('getDetailsJob get call error');
    }
  }

  Future getDetails() async{

    final response = await http.get(Uri.parse('${Config.baseURL}listengineeringbasics/0/5'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["proffessionals"];

      setState(() {
        engineeringBasics = jsonData.map<EngineeringBasicsModel>((data) =>EngineeringBasicsModel.fromJson(data)).toList() ?? [];
      });
      engineeringBasicsDetails(0);
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json Model, $EngineeringBasicsModel');
    }else{
      debugPrint('get call error');
    }
    debugPrint("Fresher2Industry123 : $engineeringBasics");
    // debugPrint("Service Details : $serviceDetails");

  }

  pageList(page) {
    switch(page){
      case 1:
        engineeringBasicsDetails(0);
        break;
      case 2:
        engineeringBasicsDetails(5);
        break;
      case 3:
        engineeringBasicsDetails(10);
        break;
      case 4:
        engineeringBasicsDetails(15);
        break;
      case 5:
        engineeringBasicsDetails(20);
        break;
      case 6:
        engineeringBasicsDetails(25);
        break;
      case 7:
        engineeringBasicsDetails(30);
        break;
      case 8:
        engineeringBasicsDetails(35);
        break;
      case 9:
        engineeringBasicsDetails(40);
        break;
      case 10:
        engineeringBasicsDetails(45);
        break;
      case 11:
        engineeringBasicsDetails(50);
        break;
      case 12:
        engineeringBasicsDetails(55);
        break;
      case 13:
        engineeringBasicsDetails(60);
        break;
      case 14:
        engineeringBasicsDetails(65);
        break;
      case 15:
        engineeringBasicsDetails(70);
        break;
      case 16:
        engineeringBasicsDetails(75);
        break;
      case 17:
        engineeringBasicsDetails(80);
        break;
      case 18:
        engineeringBasicsDetails(85);
        break;
      case 19:
        engineeringBasicsDetails(90);
        break;
      case 20:
        engineeringBasicsDetails(95);
        break;
      default:
        engineeringBasicsDetails(100);
    }
  }

  numberOfPages() {
    double pgNum = engineeringBasics.length/5;
    return pgNum.ceil();
  }

  paginationList() {
    return PaginationWidget(
      numOfPages: numberOfPages(),
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
      nextIcon: Icon(
        Icons.arrow_forward_ios,
        size: 12,
        color: selectedPage == numberOfPages() ? Colors.grey : Color(0xff000000),
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
        backgroundColor:
        MaterialStateProperty.all(
            const Color(0xff8cb93d)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
        shadowColor: MaterialStateProperty.all(const Color(0xfff1f1f1),
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
    );
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/EnggBasics.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      head = jsonMap['main'];
      sub = jsonMap["sub"];
      imagee = jsonMap["Immage"];
      logo = jsonMap["logoo"];
      discreption = jsonMap["heading"];
      expntile = jsonMap["Tile"];
    });
  }

  @override
  Widget build(BuildContext context) {
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
            : ListView(
                children: [
                  Image.asset('assets/images/EnggBasics.png', height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 1.h, bottom: 0.3.h, left: 4.w, right: 4.w),
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3.w,
                            ),
                            Text(headerList.isNotEmpty  ? (headerList[10].headerContent ?? '') : '',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 0.3.h,),
                            (engineeringBasics.isEmpty)
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
                                :ListView.builder(
                                key: Key(selectedTile.toString()),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: engineeringBasics.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 5),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      border: Border.all(color: Config.mainBorderColor),
                                    ),
                                    child: Theme(
                                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context)=> EngineeringBranchesDec(title: engineeringBasics[index].postTitle ?? '',
                                                                      content1: engineeringBasics[index].postContent ?? '', root1: "AllAboutEngineers",
                                                                      root2: "EngineeringBasics", index: "${index}", branch: "Engineering Basics")));
                                            },
                                          child: Container(
                                            width: 92.w, height: 5.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Config.mainBorderColor,width: 1)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.h),
                                                  child: Text(engineeringBasics[index].postTitle ?? '',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 4.w),
                                                  child: Image.asset('assets/images/DoubleArrowIcon.png',width: 3.w),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  );
                                }),
                          ],
                        ),
                  )
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: paginationList(),
      ),
    );
  }
}
