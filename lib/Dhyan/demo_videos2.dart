import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';

class DemoVideos extends StatefulWidget {
  const DemoVideos({Key? key}) : super(key: key);

  @override
  State<DemoVideos> createState() => _DemoVideosState();
}

class _DemoVideosState extends State<DemoVideos> {

  List? details;
  String? Demo;
  String? Img;
  String? Timg;
  String? Pic;
  String? Head;
  String? Date;
  String? Duration;

  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  void initState() {
    loadJson();
    super.initState();
  }

  Future loadJson() async {
    String jsonString = await rootBundle.loadString('assets/files/demo.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      details = jsonMap["Demo"];
      Img = jsonMap['img'];
      Timg = jsonMap['timg'];
      Pic = jsonMap['pic'];
      Head = jsonMap['head'];
      Date = jsonMap["date"];
      Duration= jsonMap["duration"];
      print(details);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(7.3.h),
        child: App_Bar_widget3(image: ('assets/images/dhyanacademy-logo.png'),),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Container(
                height: 31.5.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Color(0XFFF1F1F1)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Image.asset('assets/images/playing.png',height: 22.h,width: 100.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14,top: 15,bottom: 6),
                          child: Text(Head ?? '',
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Config.primaryTextColor
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Row(
                            children: [
                              Text(Date ?? '',
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff999999)
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Text(Duration ?? '',
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff999999)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: details?.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 5, top: 5),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DemoVideos()));
                      },
                      child: Container(
                        height: 10.9.h,
                        width: 92.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff1f1f1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,top: 15,bottom: 25),
                                    child: Text(
                                      details?[index]["title"] ?? '',
                                      style:  TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 15,bottom: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          details?[index]["date"] ?? '',
                                          style:  TextStyle(
                                            fontSize: 8.sp,
                                            color: Color(0xff999999),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          details?[index]["duration"] ?? '',
                                          style:  TextStyle(
                                            fontSize: 8.sp,
                                            color: Color(0xff999999),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              details?[index]["Image"] ?? '',
                              height: 10.9.h,
                              width: 26.6.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              PaginationWidget(
                numOfPages: 10,
                selectedPage: selectedPage,
                pagesVisible: 3,
                spacing: 10,
                onPageChanged: (page) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
