import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Config.dart';
import '../Models/allAboutEngineeringModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'Codes And Standards decription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CodesAndStandards extends StatefulWidget {
  const CodesAndStandards({Key? key}) : super(key: key);

  @override
  State<CodesAndStandards> createState() => _CodesAndStandardsState();
}

class _CodesAndStandardsState extends State<CodesAndStandards>
    with SingleTickerProviderStateMixin {
  List? data;
  String? head;
  String? sub;
  String? imagee;
  String? logo;
  String? discreption;
  List? expntile1;
  List? expntile2;
  List? expntile3;
  List<EngineeringCodesAndStdModel> codesAndStdArch = [];
  List<EngineeringCodesAndStdModel> codesAndStdCivil = [];
  List<EngineeringCodesAndStdModel> codesAndStdMech = [];
  List? text;
  int selectedTile = -1;
  int? selected = -1;

  TabController? _controller;

  @override
  void initState() {
    getData();
    getDetails1(0);
    getDetails2();
    getDetails3();
    getId();
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      selected = -1;
      selected = -1;
    });
  }

  _expansion(bool expanding, int index){
    if(expanding){
      selected = -1;
      debugPrint("expansion value: " + index.toString());
      setState(() {
        // const Duration(seconds:  20000);
        selected = index;
      });
    }
    else {
      setState(() {
        selected = -1;
      });
    }
  }


  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  numberOfPages1() {
    double pgNum = codesAndStdArch.length/5;
    return pgNum.ceil();
  }

  numberOfPages2() {
    double pgNum = codesAndStdCivil.length/5;
    return pgNum.ceil();
  }

  numberOfPages3() {
    double pgNum = codesAndStdMech.length/5;
    return pgNum.ceil();
  }

  pageList(page) {
    switch(page){
      case 1:
        getDetails1(0);
        break;
      case 2:
        getDetails1(5);
        break;
      case 3:
        getDetails1(10);
        break;
      case 4:
        getDetails1(15);
        break;
      case 5:
        getDetails1(20);
        break;
      case 6:
        getDetails1(25);
        break;
      case 7:
        getDetails1(30);
        break;
      case 8:
        getDetails1(35);
        break;
      case 9:
        getDetails1(40);
        break;
      case 10:
        getDetails1(45);
        break;
      case 11:
        getDetails1(50);
        break;
      case 12:
        getDetails1(55);
        break;
      case 13:
        getDetails1(60);
        break;
      case 14:
        getDetails1(65);
        break;
      case 15:
        getDetails1(70);
        break;
      case 16:
        getDetails1(75);
        break;
      case 17:
        getDetails1(80);
        break;
      case 18:
        getDetails1(85);
        break;
      case 19:
        getDetails1(90);
        break;
      case 20:
        getDetails1(95);
        break;
      default:
        getDetails1(100);
    }
  }

  paginationList() {
    if(_controller?.index==0)
    {
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
          color: selectedPage == numberOfPages1() ? Colors.grey : Color(0xff000000),
        ),
        previousIcon: Icon(
          Icons.arrow_back_ios,
          size: 12,
          color: selectedPage==1 ? Colors.grey : Color(0xff000000),
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
              const EdgeInsets.all(20)),
          visualDensity:
          const VisualDensity(horizontal: 0),
          elevation:
          MaterialStateProperty.all(0),
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
      );
    }
    else if (_controller?.index ==1)
    {
      pageList(0);
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
          color: selectedPage == numberOfPages2() ? Colors.grey : Color(0xff000000),
        ),
        previousIcon: Icon(
          Icons.arrow_back_ios,
          size: 12,
          color: selectedPage==1 ? Colors.grey : Color(0xff000000),
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
              const EdgeInsets.all(20)),
          visualDensity:
          const VisualDensity(horizontal: 0),
          elevation:
          MaterialStateProperty.all(0),
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
      );
    }
    else if (_controller?.index ==2)
    {
      pageList(0);
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
          color: selectedPage == numberOfPages1() ? Colors.grey : Color(0xff000000),
        ),
        previousIcon: Icon(
          Icons.arrow_back_ios,
          size: 12,
          color: selectedPage==1 ? Colors.grey : Color(0xff000000),
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
              const EdgeInsets.all(20)),
          visualDensity:
          const VisualDensity(horizontal: 0),
          elevation:
          MaterialStateProperty.all(0),
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
      );
    }
  }

  getId(){
    int? val;
    if(_controller?.index.toString() == 0){
      val = 2;
    }
    else if(_controller?.index.toString() == 1){
      val = 3;
    }
    else if(_controller?.index.toString() == 2){
      val = 1;
    }
    return val;

  }

  Future getDetails1(from) async{

    debugPrint('printing 123456 ${getId.toString()}');
    final response = await http.get(Uri.parse('${Config.baseURL}showcodesnstandards/2'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["listcodes"];
      setState(() {
        codesAndStdArch = jsonData.map<EngineeringCodesAndStdModel>((data) =>EngineeringCodesAndStdModel.fromJson(data)).toList() ?? [];
      });
    }else{
      debugPrint('get call error');
    }
  }

  Future getDetails2() async{

    debugPrint('printing 123456 ${getId.toString()}');
    final response = await http.get(Uri.parse('${Config.baseURL}showcodesnstandards/3'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["listcodes"];
      setState(() {
        codesAndStdCivil = jsonData.map<EngineeringCodesAndStdModel>((data) =>EngineeringCodesAndStdModel.fromJson(data)).toList() ?? [];
        });
    }else{
      debugPrint('get call error');
    }
  }

  Future getDetails3() async{

    debugPrint('printing 123456 ${getId.toString()}');
    final response = await http.get(Uri.parse('${Config.baseURL}showcodesnstandards/1'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["listcodes"];
      setState(() {
        codesAndStdMech = jsonData.map<EngineeringCodesAndStdModel>((data) =>EngineeringCodesAndStdModel.fromJson(data)).toList() ?? [];
        });
      }else{
      debugPrint('get call error');
    }
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/Codes&Stds.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      head = jsonMap['main'];
      sub = jsonMap["sub"];
      imagee = jsonMap["Immage"];
      logo = jsonMap["logoo"];
      discreption = jsonMap["heading"];
      expntile1 = jsonMap["Tile1"];
      expntile2 = jsonMap["Tile2"];
      expntile3 = jsonMap["Tile3"];
      text = jsonMap["textin"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child : Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: App_Bar_widget2(title: head ?? ''),
        ),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: (expntile1 == null)
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
                      padding: EdgeInsets.only(left: 4.w,right: 4.w),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          RichText(
                            text: TextSpan(
                              children: [
                            TextSpan(
                              text: 'Standard',
                              style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp
                              ),
                            ),
                            TextSpan(
                              text: ' is a set of technical definitions,'
                                  ' specifications, and guidelines\n\n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.sp
                              ),
                            ),
                            TextSpan(
                              text: 'Code',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp
                              ),
                            ),
                            TextSpan(
                              text: ' is a model that is established after years of use',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.sp
                              ),
                            ),
                          ],
                          ),
                          ),
                          SizedBox(height: 3.w,),
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
                            labelStyle: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
                            unselectedLabelStyle: TextStyle(
                              color: Config.primaryTextColor,
                              fontSize: 10.sp,
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [
                              Container(
                                width: 30.w, height: 4.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(7),
                                    color: _controller?.index == 0 ? Config.containerGreenColor: Config.mainBorderColor
                                ),
                                child: Tab(
                                  key: UniqueKey(),
                                  child: Text(
                                    ' Architecture ',style: TextStyle(fontSize: 11.sp),
                                  ),
                                ),
                              ),
                              Container(
                                width: 30.w, height: 4.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(7),
                                    color: _controller?.index == 1 ? Config.containerGreenColor: Config.mainBorderColor
                                ),
                                child: Tab(
                                  key: UniqueKey(),
                                  child: Text(' Civil ',style: TextStyle(fontSize: 11.sp),
                                  ),),
                              ),
                              Container(
                                width: 30.w, height: 4.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(7),
                                    color: _controller?.index == 2 ? Config.containerGreenColor: Config.mainBorderColor
                                ),
                                child: Tab(
                                  key: UniqueKey(),
                                  child: Text(' Mechanical ',style: TextStyle(fontSize: 11.sp),
                                  ),),
                              ),
                            ],
                          ),
                          Divider(thickness: 1,color: Config.mainBorderColor,),
                          SizedBox(
                            height: 70.h,
                            child: TabBarView(
                              viewportFraction: 1.0,
                              physics: NeverScrollableScrollPhysics(),
                              controller: _controller,
                              children: <Widget>[
                                //Architecture
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                        key: Key(selectedTile.toString()),
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        //const NeverScrollableScrollPhysics(),
                                        itemCount: expntile1?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 1.4.h),
                                            child: Theme(
                                              data: ThemeData().copyWith(dividerColor: Colors.transparent),
                                              child: Container(
                                                width: 92.w,
                                                //height: 17.7.h,
                                                // margin: const EdgeInsets.only(top: 10, bottom: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Config.mainBorderColor, width: 1)),
                                                child: ExpansionTile(
                                                  // tilePadding: EdgeInsets.all(1),
                                                  initiallyExpanded: index == selectedTile,
                                                  collapsedBackgroundColor: Colors.white,
                                                  backgroundColor: Config.containerColor,
                                                  title: Text(expntile1?[index]["Topic"].toString() ?? '',
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      height: 1,
                                                      color: Config.primaryTextColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  iconColor: Colors.black,
                                                  onExpansionChanged: ((newState) {
                                                    if (newState) {
                                                      setState(() {
                                                        const Duration(seconds: 20000);
                                                        selected = index;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        selected = -1;
                                                      });
                                                    }
                                                  }),
                                                  children: [
                                                    const Divider(thickness: 1,color: Config.mainBorderColor,),
                                                    Padding(padding: const EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 8),
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: const ClampingScrollPhysics(),
                                                            itemCount: codesAndStdArch.length,
                                                            itemBuilder: (context, index){
                                                              return codesAndStdArch.length == 0 ?
                                                              const Text('No data to display') :
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  InkWell(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(left: 8.0),
                                                                      child: Text(codesAndStdArch[index].codeName.toString() ?? '',
                                                                        style: TextStyle(
                                                                            fontSize: 11.sp,
                                                                            height: 2,
                                                                            // fontStyle: FontStyle.italic,
                                                                            decoration: TextDecoration.underline),
                                                                      ),
                                                                    ),
                                                                    onTap: (){
                                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodesAndStandardsDec(
                                                                            content: codesAndStdArch[index].codeDescription ?? '',
                                                                            title: codesAndStdArch[index].codeName ?? '',)));
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                                //Civil
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                        key: Key(selectedTile.toString()),
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        //const NeverScrollableScrollPhysics(),
                                        itemCount: expntile2?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 1.4.h),
                                            child: Container(
                                              width: 92.w,
                                              //height: 17.7.h,
                                              // margin: const EdgeInsets.only(top: 10, bottom: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Config.mainBorderColor, width: 1)),
                                              child: Theme(
                                                data: ThemeData().copyWith(
                                                    dividerColor:
                                                    Colors.transparent),
                                                child: ExpansionTile(
                                                  initiallyExpanded: index == selectedTile,
                                                  collapsedBackgroundColor: Colors.white,
                                                  backgroundColor: Config.containerColor,
                                                  title: Text(
                                                    expntile2?[index]["Topic"].toString() ?? '',
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Config.primaryTextColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  iconColor: Colors.black,
                                                  onExpansionChanged: ((newState) {
                                                    if (newState)
                                                      setState(() {
                                                        selectedTile = index;
                                                      });
                                                    else
                                                      setState(() {
                                                        selectedTile = -1;
                                                      });
                                                  }),
                                                  children: [
                                                    const Divider(thickness: 1,color: Config.mainBorderColor,),
                                                    Padding(padding: const EdgeInsets.only(top: 0, bottom: 16, left: 8, right: 8),
                                                        child:
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: const ClampingScrollPhysics(),
                                                            itemCount: codesAndStdCivil.length,
                                                            itemBuilder: (context, index){
                                                              return codesAndStdCivil.length == 0 ? Text('No data to display') :
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  InkWell(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(left: 8.0),
                                                                      child: Text(codesAndStdCivil?[index].codeName.toString() ?? '',
                                                                        style: TextStyle(
                                                                            fontSize: 11.sp,
                                                                            height: 2,
                                                                            // fontStyle: FontStyle.italic,
                                                                            decoration: TextDecoration.underline),
                                                                      ),
                                                                    ),
                                                                    onTap: (){
                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodesAndStandardsDec(
                                                                        content: codesAndStdCivil[index].codeDescription ?? '',
                                                                        title: codesAndStdCivil[index].codeName ?? '',)));
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    // ListView.builder(
                                    //     key: Key(selectedTile.toString()),
                                    //     shrinkWrap: true,
                                    //     physics: const ScrollPhysics(),
                                    //     //const NeverScrollableScrollPhysics(),
                                    //     itemCount: expntile?.length,
                                    //     itemBuilder: (context, index) {
                                    //       return Container(
                                    //         margin: const EdgeInsets.only(top: 10, bottom: 5),
                                    //         decoration: BoxDecoration(
                                    //             borderRadius: BorderRadius.circular(10),
                                    //             border: Border.all(color: Config.mainBorderColor)),
                                    //         child: Theme(
                                    //           data: ThemeData().copyWith(
                                    //               dividerColor:
                                    //               Colors.transparent),
                                    //           child: ExpansionTile(
                                    //             initiallyExpanded: index == selectedTile,
                                    //             collapsedBackgroundColor:
                                    //             Colors.white,
                                    //             backgroundColor:
                                    //             Config.containerColor,
                                    //             title: Text(
                                    //               expntile?[index]["Topic"].toString() ?? '',
                                    //               style: TextStyle(
                                    //                 fontSize: 8.sp,
                                    //                 color: Config.primaryTextColor,
                                    //                 fontWeight: FontWeight.bold,
                                    //               ),
                                    //             ),
                                    //             trailing: const Icon(Icons.keyboard_arrow_down_outlined, color: Config.primaryTextColor,),
                                    //             children: [
                                    //               Padding(
                                    //                 padding:
                                    //                 const EdgeInsets.all(8.0),
                                    //                 child: Column(
                                    //                   // crossAxisAlignment: CrossAxisAlignment.start,
                                    //                   children: [
                                    //                     Row(
                                    //                       children: [
                                    //                         InkWell(
                                    //                           child: Text(
                                    //                             'AJS 126',
                                    //                             textAlign: TextAlign.start,
                                    //                             style: TextStyle(decoration: TextDecoration.underline,
                                    //                                 fontStyle: FontStyle.italic),
                                    //                           ),
                                    //                           onTap: () {
                                    //                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodesAndStandardsDec()));
                                    //                           },
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                     Row(
                                    //                       children: [
                                    //                         InkWell(
                                    //                           child: Text(
                                    //                             'AJS 126',
                                    //                             style: TextStyle(
                                    //                                 decoration: TextDecoration.underline,
                                    //                                 fontStyle: FontStyle.italic),
                                    //                           ),
                                    //                           onTap: () {
                                    //                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodesAndStandardsDec()));
                                    //                           },
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                     Row(
                                    //                       children: [
                                    //                         InkWell(
                                    //                           child: Text(
                                    //                             'AJS 126',
                                    //                             style: TextStyle(
                                    //                                 decoration:
                                    //                                 TextDecoration
                                    //                                     .underline,
                                    //                                 fontStyle:
                                    //                                 FontStyle
                                    //                                     .italic),
                                    //                           ),
                                    //                           onTap: () {
                                    //                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodesAndStandardsDec()));
                                    //                           },
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //             onExpansionChanged: ((newState) {
                                    //               if (newState) {
                                    //                 setState(() {
                                    //                   selectedTile = index;
                                    //                 });
                                    //               } else {
                                    //                 setState(() {
                                    //                   selectedTile = -1;
                                    //                 });
                                    //               }
                                    //             }),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     }),
                                  ],
                                ),
                                //Mechanical
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                        key: Key(selectedTile.toString()),
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        //const NeverScrollableScrollPhysics(),
                                        itemCount: expntile3?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 1.4.h),
                                            child: Container(
                                              width: 92.w,
                                              //height: 17.7.h,
                                              // margin: const EdgeInsets.only(top: 10, bottom: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Config.mainBorderColor, width: 1)),
                                              child: Theme(
                                                data: ThemeData().copyWith(
                                                    dividerColor:
                                                    Colors.transparent),
                                                child: ExpansionTile(
                                                  initiallyExpanded: index == selectedTile,
                                                  collapsedBackgroundColor: Colors.white,
                                                  backgroundColor: Config.containerColor,
                                                  title: Text(
                                                    expntile3?[index]["Topic"].toString() ?? '',
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Config.primaryTextColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  iconColor: Colors.black,
                                                  onExpansionChanged: ((newState) {
                                                    if (newState)
                                                      setState(() {
                                                        selectedTile = index;
                                                      });
                                                    else
                                                      setState(() {
                                                        selectedTile = -1;
                                                      });
                                                  }),
                                                  children: [
                                                    const Divider(thickness: 1,color: Config.mainBorderColor,),
                                                    Padding(padding: const EdgeInsets.only(top: 0, bottom: 16, left: 8, right: 8),
                                                        child:
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: const ClampingScrollPhysics(),
                                                            itemCount: codesAndStdMech.length,
                                                            itemBuilder: (context, index){
                                                              return codesAndStdMech.length == 0 ? Text('No data to display') :
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  InkWell(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(left: 8.0),
                                                                      child: Text(codesAndStdMech?[index].codeName.toString() ?? '',
                                                                        style: TextStyle(
                                                                            fontSize: 11.sp,
                                                                            // height: 2,
                                                                            // fontStyle: FontStyle.italic,
                                                                            decoration: TextDecoration.underline),
                                                                      ),
                                                                    ),
                                                                    onTap: (){
                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodesAndStandardsDec(
                                                                        content: codesAndStdMech[index].codeDescription ?? '',
                                                                        title: codesAndStdMech[index].codeName ?? '',)));
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        ),
                                    // ListView.builder(
                                    //     key: Key(selectedTile.toString()),
                                    //     shrinkWrap: true,
                                    //     physics: const ScrollPhysics(),
                                    //     //const NeverScrollableScrollPhysics(),
                                    //     itemCount: expntile?.length,
                                    //     itemBuilder: (context, index) {
                                    //       return Container(
                                    //         margin: const EdgeInsets.only(top: 10, bottom: 5),
                                    //         decoration: BoxDecoration(
                                    //             borderRadius: BorderRadius.circular(10),
                                    //             border: Border.all(color: Config.mainBorderColor)),
                                    //         child: Theme(
                                    //           data: ThemeData().copyWith(
                                    //               dividerColor:
                                    //               Colors.transparent),
                                    //           child: ExpansionTile(
                                    //             iconColor: Colors.black,
                                    //             initiallyExpanded: index == selectedTile,
                                    //             collapsedBackgroundColor:
                                    //             Colors.white,
                                    //             backgroundColor:
                                    //             Config.containerColor,
                                    //             title: Text(
                                    //               expntile?[index]["Topic"].toString() ?? '',
                                    //               style: TextStyle(
                                    //                 fontSize: 8.sp,
                                    //                 color: Config.primaryTextColor,
                                    //                 fontWeight: FontWeight.bold,
                                    //               ),
                                    //             ),
                                    //             children: [
                                    //               Padding(
                                    //                 padding:
                                    //                 const EdgeInsets.all(8.0),
                                    //                 child: Column(
                                    //                   // crossAxisAlignment: CrossAxisAlignment.start,
                                    //                   children: [
                                    //                     Divider(thickness: 1, color: Config.mainBorderColor,),
                                    //                     Row(
                                    //                       children: [
                                    //                         InkWell(
                                    //                           child: Text('AJS 126', textAlign: TextAlign.start,
                                    //                             style: TextStyle(decoration: TextDecoration.underline,
                                    //                                 fontStyle: FontStyle.italic),
                                    //                           ),
                                    //                           onTap: () {
                                    //                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodesAndStandardsDec()));
                                    //                           },
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                     Row(
                                    //                       children: [
                                    //                         InkWell(
                                    //                           child: Text(
                                    //                             'AJS 126',
                                    //                             style: TextStyle(
                                    //                                 decoration: TextDecoration.underline,
                                    //                                 fontStyle: FontStyle.italic),
                                    //                           ),
                                    //                           onTap: () {
                                    //                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodesAndStandardsDec()));
                                    //                           },
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                     Row(
                                    //                       children: [
                                    //                         InkWell(
                                    //                           child: Text(
                                    //                             'AJS 126',
                                    //                             style: TextStyle(
                                    //                                 decoration:
                                    //                                 TextDecoration
                                    //                                     .underline,
                                    //                                 fontStyle:
                                    //                                 FontStyle
                                    //                                     .italic),
                                    //                           ),
                                    //                           onTap: () {
                                    //                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => CodesAndStandardsDec()));
                                    //                           },
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //             onExpansionChanged: ((newState) {
                                    //               if (newState)
                                    //                 setState(() {
                                    //                   selectedTile = index;
                                    //                 });
                                    //               else
                                    //                 setState(() {
                                    //                   selectedTile = -1;
                                    //                 });
                                    //             }),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     }),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: _controller?.index==0 ? PaginationWidget(
            numOfPages: numberOfPages1(),
            selectedPage: selectedPage,
            pagesVisible: 3,
            spacing: 10,
            onPageChanged: (page) {
              setState(() {
                selectedPage = page;
              });
            },
            nextIcon: Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: selectedPage == numberOfPages1() ? Colors.grey : Color(0xff000000),
            ),
            previousIcon: Icon(
              Icons.arrow_back_ios,
              size: 12,
              color: selectedPage == 1 ? Colors.grey : Color(0xff000000),
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
          ):
          _controller?.index==1 ? PaginationWidget(
            numOfPages: numberOfPages2(),
            selectedPage: selectedPage,
            pagesVisible: 3,
            spacing: 10,
            onPageChanged: (page) {
              setState(() {
                selectedPage = page;
              });
            },
            nextIcon: Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: selectedPage == numberOfPages2() ? Colors.grey : Color(0xff000000),
            ),
            previousIcon: Icon(
              Icons.arrow_back_ios,
              size: 12,
              color: selectedPage==1 ? Colors.grey : Color(0xff000000),
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
          ) :
          _controller?.index==2 ? PaginationWidget(
            numOfPages: numberOfPages3(),
            selectedPage: selectedPage,
            pagesVisible: 3,
            spacing: 10,
            onPageChanged: (page) {
              setState(() {
                selectedPage = page;
              });
            },
            nextIcon: Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: selectedPage == numberOfPages3() ? Colors.grey : Color(0xff000000),
            ),
            previousIcon: Icon(
              Icons.arrow_back_ios,
              size: 12,
              color: selectedPage==1 ? Colors.grey : Color(0xff000000),
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
          ): null
        ),
      ),
    );
  }
}
