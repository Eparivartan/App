import 'package:commercilapp/Authenticationscreens/loginscreen.dart';
import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:commercilapp/profile/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class NewPassword extends StatefulWidget {
  final uid;
  final token;
  const NewPassword({super.key, required this.uid, required this.token});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  bool _iscreate = false;
  bool _isconform = false;
  String? userId;
  String? userEmail;
  String? token;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformpasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
   
  }

  Future<void> resetPassword() async {
    // Create Dio instance
    Dio dio = Dio();

    // Define the API endpoint
    String url = 'https://mycommercialpal.com/api-resetpwd.php';
   
    // Define the request body
    Map<String, dynamic> requestBody = {
      "password": _passwordController.text,
      "conpassword": _conformpasswordController.text,
      "token": widget.token.toString(),
      "uid": widget.uid.toString(),
    };

  

    try {
      // Send POST request
      Response response = await dio.post(url, data: requestBody);

     

      // Check the response
      if (response.statusCode == 200) {
    
        final data = response.data;
       
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
     
      } else {
       
      }
    } on DioError catch (e) {
     e.toString();
    }
  }

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
                                  'New Password',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: ColorConstants.secondaryColor,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Please create a new password that you don’t use on any other site.",
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
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: _iscreate,
                                  keyboardType: TextInputType.visiblePassword,
                                  style: TextStyle(
                                    color: ColorConstants.textcolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: ColorConstants.textcolor,
                                    hintText: 'Create new password',
                                    hintStyle: TextStyle(
                                      color: ColorConstants.textcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: BorderSide(
                                        color: ColorConstants.bordercolor,
                                        width: 1,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _iscreate
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: ColorConstants.textcolor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _iscreate = !_iscreate;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) =>
                                      _validatePassword(value),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFormField(
                                  controller: _conformpasswordController,
                                  obscureText: _isconform,
                                  keyboardType: TextInputType.visiblePassword,
                                  style: TextStyle(
                                    color: ColorConstants.textcolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: ColorConstants.textcolor,
                                    hintText: 'Confirm password',
                                    hintStyle: TextStyle(
                                      color: ColorConstants.textcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: BorderSide(
                                        color: ColorConstants.bordercolor,
                                        width: 1,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isconform
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: ColorConstants.textcolor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isconform = !_isconform;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      resetPassword();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.primaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text('Send Recovery Email',
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
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (() {}),
                                child: Text('Back to',
                                    style: GoogleFonts.plusJakartaSans(
                                        color: ColorConstants.secondaryColor,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              GestureDetector(
                                onTap: (() {}),
                                child: Text('Sign In',
                                    style: GoogleFonts.plusJakartaSans(
                                        color: ColorConstants.lightblue,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400)),
                              )
                            ],
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
            ),
          ),
        ));
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
   
    if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    if (!RegExp(r'(?=.*?[0-9].*?[0-9].*?[0-9])').hasMatch(value)) {
      return 'Password must contain at least three numbers';
    }
    return null;
  }
}
