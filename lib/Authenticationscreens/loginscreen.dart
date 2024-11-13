
import 'package:dio/dio.dart';
import 'package:commercilapp/Authenticationscreens/forgotpassworld.dart';
import 'package:commercilapp/Authenticationscreens/signuppage.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:commercilapp/homepage/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../constant/colorconstant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    // Define the regex pattern for email validation
    const pattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? curpswrd;
  

  bool _isLoading = false;

  Future<void> login() async {
    final dio = Dio();
    final String url = 'https://mycommercialpal.com/api-login.php';
    final Map<String, dynamic> requestData = {
      'emailid': _phoneoremailController.text,
      'password': _passwordController.text,
    };

    try {
      final response = await dio.post(url, data: requestData);

      if (response.statusCode == 200) {
        final data = response.data;
       

        // Check if any of the required fields are null
        if (data['success'] == null ||
            data['message'] == null ||
            data['userlastname'] == null ||
            data['useremail'] == null ||
            data['username'] == null ||
            data['token'] == null || data['userid'] == null) {
          // Display a roast message if any field is null
          final roastMessages = [
            "I've seen better coding skills... on my microwave.",
            "Your code is like a maze, only with no exit.",
            "Are you debugging or just making it worse?",
            "If your code was any slower, it would be going backwards.",
            "You might want to switch to Morse code... it's more readable.",
          ];

          final randomRoast = (roastMessages..shuffle()).first;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(randomRoast),
              duration: Duration(seconds: 3),
              action: SnackBarAction(
                label: 'Ouch!',
                onPressed: () {
                  // Optionally handle "Ouch!" action
                },
              ),
            ),
          );
        } else {
          // All fields are valid, proceed with navigation and data saving
        
          
          _passwordController.clear();
          _phoneoremailController.clear();
          
           final prefs = await SharedPreferences.getInstance();
            await prefs.setString('curpwd', data['curpwd']);
            await prefs.setString('logintoken', data['token']);
            setState(() {
              curpswrd = prefs.getString('curpwd');
            });
          
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );


          // Save data in SharedPreferences
          await saveLoginData(data);
        }
      } else {
       
      }
    } catch (e) {
     e.toString();
    }
  }

  Future<void> saveLoginData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
  
    await prefs.setString('token', data['token']);
    await prefs.setString('uid', data['userid']);
    
   
    
   
    
  }
  
  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: ColorConstants.whiteColor,
            title: Text('Are you sure?',
                style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            content: Text('Do you want to quit the app?',
                style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                    style: GoogleFonts.plusJakartaSans(
                        color: ColorConstants.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  ); // Replace with your actual login page route
                },
                child: Text('Yes',
                    style: GoogleFonts.plusJakartaSans(
                        color: ColorConstants.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ) ??
        false;
  }




  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneoremailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onWillPop ,
      child: Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    ImageConstants.COMMERCIALPAL,
                    height: 24,
                    width: 200,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: GoogleFonts.plusJakartaSans(
                              color: ColorConstants.secondaryColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Text('Don’t have an account?',
                                style: GoogleFonts.plusJakartaSans(
                                    color: ColorConstants.textcolor,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400)),
                            GestureDetector(
                              onTap: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()),
                                );
                              }),
                              child: Text('Sign Up',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: ColorConstants.lightblue,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _phoneoremailController,
                            keyboardType: TextInputType.name,
                            validator: emailValidator,
                            style: TextStyle(
                              color: ColorConstants.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              fillColor: ColorConstants.whiteColor,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                  color: ColorConstants.textcolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          // height: 48,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _isObscured,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(
                              color: ColorConstants.textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              fillColor: ColorConstants.textcolor,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: ColorConstants.textcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(
                                      color: ColorConstants.bordercolor,
                                      width: 1)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: ColorConstants.textcolor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscured = !_isObscured;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                            );
                          },
                          child: Text('Forgot password?',
                              style: GoogleFonts.plusJakartaSans(
                                  color: ColorConstants.lightblue,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400)),
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        GestureDetector(
                          onTap: login,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorConstants.primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text('Sign In',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: ColorConstants.whiteColor,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (() {}),
                        child: Text('Privacy Policy',
                            style: GoogleFonts.plusJakartaSans(
                                color: ColorConstants.lightblue,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400)),
                      ),
                      Text(' and ',
                          style: GoogleFonts.plusJakartaSans(
                              color: ColorConstants.textcolor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400)),
                      GestureDetector(
                        onTap: (() {}),
                        child: Text('Terms of Service.',
                            style: GoogleFonts.plusJakartaSans(
                                color: ColorConstants.lightblue,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
