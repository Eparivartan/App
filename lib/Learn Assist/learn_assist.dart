import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../Config.dart';
import '../Models/learnAssistModel.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/App_Bar_Widget.dart';

class LearnAssist extends StatefulWidget {
  const LearnAssist({Key? key}) : super(key: key);

  @override
  State<LearnAssist> createState() => _LearnAssistState();
}

class _LearnAssistState extends State<LearnAssist> {
  List? details;
  String? learn;
  List? page;
  String? Img;
  String? Timg;
  String? Pic;
  String? Data;
  List<LearnAssistModel> learnAssistItems = [];

  Future<void> LearnAssistDetailList() async {
    final response = await http.get(Uri.parse('${Config.baseURL}learnassistcategory'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["learncategories"];
      setState(() {
        learnAssistItems = jsonData
            .map<LearnAssistModel>((data) => LearnAssistModel.fromJson(data))
            .toList() ?? [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data headers, $jsonData');
      debugPrint('printing header List, $learnAssistItems');
    } else {
      debugPrint('get call error');
    }
  }

  @override
  void initState() {
    super.initState();
    loadJson();
    LearnAssistDetailList();
    saveToRecent();
  }

  Future<void> saveToRecent() async {
    // If no internet, insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "Learn Assist",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  Future<void> loadJson() async {
    String jsonString = await rootBundle.loadString('assets/files/learn_assist.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      details = jsonMap["learn"];
      learn = jsonMap['text'];
      page = jsonMap['Pages'];
      Img = jsonMap['img'];
      Timg = jsonMap['timg'];
      Pic = jsonMap['pic'];
      Data = jsonMap['data'];
      print(details);
      print(learn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget(title: 'Learn Assist\n(Learning Portal)'),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (learnAssistItems.isEmpty)
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
                    SizedBox(width: 2.w),
                    const CupertinoActivityIndicator(
                      radius: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            : Center(
                child: ListView(
                  children: [
                    Container(
                      height: 20.h,
                      width: 100.w,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enlargeFactor: 0.1,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                        ),
                        items: [
                          Container(
                            height: 20.h,
                            width: 96.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Pic ?? ''),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Container(
                            height: 20.h,
                            width: 96.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Pic ?? ''),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Container(
                            height: 20.h,
                            width: 96.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Pic ?? ''),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: learnAssistItems.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade100),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 4.w),
                                          child: Text(
                                            "${learnAssistItems[index].catname ?? ''}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff333333),
                                                fontSize: 13.sp),
                                          ),
                                        ),
                                        (learnAssistItems[index].catimage ==
                                                    null ||
                                                learnAssistItems[index]
                                                        .catimage ==
                                                    '')
                                            ? Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                      radius: 15,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Image.network(
                                                "${Config.imageURL}${learnAssistItems[index].catimage}",
                                                height: 7.88.h,
                                                width: 26.6.w,
                                              )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, page?[index]['page'] ?? '/');
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
