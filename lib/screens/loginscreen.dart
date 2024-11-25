import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:legala/constants/imageconstant.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:legala/screens/dummy.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/coloconstant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  bool isChecked = false;
  String? access_token;
  String? refresh_token;

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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed further

      const url = 'https://www.eparivartan.co.in/rentalapp/public/auth/login';

      try {
        // Make the POST request
        final response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "userEmailid": _phonecontroller.text,
            "userPassword": _passwordController.text,
          }),
        );

        // Check if the response is successful
        
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);

          print(responseData);
          print(responseData['message']);
          print(responseData['access_token']);
          print(responseData['refresh_token']);

          Provider.of<TokenProvider>(context, listen: false).setTokens(
            responseData['access_token'],
            responseData['refresh_token'],
          );
          if (isChecked) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', responseData['access_token']);
          await prefs.setString('refresh_token', responseData['refresh_token']);
          print('Tokens saved in local storage.');
        }
        print(isChecked.toString());
          _phonecontroller.clear();
          _passwordController.clear();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sucesffuly()),
          );

          print('Response saved successfully in local storage.');
        } else {
          print('Failed to login: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print("Form is not valid");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    ImageConstants.LOGO,
                    height: 55,
                    width: 200,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: 250,
                  child: Text('Welcome to Legala Rental App!',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.urbanist(
                          color: Color(0xff192252),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sign in your account',
                  style: GoogleFonts.urbanist(
                      color: Color(0xff848FAC),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Your Email',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    controller: _phonecontroller,
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
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('Your Password',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 15,
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
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Color(0xff192252), width: 1)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: ColorConstants
                          .primaryColor, // Custom fill color when checked
                    ),
                    Text('Remember Me',
                        style: GoogleFonts.urbanist(
                            color: ColorConstants.textcolor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        // Handle "Forgot Password" button press
                        showEmailDialog(context);
                      },
                      child: Text('Forgot Password',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.textcolor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: _submitForm,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('Log In',
                          style: GoogleFonts.plusJakartaSans(
                              color: ColorConstants.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
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

  void showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Remove radius
                ),
                content: EmailForm(),
              ),
            ),
            Positioned(
                right: 13,
                top: 225,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        child: Image.asset(
                      ImageConstants.CLOSEBUTTON,
                      height: 40,
                    ))))
          ],
        );
      },
    );
  }
}

class EmailForm extends StatefulWidget {
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text('Forgot Password',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.urbanist(
                    color: Color(0xff192252),
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Enter your email account to reset your password',
            style: GoogleFonts.urbanist(
                color: Color(0xff848FAC),
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Your Email',
              style: GoogleFonts.urbanist(
                  color: ColorConstants.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              fillColor: ColorConstants.whiteColor,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: 'Email Address',
              hintStyle: TextStyle(
                  color: ColorConstants.textcolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff192252), width: 1)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff192252), width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff192252), width: 1)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff192252), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff192252), width: 1)),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email address';
              }
              // Simple email validation
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Handle the email submission here
                print('Email: ${_emailController.text}');
                Navigator.of(context).pop(); // Close the dialog
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text('Reset Password',
                    style: GoogleFonts.plusJakartaSans(
                        color: ColorConstants.whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
