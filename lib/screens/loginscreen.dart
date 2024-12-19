// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously, non_constant_identifier_names, duplicate_ignore, dead_code, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/services.dart';
import 'package:legala/screens/codecerifier.dart';
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
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  bool isChecked = false;
  bool _isLoading = false;

  // ignore: non_constant_identifier_names
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

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      showToast('Form is not valid');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    const url = 'https://www.eparivartan.co.in/rentalapp/public/auth/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userEmailid": _phonecontroller.text,
          "userPassword": _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        Provider.of<TokenProvider>(context, listen: false).setTokens(
          responseData['access_token'],
          responseData['refresh_token'],
        );

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', responseData['access_token']);
          await prefs.setString('refresh_token', responseData['refresh_token']);

        _phonecontroller.clear();
        _passwordController.clear();

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Sucesffuly()));

        showToast('Response saved successfully in local storage.');
      } else {
        showToast('Error: wrong credentials');
      }
    } catch (e) {
      showToast('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () async {
      // You can handle the back button here. 
      // For example, if you want to prevent exiting the app:
      bool shouldExit = false; // Set this to true if you want to exit the app
      if (shouldExit) {
        return true; // Allow exiting the app
      } else {
        Navigator.pop(context); // Navigate to the previous screen
        return false; // Prevent exiting the app
      }
    },

      child: Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
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
                  const SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                    width: 250,
                    child: Text('Welcome to Legala Rental App!',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.urbanist(
                            color: const Color(0xff192252),
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign in your account',
                    style: GoogleFonts.urbanist(
                        color: const Color(0xff848FAC),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Your Email',
                      style: GoogleFonts.urbanist(
                          color: ColorConstants.secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _phonecontroller,
                    keyboardType: TextInputType.name,
                    validator: emailValidator,
                    style: const TextStyle(
                      color: ColorConstants.textcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      fillColor: ColorConstants.whiteColor,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      hintText: 'Email Address',
                      hintStyle: const TextStyle(
                          color: ColorConstants.textcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Your Password',
                      style: GoogleFonts.urbanist(
                          color: ColorConstants.secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscured,
                    keyboardType: TextInputType.visiblePassword,
                    style: const TextStyle(
                      color: ColorConstants.textcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      fillColor: ColorConstants.textcolor,
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: ColorConstants.textcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff192252), width: 1)),
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
                  const SizedBox(
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
                      const Spacer(),
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
                  const SizedBox(
                    height: 30,
                  ),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          backgroundColor: ColorConstants.primaryColor,
                          semanticsLabel: ImageConstants.LOGO,
                        ))
                      : GestureDetector(
                          onTap: _isLoading ? null : _submitForm,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: _isLoading
                                  ? ColorConstants.primaryColor
                                  : ColorConstants.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: _isLoading
                                  ? Image.asset(
                                      'assets/images/logo.png',
                                      height: 60,
                                      width: 40,
                                    )
                                  : Text(
                                      'Log In',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                ],
              ),
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
            const SizedBox(
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
                top: 220,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      ImageConstants.CLOSEBUTTON,
                      height: 40,
                    )))
          ],
        );
      },
    );
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool isLoading = false;

  // Show loader dialog
  void showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: ColorConstants.whiteColor,
            semanticsLabel: ImageConstants.LOGO,
            color:ColorConstants.primaryColor,
          ),
        );
      },
    );
  }

  // Hide loader dialog
  void hideLoader() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CodeVerifier()));
  }

  // Function to send forgot password request
  Future<void> sendForgotPasswordRequest(String email) async {
    const String url = "${ApiConstants.baseUrl}${ApiConstants.forgotpassword}";

    showLoader(); // Show loader before starting API call

    try {
      final Map<String, String> body = {'email': email};

      final response = await http.post(Uri.parse(url), body: body);

      hideLoader(); // Hide loader when response is received

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['message'] == "Successfully changed") {
          // Navigate to NewPassword screen
          hideLoader();
        } else if (responseData['message'] == "Record does not exist") {
          // Show toast for 'Record does not exist'
          Fluttertoast.showToast(
            msg: "Record does not exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          // Handle other messages
          Fluttertoast.showToast(
            msg: responseData['message'] ?? 'Unknown response',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        // Handle non-200 status codes
        Fluttertoast.showToast(
          msg: "Error: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      hideLoader(); // Hide loader in case of error
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

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
                    color: const Color(0xff192252),
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Enter your email account to reset your password',
            style: GoogleFonts.urbanist(
                color: const Color(0xff848FAC),
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 25,
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Your Email',
              style: GoogleFonts.urbanist(
                  color: ColorConstants.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              fillColor: ColorConstants.whiteColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: 'Email Address',
              hintStyle: const TextStyle(
                  color: ColorConstants.textcolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xff192252), width: 1)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xff192252), width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xff192252), width: 1)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xff192252), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xff192252), width: 1)),
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
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                final email = _emailController.text.trim();

                // Call the API to send the forgot password request
                sendForgotPasswordRequest(email);

                // Clear the email input field
                _emailController.clear();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Reset Password',
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.whiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
