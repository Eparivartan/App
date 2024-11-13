import 'dart:convert';
import 'dart:io'; // Changed from 'dart:html' to 'dart:io'
import 'package:commercilapp/models/userdetails.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:commercilapp/Authenticationscreens/loginscreen.dart';
import 'package:commercilapp/constant/apiconstant.dart';
import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:commercilapp/profile/changepassword.dart';
import 'package:commercilapp/profile/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image; // Changed from 'File?' to 'File?' from 'dart:io'
  String? _userlastname;
  String? _useremail;
  String? _username;
  String? _token;
  String? _uid;
  String? _userphone;
  String? userfirstname;
  String? userlastname;
  String? useremail;
  String? userphoto;
  Map<String, dynamic>? userDetails; // To hold user details
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
     
      _uid = prefs.getString('uid');
     
    });
  
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      final response = await http.get(Uri.parse(
          'https://mycommercialpal.com/api-profile.php?userid=$_uid'));

        


      if (response.statusCode == 200) {
      
        final List<dynamic> data = json.decode(response.body);
       

        if (data.isNotEmpty) {
          setState(() {
            userDetails = data[0]; // Get the first user detail
            isLoading = false; // Stop loading
          });
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              'userFirstName', userDetails?['userFirstName']?.toString() ?? '');
          await prefs.setString(
              'userLastName', userDetails?['userLastName']?.toString() ?? '');
          await prefs.setString(
              'userEmail', userDetails?['userEmail']?.toString() ?? '');
          await prefs.setString(
              'userMobile', userDetails?['userMobile']?.toString() ?? '');
          await prefs.setString(
              'userImage', userDetails?['userImage']?.toString() ?? '');
         
        } else {
        
          setState(() => isLoading = false); // Stop loading
        }
      } else {
        // Handle error
      
        setState(() => isLoading = false); // Stop loading
      }
    } catch (e) {
     
      setState(() => isLoading = false); // Stop loading
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        setState(() {
          isLoading = true;
        });
        _loadUserData();
      },
      child: Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        body: Column(
          children: [
            SizedBox(
              height: 65,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorConstants.whiteColor,
                      border:
                          Border.all(color: ColorConstants.bordercolor, width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.asset(ImageConstants.HOME, height: 20),
                  ),
                ),
                SizedBox(
                  width: 4.w,
                )
              ],
            ),
            SizedBox(height: 3.h),
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  (userDetails?['userImage']?.toString() ?? '').isEmpty
                      ? AssetImage(ImageConstants.LOGO)
                      : NetworkImage('https://mycommercialpal.com/${userDetails!['userImage'].toString()}')
                          as ImageProvider,
            ),
            SizedBox(
              height: 1.h,
            ),
            Center(
              child: Text(
                '${userDetails?['userFirstName']?.toString() ?? ''}${userDetails?['userLastName']?.toString() ?? ''}',
                style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Center(
              child: Text(
                '${userDetails?['userEmail']?.toString() ?? ''}',
                style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFFB8B8B8),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
              Center(
              child: Text(
                '${userDetails?['userMobile']?.toString() ?? ''}',
                style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFFB8B8B8),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile(
                    userDetails: userDetails.toString(),
                  )),
                );
              },
              leading: Image.asset(
                ImageConstants.EDITPROFILE,
                height: 30,
              ),
              trailing: Image.asset(
                ImageConstants.ARROWRIGHT,
                height: 15,
              ),
              title: Text(
                'Edit Profile',
                style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
              leading: Image.asset(
                ImageConstants.CHANGEPASSWORD,
                height: 30,
              ),
              trailing: Image.asset(
                ImageConstants.ARROWRIGHT,
                height: 15,
              ),
              title: Text(
                'Change Password',
                style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              onTap: () {
                _showPopup(context);
              },
              leading: Image.asset(
                ImageConstants.LOGOUT,
                height: 30,
              ),
              trailing: Image.asset(
                ImageConstants.ARROWRIGHT,
                height: 15,
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the popup without doing anything
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () async {
                // Clear the token from SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('token'); // Removes the token

                // Navigate to the login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ); // Replace '/login' with your actual login route
              },
            ),
          ],
        );
      },
    );
  }
}
