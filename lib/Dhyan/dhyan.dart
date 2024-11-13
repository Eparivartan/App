import 'dart:convert';
import 'package:careercoach/My%20Profile/contact.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/App_Bar_Widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List? details;
  String? dhyan;
  List? page;
  String? Img;
  String? Timg;
  String? Pic;
  String? Nos;
  String? Mail;
  String? Call;
  String? Mailing;
  String? Globe;
  String? Site;
  String? Loc;
  String? Add;
  String? Contact;

  @override
  void initState() {
    loadJson();
    saveToRecent();
    super.initState();
  }

  saveToRecent() async {
    // If no internet, insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "Dhyan",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  Future loadJson() async {
    String jsonString = await rootBundle.loadString('assets/files/dhyan.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      details = jsonMap["dhyan"];
      dhyan = jsonMap['Dhyan'];
      page = jsonMap['Pages'];
      Img = jsonMap['img'];
      Timg = jsonMap['timg'];
      Pic = jsonMap['pic'];
      Mail = jsonMap['mail'];
      Call = jsonMap['call'];
      Mailing = jsonMap['mailing'];
      Globe = jsonMap['globe'];
      Site = jsonMap['site'];
      Loc = jsonMap['loc'];
      Add = jsonMap['add'];
      Contact = jsonMap['contact'];
      Nos = jsonMap['nos'];

      print(details);
      print(dhyan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.3.h),
        child: App_Bar_widget_2(
          image: ('assets/images/dhyanacademy-logo.png'),
        ),
      ),
      body: SafeArea(
        child: (details == null)
            ? const Center(child: CircularProgressIndicator())
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
                          autoPlayInterval: Duration(seconds: 3),
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                        ),
                        items: [
                          Container(
                            height: 20.h,
                            width: 96.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/home.png',
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Container(
                            height: 20.h,
                            width: 96.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/home.png',
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Container(
                            height: 20.h,
                            width: 96.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/home.png',
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                      child: Center(
                        child: Container(
                          width: 95.2.w,
                          height: 3.4.h,
                          child: Row(
                            children: [
                              Container(
                                  height: 3.4.h,
                                  width: 7.7.w,
                                  color: Config.gradientBottom,
                                  child: Image.asset(
                                    'assets/images/announce-1.png',
                                    height: 3.4.h,
                                  )),
                              Container(
                                width: 87.2.w,
                                height: 3.4.h,
                                decoration: BoxDecoration(
                                    color: Config.mainBorderColor),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Marquee(
                                    text:
                                        "Lorem Ipsum is simply dummy text of the.",
                                    velocity: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, bottom: 10, top: 15),
                            child: Text(
                              'Dhyan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 15),
                            child: Text(
                              dhyan ?? '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 11.sp, color: Colors.black),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: details?.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Color(0xffcccccc)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                page?[index]["page"] ?? '/');
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              details?[index]["title"] ?? '',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Image.asset(
                                            details?[index]["Image"] ?? '',
                                            height: 70,
                                          ),
                                        ),
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                      width: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfff3f6f4),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Contact Us',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text(
                                  Contact ?? '',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone_in_talk_outlined),
                                  Text(Nos ?? ''),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.mail_outline_rounded),
                                  Column(
                                    children: [
                                      Text(
                                        Mail ?? '',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Color(0xff333333),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      Add ?? '',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.language_outlined),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      Site ?? '',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
