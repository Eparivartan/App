import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Models/DhyanModel.dart';
import '../Widgets/App_Bar_Widget.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List<ReviewModel> reviewList = [];
  final PageController carouselController = PageController();

  String? Img;
  String? Timg;
  String? Pic;
  String? Pic3;
  String? Data;

  Future getDetails() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listreviews'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["reviews"];

      setState(() {
        reviewList = jsonData
                .map<ReviewModel>((data) => ReviewModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
    } else {
      debugPrint('get call error');
    }
    debugPrint("Fresher2Industry123 : $reviewList");
  }

  @override
  void initState() {
    loadJson();
    getDetails();
    super.initState();
  }

  Future loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/reviews.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      Img = jsonMap['img'];
      Timg = jsonMap['timg'];
      Pic = jsonMap['pic'];
      Pic3 = jsonMap['pic3'];
      Data = jsonMap['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.3.h),
        child: App_Bar_widget3(
          image: ('assets/images/dhyanacademy-logo.png'),
        ),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: ListView(
          children: [
            Image.asset(
              'assets/images/hands-touching.png',
              height: 21.h,
              width: 100.w,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 17, bottom: 16),
              child: Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff333333),
                ),
              ),
            ),
            //OUR STUDENTS
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                'Our students',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff333333),
                ),
              ),
            ),
            //
            (reviewList == null || reviewList.length == 0)
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
                : Stack(alignment: Alignment.center, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 27.h,
                          width: 100.w,
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 0.7,
                              autoPlay: false,
                              autoPlayInterval: Duration(seconds: 3),
                              scrollDirection: Axis.horizontal,
                            ),
                            itemCount: reviewList.length,
                            itemBuilder: (BuildContext context, int index,
                                int pageViewIndex) {
                              return Container(
                                height: 50.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  color: Color(0xffF9F9FB),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xffEBEBEB),
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Image.network(
                                            "${Config.imageURL}${reviewList[index].reviewImage}",
                                            height: 9.8.h,
                                            width: 21.3.w,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Text(
                                                "${reviewList[index].reviewerName}",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: 'Course:',
                                                    style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 8.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "${reviewList[index].courseName}",
                                                    style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 8.sp,
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: 'Class:',
                                                    style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 8.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "${reviewList[index].className}",
                                                    style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 8.sp,
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 12,
                                          top: 10),
                                      child: Text(
                                        "${reviewList[index].review}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Color(0xff333333),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      // top: 100,
                      left: 45,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_sharp),
                            onPressed: () {
                              // carouselController.previousPage();
                            },
                            iconSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // top: 100,
                      right: 45,
                      child: Container(
                        height: 35,
                        width: 35,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_sharp),
                            onPressed: () {
                              // carouselController.nextPage();
                            },
                            iconSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ]),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20, bottom: 15),
              child: Text(
                'Voice of our Academic & Corporate partners',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff333333),
                ),
              ),
            ),
            (reviewList == null || reviewList.length == 0)
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
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 27.h,
                            width: 100.w,
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                viewportFraction: 0.7,
                                autoPlay: false,
                                autoPlayInterval: Duration(seconds: 3),
                                scrollDirection: Axis.horizontal,
                              ),
                              itemCount: reviewList.length,
                              itemBuilder: (BuildContext context, int index,
                                  int pageViewIndex) {
                                return Container(
                                  height: 50.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF9F9FB),
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xffEBEBEB),
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.network(
                                              "${Config.imageURL}${reviewList[index].reviewImage}",
                                              height: 9.8.h,
                                              width: 21.3.w,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Text(
                                                  "${reviewList[index].reviewerName}",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: 'Course:',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontSize: 8.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${reviewList[index].courseName}",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontSize: 8.sp,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: 'Class:',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontSize: 8.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${reviewList[index].className}",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontSize: 8.sp,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 12,
                                            top: 10),
                                        child: Text(
                                          "${reviewList[index].review}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Color(0xff333333),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        left: 45,
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_sharp),
                              onPressed: () {
                                // carouselController.previousPage();
                              },
                              iconSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 45,
                        child: Container(
                          height: 35,
                          width: 35,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_sharp),
                              onPressed: () {
                                // carouselController.nextPage();
                              },
                              iconSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
