import 'dart:convert';
import 'package:careercoach/dwgviewer.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'Config.dart';
import 'My Profile/menu.dart';
import 'Notifications.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? details;
  String? bottom;
  String? Useridnum;
  String? profilename;
  String? profilemail;
  List? page;
  var jsonData;

  @override
  void initState() {
    loadJson();

    _loadUserId();

    super.initState();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Useridnum = prefs.getString(SharedPreferencesHelper.useridkey);
    print(Useridnum.toString());
    if (Useridnum.toString() != null) {
      getProfileDetails();
    }
  }

  Future<void> getProfileDetails() async {
    if (Useridnum == null) return;
    final response =
        await http.get(Uri.parse('${Config.baseURL}my-profile/$Useridnum'));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      setState(() {
        profilename = jsonData['profiledetails']['profileName'];
        profilemail = jsonData['profiledetails']['emailId'];
      });
    } else {
      debugPrint('get call error');
    }
  }

  Future<void> loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/allpages.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      details = jsonMap["AllPages"];
      page = jsonMap['items'];
      bottom = jsonMap['botm'];
    });
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App!'),
            content: Text(
              'Do you want to exit the App?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.careerCoachButtonColor),
                child: const Text('No'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop(animated: true);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.careerCoachButtonColor),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Config.containerColor,
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            child: Image.asset('assets/images/menu.png', width: 0.5.w),
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Image.asset('assets/images/pg12-1.png', width: 20.w),
          ),
          actions: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset('assets/images/notifyIcon.png',
                    height: 5.h, width: 10.w),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Notifications()));
              },
            )
          ],
        ),
        backgroundColor: Config.whiteColor,
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Menu(),
        ),
        body: SafeArea(
          child: (details == null)
              ? const Center(
                  child: CupertinoActivityIndicator(
                    radius: 25,
                    color: Colors.black,
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
                            for (var i = 0; i < 3; i++)
                              Container(
                                height: 20.h,
                                width: 96.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/home.png'),
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
                                      height: 3.4.h),
                                ),
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
                        padding: const EdgeInsets.only(left: 7, right: 6),
                        child: GridView.builder(
                          itemCount: page?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, right: 2, left: 2),
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.1,
                                        color: Config.mainBorderColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            details?[index]['dhyan'] ?? '',
                                            height: 18.w),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 3, bottom: 5),
                                          child: Text(
                                            details?[index]["title"] ?? '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              height: 1.25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  index == 13
                                      ? Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DWGViewver()),
                                        )
                                      : Navigator.pushNamed(
                                          context, page?[index]["page"] ?? '/');
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5.w),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 6.0, left: 7, bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfff3f7f4),
                            border: Border.all(color: const Color(0xffDEECE4)),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          height: 19.5.h,
                          width: 95.w,
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "About CAD Career Coach",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Container(
                                  width: 80.w,
                                  child: Text(
                                    "We at CAD Career Coach strive to provide continuous "
                                    "learning experience, latest happenings in the world of "
                                    "Mechanical, Civil, Architecture branches who are included "
                                    "in Design, Drafting as passion and more...",
                                    style: TextStyle(fontSize: 10.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: logoutPopup(),
        ),
      ),
    );
  }

  logoutPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Logout! Are you sure?'),
                Image.asset('assets/images/alert.png'),
              ],
            ),
            content: const Text(
              'Close the Application session to visit later easily',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop(animated: true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
