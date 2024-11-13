import 'dart:async';
import 'dart:convert';
import 'package:careercoach/Register%20Page.dart';
import 'package:careercoach/demoprofile.dart';
import 'package:careercoach/demoregister.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Config.dart';
import 'Home Page.dart';
import 'package:http/http.dart' as http;

class LoggedIn extends StatefulWidget {

final userid;

LoggedIn({required, this.userid});



  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  var jsonData;
  List? details;
  List? items;
  String profilename = '';
  String profilemail = '';
  String? userid;


  @override
  void initState() {
   
    _loadUserId();
    

    super.initState();
  }

  Future<void> _loadUserId() async {
  setState(() {
    userid = widget.userid?.toString(); // Safely access widget.userid
  });

  print(userid.toString());

  if (userid != null && userid!.isNotEmpty) {
    // Call the function if user ID exists
    getProfileDetails();
  } else {
    // Show a roast message when userid is null or empty
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "User Not Found",
          style: TextStyle(fontSize: 16),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}


  Future<void> getProfileDetails() async {
  
    final response = await http.get(
        Uri.parse('${Config.baseURL}my-profile/${userid}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      setState(() {
        debugPrint('Print_______-----   $jsonData');
        profilename = jsonData['profiledetails']['profileName'];
        profilemail = jsonData['profiledetails']['emailId'];
      });
       Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => HomePage()));
      

      debugPrint("Profile Details ++ $profilename");
      debugPrint("Profile Details ++ $profilemail");
    } else {
      debugPrint('get call error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Timer(
    //     Duration(seconds: 2),
    //     () => profileName == null ?Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (BuildContext context) => Test())):  Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (BuildContext context) => HomePage())));
    return Scaffold(
      backgroundColor: Config.whiteColor,
      body: SafeArea(
          child: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35.8.h,
                ),
                Image.asset('assets/images/LoginSuccessful.png',
                    height: 24.h, width: 55.w),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Mobile Verification Successful',
                  style: TextStyle(
                      color: Color(0xff8CB93D),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
