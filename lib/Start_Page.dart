import 'dart:async';
import 'dart:convert';
import 'package:careercoach/Home%20Page.dart';
import 'package:careercoach/New/Register/authservices.dart';
import 'package:careercoach/demoprofile.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Config.dart';
import 'New/Register/login_page.dart';
import 'Register Page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String? img1;
  String? img2;
  String? img3;
  String? logo;
  String? text1;
  String? btntxt;
  String? userId;

  late TabController _controller;

  @override
  void initState() {
    getData();
    userid();
    super.initState();
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/Startpage.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      img1 = jsonMap['image1'];
      img2 = jsonMap["image2"];
      img3 = jsonMap["image3"];
      logo = jsonMap["logoo"];
      text1 = jsonMap["textt"];
      btntxt = jsonMap["butnText"];
    });
  }
  Future userid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);
    print(userId.toString());

  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => userId !=null?  Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) =>  LoginPage(),
        ),
      ): Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) =>  HomePage(),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [Config.gradientBottom, Config.whiteColor]),
          ),
          child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: (logo == null)
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
                      : Column(
                          children: [
                            SizedBox(height: 2.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Image.asset(
                                'assets/images/SplashScreenImage.png',
                                width: 91.2.w,
                                height: 47.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(height: 5.w),
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
                                SizedBox(width: 2.w),
                                const CupertinoActivityIndicator(
                                  radius: 20,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            SizedBox(height: 11.h),
                            Padding(
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Text(
                                'Your one stop Application for all your Educational and Professional needs....',
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Image.asset('assets/images/StartLogo.png',
                              height: 11.h,
                              fit: BoxFit.fill,
                              width: 40.w,
                            ),
                            SizedBox(height: 3.w)
                          ],
                        ),
                ),
              ]),
        ),
      ),
    );
  }
}
