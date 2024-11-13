import 'package:commercilapp/Authenticationscreens/newpassword.dart';
import 'package:commercilapp/Authenticationscreens/signuppage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

import '../constant/colorconstant.dart';
import '../constant/imageconstant.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  final _formKey = GlobalKey<FormState>();
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

  @override
  
  Future<void> verifyemail() async {
    final dio = Dio();
    final String url = 'https://mycommercialpal.com/api-forgotpwd.php';
    final Map<String, dynamic> requestData = {
      'emailid': _emailController.text,
    };
    try {
      final response = await dio.post(url, data: requestData);
      if (response.statusCode == 200) {
        final data = response.data;
       
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NewPassword(uid: data['userid'], token: data['token'])),
        );
      }
    } catch (e) {
       e.toString();
    }
  }

  final TextEditingController _emailController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
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
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Forgot password?',
                                    style: GoogleFonts.plusJakartaSans(
                                        color: ColorConstants.secondaryColor,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    'No worriest! Just enter your email and we’ll send you a reset password link.',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Color(0xFF84818A),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      controller: _emailController,
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
                                        hintText: 'host@example.com',
                                        hintStyle: TextStyle(
                                            color: ColorConstants.textcolor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                                color:
                                                    ColorConstants.bordercolor,
                                                width: 1)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                                color:
                                                    ColorConstants.bordercolor,
                                                width: 1)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                                color:
                                                    ColorConstants.bordercolor,
                                                width: 1)),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                                color:
                                                    ColorConstants.bordercolor,
                                                width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                                color:
                                                    ColorConstants.bordercolor,
                                                width: 1)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        verifyemail();
                                      }
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 13),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.primaryColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text('Send Recovery Email',
                                            style: GoogleFonts.plusJakartaSans(
                                                color:
                                                    ColorConstants.whiteColor,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: (() {
                                          Navigator.pop(context);
                                        }),
                                        child: Text('Back to',
                                            style: GoogleFonts.plusJakartaSans(
                                                color: ColorConstants
                                                    .secondaryColor,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      GestureDetector(
                                        onTap: (() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpPage()),
                                          );
                                        }),
                                        child: Text('Sign In',
                                            style: GoogleFonts.plusJakartaSans(
                                                color: ColorConstants.lightblue,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w400)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
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
                    height: 20,
                  )
                ],
              )),
        ));
  }
}
