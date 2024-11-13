import 'dart:convert';
import 'package:commercilapp/Authenticationscreens/loginscreen.dart';
import 'package:commercilapp/constant/apiconstant.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneoremailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  bool _isObscured = true;
  bool _isLoading = false;
  bool _isChecked = false;
  double _passwordStrength = 0;
  Color _passwordStrengthColor = Colors.red;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordStrength);
  }

  void _updatePasswordStrength() {
    String password = _passwordController.text;
    setState(() {
      _passwordStrength = _calculatePasswordStrength(password);
      _passwordStrengthColor = _getPasswordStrengthColor(_passwordStrength);
    });
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) {
      return 0;
    }

    double strength = 0;

    // Check length
    if (password.length >= 8) {
      strength += 0.25;
    }
    if (password.length >= 12) {
      strength += 0.25;
    }

    // Check for uppercase letter
    if (password.contains(RegExp(r'[A-Z]'))) {
      strength += 0.25;
    }

    // Check for number
    if (password.contains(RegExp(r'[0-9]'))) {
      strength += 0.25;
    }

    // Check for special character
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      strength += 0.25;
    }

    return strength;
  }

  Color _getPasswordStrengthColor(double strength) {
    if (strength <= 0.25) {
      return Colors.red;
    } else if (strength <= 0.5) {
      return Colors.orange;
    } else if (strength <= 0.75) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  Future<void> _SignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Define the API URL
      final String url = '${BaseUrl}api-registration.php';

      // Prepare the data to be sent to the API
      final Map<String, String> data = {
        'firstname': _firstnameController.text,
        'lastname': _lastnameController.text,
        'emailid': _phoneoremailController.text,
        'usermobile': _phonenumberController.text,
        'password': _passwordController.text,
      };

      try {
        // Make the API call
        final response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        );

        // Handle the response
        if (response.statusCode == 200) {
          // Success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.body.toString())),
          );

         
          // Clear the form fields
          _passwordController.clear();
          _phoneoremailController.clear();
          _firstnameController.clear();
          _phonenumberController.clear();
          _lastnameController.clear();

          // Navigate to LoginScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          // Failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to register')),
          );
        }
      } catch (e) {
        // Handle exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
                  height: 10.h,
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
                          Text('Already have an account?',
                              style: GoogleFonts.plusJakartaSans(
                                  color: ColorConstants.textcolor,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400)),
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
                        child: TextFormField(
                          controller: _firstnameController,
                          keyboardType: TextInputType.name,
                          style: TextStyle(
                            color: ColorConstants.textcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: ColorConstants.whiteColor,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            hintText: 'FirstName',
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
                        child: TextFormField(
                          controller: _lastnameController,
                          keyboardType: TextInputType.name,
                          style: TextStyle(
                            color: ColorConstants.textcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Last name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: ColorConstants.whiteColor,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            hintText: 'LastName',
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
                        child: TextFormField(
                          controller: _phonenumberController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(
                                10), // Limit to 10 characters
                            FilteringTextInputFormatter
                                .digitsOnly, // Allow only numbers
                          ],
                          style: TextStyle(
                            color: ColorConstants.textcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Phone';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: ColorConstants.whiteColor,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            hintText: 'Mobile Number',
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
                      SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: _passwordStrength,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                            _passwordStrengthColor),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                     GestureDetector(
                              onTap: _isLoading ? null : _SignUp,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: _isLoading
                                      ? Colors.grey
                                      : ColorConstants.primaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: _isLoading
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  ColorConstants.primaryColor),
                                        )
                                      : Text('Sign In',
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
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _isChecked,
                      activeColor: ColorConstants.lightblue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 7),
                      width: 220,
                      child: Text(
                        'By clicking Create account, I agree that I have read and accepted the Terms of Use and Privacy Policy.',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: GoogleFonts.plusJakartaSans(
                            color: Color(0xFF84818A),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
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
    );
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updatePasswordStrength);
    _passwordController.dispose();

    super.dispose();
  }
}
