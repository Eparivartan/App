import 'package:commercilapp/Authenticationscreens/loginscreen.dart';
import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  String? _userlastname;
  String? _useremail;
  String? _username;
  String? _token;
  String? _uid;
  String? curpswrd;
  String? chngepasswordtoken;
  String? changepasswordid;
  String? _userphone;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
   
    setState(() {
       _userlastname = prefs.getString('userlastname');
      _useremail = prefs.getString('emailid');
      _username = prefs.getString('username');
      _token = prefs.getString('token');
      _uid = prefs.getString('uid');
      _userphone = prefs.getString('usermobile');
       curpswrd = prefs.getString('curpwd');
     
    });
    print(_userlastname.toString());
    print(curpswrd.toString());
  }

  Future<void> currentpasswordvalidator() async {
    if (_currentpassword.text == curpswrd.toString()) {
      // Show error toast if passwords do not match
      Fluttertoast.showToast(
        msg: 'Password verified successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
       verifyemail();

      
    }else{
       Fluttertoast.showToast(
      msg: 'Current password does not match!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

   
    }

    // If passwords match, show success message
   
  }

  Future<void> verifyemail() async {
    final dio = Dio();
    final String url = 'https://mycommercialpal.com/api-forgotpwd.php';
    final Map<String, dynamic> requestData = {
      'emailid': _useremail.toString(),
    };
    try {
      final response = await dio.post(url, data: requestData);
      if (response.statusCode == 200) {
        final data = response.data;
        print(data.toString());
        print(data['message']);
        print(data['userid']);
        print(data['useremail']);
        print(data['token']);

        setState(() {
          chngepasswordtoken = data['token'];
          changepasswordid = data['userid'];
        });
        print(chngepasswordtoken);
        print(changepasswordid.toString());
        resetPassword();
      }
    } catch (e) {
      print(e.toString());
    }
  }


  
  Future<void> resetPassword() async {
    // Create Dio instance
    Dio dio = Dio();

    // Define the API endpoint
    String url = 'https://mycommercialpal.com/api-resetpwd.php';
    print(url.toString());
    // Define the request body
    Map<String, dynamic> requestBody = {
      "password": _newpassword.text,
      "conpassword": _conformpassword.text,
      "token":chngepasswordtoken.toString(),
      "uid": changepasswordid.toString(),
    };

    print(requestBody.toString());

    try {
      // Send POST request
      Response response = await dio.post(url, data: requestBody);

      print(response.toString());

      // Check the response
      if (response.statusCode == 200) {
        print('Password reset successful: ${response.data}');
        final data = response.data;
        print(data.toString()+'>>>>>>>>>>><<<<<<<<<<<<<<<<<<');
         final prefs = await SharedPreferences.getInstance();
              await prefs.remove('token'); // Removes the token

              // Navigate to the login page
               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
        
     
      } else {
       
      }
    } on DioError catch (e) {
     e.toString();
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentpassword = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();
  final TextEditingController _conformpassword = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                        border: Border.all(
                            color: ColorConstants.bordercolor, width: 1),
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
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change Password',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.urbanist(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.secondaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              currentpassword(),
              SizedBox(
                height: 1.5.h,
              ),
              newpassword(),
              SizedBox(
                height: 1.5.h,
              ),
              conformpassword(),
              SizedBox(
                height: 4.h,
              ),
              GestureDetector(
                onTap: currentpasswordvalidator,
                child: Container(
                  height: 5.h,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text('Save',
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
      ),
    );
  }

  // currentpassword

  Widget currentpassword() {
    return TextFormField(
      controller: _currentpassword,
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.textcolor,
        hintText: "Current Password",
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(
            color: ColorConstants.bordercolor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(
            color: ColorConstants.bordercolor,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(
            color: ColorConstants.bordercolor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(
            color: ColorConstants.bordercolor,
            width: 1,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }

  // newpassword

  Widget newpassword() {
    return Container(
      child: TextFormField(
        controller: _newpassword,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.textcolor,
          hintText: "New Password",
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: ColorConstants.bordercolor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: ColorConstants.bordercolor,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: ColorConstants.bordercolor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: ColorConstants.bordercolor,
              width: 1,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
      ),
    );
  }

  // conformpassword

  Widget conformpassword() {
    return Container(
      child: TextFormField(
        controller: _conformpassword,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.textcolor,
          hintText: "Conform Password",
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: ColorConstants.bordercolor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: ColorConstants.bordercolor,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: ColorConstants.bordercolor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: ColorConstants.bordercolor,
              width: 1,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
