// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, deprecated_member_use

// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/providers/codesaver.dart';
import 'package:legala/screens/loginscreen.dart';
import 'package:provider/provider.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({
    super.key,
  });

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
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

  bool isLoading = false; // Loading state

 Future<void> changePassword() async {
  const String url = "https://eparivartan.co.in/rentalapp/public/changePasswordCheck";

  final String vcode = Provider.of<CodeProvider>(context, listen: false).code;
  final String newPassword = _passwordController.text.trim();
  final String confirmPassword = _conformpasswordController.text.trim();

  setState(() {
    isLoading = true; // Show loader when the API call starts
  });

  try {
    // Send the POST request
    final response = await http.post(
      Uri.parse(url),
      body: {
        "vcode": vcode,
        "newpassword": newPassword,
        "conpassword": confirmPassword,
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final responseData = json.decode(response.body);
      String message = responseData['message'];

      if (message == "password successfully updated and verification code cleared") {
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );

        // Navigate to the login page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else if (message == "password and confirm password does not match") {
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Unexpected response: $message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Failed to update password. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Error occurred: $e",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  } finally {
    setState(() {
      isLoading = false; // Hide loader when the API call finishes
    });
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Image.asset(
                            ImageConstants.LOGO,
                            height: 24,
                            width: 200,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                      color: const Color(0xFF84818A),
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
                                  style: const TextStyle(
                                    color: ColorConstants.textcolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: ColorConstants.textcolor,
                                    hintText: 'Create new password',
                                    hintStyle: const TextStyle(
                                      color: ColorConstants.textcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: const BorderSide(
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
                                  style: const TextStyle(
                                    color: ColorConstants.textcolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: ColorConstants.textcolor,
                                    hintText: 'Confirm password',
                                    hintStyle: const TextStyle(
                                      color: ColorConstants.textcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: const BorderSide(
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
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      changePassword();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                          const SizedBox(
                            height: 10,
                          ),
                        
                        ]),
                  ),
                ),
               
                const SizedBox(
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
