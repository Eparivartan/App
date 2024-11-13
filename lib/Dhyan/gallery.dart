import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../Config.dart';
import '../Models/DhyanModel.dart';
import '../Widgets/App_Bar_Widget.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String? Img;
  String? Timg;
  String? Pic;
  String? Pic1;
  String? Pic2;
  String? Pic3;
  String? Data;
  List<GalleryModel> galleryList = [];
  List caurosalList = [];

  Future getDetails() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listgallery'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["listgallery"];
      setState(() {
        galleryList = jsonData
                .map<GalleryModel>((data) => GalleryModel.fromJson(data))
                .toList() ??
            [];
        for (var i = 0; i < galleryList.length; i++) {
          caurosalList.add(galleryList[i].imageName);
        }
      });
    } else {
      debugPrint('get call error');
    }
  }

  @override
  void initState() {
    loadJson();
    getDetails();
    super.initState();
  }

  Future loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/gallery.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      Img = jsonMap['img'];
      Timg = jsonMap['timg'];
      Pic = jsonMap['pic'];
      Pic1 = jsonMap['pic1'];
      Pic2 = jsonMap['pic2'];
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
              'assets/images/enggConstruction.png',
              height: 21.h,
              width: 100.w,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 17, bottom: 16),
              child: Text(
                'Gallery',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff333333),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                'Our Classrooms & Corporate trainings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            (galleryList.isEmpty)
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
                : CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 0.7,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 3),
                      scrollDirection: Axis.horizontal,
                    ),
                    itemCount: galleryList.length,
                    itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                      return Container(
                        width: 100.w,
                        height: 24.6.h,
                        child: Image.network(
                          Config.imageURL + "${galleryList[index].imageName}",
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 15, left: 15),
              child: Text(
                'Student Achievements/Testimonials',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            (galleryList.isEmpty)
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
                : CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 0.7,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 3),
                      scrollDirection: Axis.horizontal,
                    ),
                    itemCount: galleryList.length,
                    itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                      return Container(
                        width: 100.w,
                        height: 24.6.h,
                        child: Image.network(
                          Config.imageURL + "${galleryList[index].imageName}",
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
