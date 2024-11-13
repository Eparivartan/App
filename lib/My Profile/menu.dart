import 'dart:convert';
import 'package:careercoach/Home%20Page.dart';
import 'package:careercoach/Register%20Page.dart';
import 'package:careercoach/demoprofile.dart';
import 'package:careercoach/demoregister.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../New/Register/login_page.dart';
import '../config.dart';
import 'package:http/http.dart' as http;
import 'AboutUs.dart';
import 'contact.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List? details;
  List? items;
  List? route;
  var jsonData;
  String? userId;
  String? profilename;
  String? profilemail;
  String? userprofile;
  bool isLoading = true;

  //get version
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
    debugPrint("Printing the info :${_packageInfo}");
  }

  void fetchUserId() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);
    // Once you have the userId, update the UI
    if (userId != null) {
      getProfileDetails();
      // Update the UI with the userId

    }
  }

  @override
  void initState() {
    fetchUserId();
    getProfileDetails();
    loadJson();
    _initPackageInfo();

    getProfileDetails();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getProfileDetails() async {
    

    final response =
        await http.get(Uri.parse('${Config.baseURL}my-profile/$userId'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      setState(() {
        debugPrint('Print_______-----   $jsonData');
        profilename = jsonData['profiledetails']['profileName'];
        profilemail = jsonData['profiledetails']['emailId'];
        userprofile = jsonData['profiledetails']['userPhoto'];
      });

      debugPrint("Profile Details ++ $profilename");
      debugPrint("Profile Details ++ $profilemail");
      debugPrint("Profile Details ++ $userprofile");
      debugPrint(response.statusCode.toString());
    } else {
      debugPrint('get call error');
    }
  }

  Future loadJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = await rootBundle.loadString('assets/files/menu.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      details = jsonMap["menu"];
      items = jsonMap["data"];
      route = jsonMap["map"];
    });
  }

  Future<bool> showLogoutPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Logout!'),
            content: const Text(
              'Are you sure to Logout from the App?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.containerGreenColor),
                child: const Text('No'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.containerGreenColor),
                // onPressed: () {
                //   SystemNavigator.pop(animated: true);
                // },
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  List<String> navigate = [
    'About Us',
    'My Profile',
    'My Activity',
    'My Subscriptions',
    'Menu5',
    'Contact Us',
    'Logout'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 80.8.h,
            width: 70.w,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Drawer(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Welcome',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              color: Color(0xff333333).withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    userprofile != null ?
                     CircleAvatar(
                      radius: 40.0, // Adjust the radius as needed
                      backgroundImage: NetworkImage(
                        'https://psmprojects.net/cadworld/$userprofile', // Replace with your image URL
                      ),
                    )
                    //  Center(
                    //   child: SizedBox(
                    //     height: 60,
                    //     width: 60,
                         
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(30)
                    //           ),
                    //           child: Image.network('https://psmprojects.net/cadworld/$userprofile'))
                    //   ),
                    // )
                    : userprofile == null ? Center(
                        child: CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.grey.shade400,
                            child: Image.asset("assets/images/profileimg.png")
                            // Image.network(Config.imageURL + jsonData["profiledetails"]["userPhoto"] ?? '',),
                            ),
                      ):Container(),
                      SizedBox(
                        height: 1.h,
                      ),
                   profilename == null ?   Center(
                        child: CircularProgressIndicator(),
                      ):Center(
                        child: Text(
                          profilename.toString().toUpperCase(),
                          style: GoogleFonts.inter(
                              color: Color(0xff333333),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 2.7.h,
                      ),
                      ListView.builder(
                          itemCount: navigate.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                index == 1
                                    ? Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                GetProfileScreen()))
                                    : index == 6
                                        ? showLogoutPopup()
                                        : Navigator.pushNamed(context,
                                            route?[index]['link'] ?? '/');
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 1.2.h),
                                decoration: BoxDecoration(
                                    color: Color(0xffF9F9FB),
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: Color(0xffF9F9FB), width: 1)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    navigate[index].toString(),
                                    style: GoogleFonts.inter(
                                        color:
                                            Color(0xff333333).withOpacity(0.8),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 2.7.h,
                      ),
                      Image.asset(
                        "assets/images/pg12-1.png",
                        height: 5.3.h,
                        width: 19.7.w,
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Version ${_packageInfo.version}',
                          style: TextStyle(
                            color: Color(0xff78789d),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}



// (jsonData == null)
//                   ? Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Loading',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15.sp,
//                               color: Config.primaryTextColor,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 2.w,
//                           ),
//                           const CupertinoActivityIndicator(
//                             radius: 25,
//                             color: Colors.black,
//                           ),
//                         ],
//                       ),
//                     )
//                   : SafeArea(
//                       child: Container(
//                         decoration: BoxDecoration(color: Colors.transparent),
//                         child: Column(
//                           children: <Widget>[
//                             Align(
//                               alignment: Alignment.topLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 4.w, top: 4, bottom: 4),
//                                 child: Text(
//                                   details?[0]["text1"],
//                                   style: TextStyle(
//                                       fontSize: 11.sp,
//                                       fontWeight: FontWeight.w600,
//                                       color: Config.primaryTextColor),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 18),
                            // CircleAvatar(
                            //     radius: 32,
                            //     backgroundColor: Colors.grey.shade400,
                            //     child:
                            //         Image.asset("assets/images/profileimg.png")
                            //     // Image.network(Config.imageURL + jsonData["profiledetails"]["userPhoto"] ?? '',),
                            //     ),
//                             SizedBox(height: 3.h),
//                             Container(
//                               width: 40.w,
//                               child: Text(
//                                   "${jsonData["profiledetails"]["profileName"] ?? ''}",
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                       fontSize: 5.w,
//                                       color: Config.primaryTextColor,
//                                       fontWeight: FontWeight.w600),
//                                   textAlign: TextAlign.center),
//                             ),
//                             SizedBox(height: 3.w),
//                             ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: const ScrollPhysics(),
//                                 itemCount: items?.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return Padding(
//                                     padding:
//                                         EdgeInsets.only(left: 4.w, right: 4.w),
//                                     child: Container(
//                                       height: 3.4.h,
//                                       width: 60.w,
//                                       margin: EdgeInsets.only(bottom: 1.5.h),
//                                       decoration: BoxDecoration(
//                                         color: Config.containerColor,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: InkWell(
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 4.w, top: 4, bottom: 4),
//                                           child: Text(
//                                             items?[index]["list"] ?? '',
//                                             textAlign: TextAlign.left,
//                                             style: TextStyle(
//                                               fontSize: 12.sp,
//                                               color: Config.primaryTextColor,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                           ),
//                                         ),
//                                         onTap: () async {
//                                           Navigator.pop(context);
//                                           Navigator.pushNamed(context,
//                                               route?[index]['link'] ?? '/');
//                                         },
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.w, right: 4.w),
//                               child: Container(
//                                 height: 3.4.h,
//                                 width: 100.w,
//                                 margin: EdgeInsets.only(bottom: 1.5.h),
//                                 decoration: BoxDecoration(
//                                   color: Config.containerColor,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: InkWell(
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 4.w, top: 4, bottom: 4),
//                                     child: Text(
//                                       'Logout',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         fontSize: 12.sp,
//                                         color: Config.primaryTextColor,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                   onTap: () async {
//                                     Navigator.pop(context);
//                                     showLogoutPopup();
//                                   },
//                                 ),
//                               ),
//                             ),
                           
//                           ],
//                         ),
//                       ),

