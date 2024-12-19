import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/providers/codesaver.dart';
import 'package:legala/screens/createnewpassword.dart';
import 'package:provider/provider.dart';

class CodeVerifier extends StatefulWidget {
  const CodeVerifier({super.key});

  @override
  State<CodeVerifier> createState() => _CodeVerifierState();
}

class _CodeVerifierState extends State<CodeVerifier> {
  final _formKey = GlobalKey<FormState>();
  final codeverifier = TextEditingController();

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
        context, MaterialPageRoute(builder: (context) => const NewPassword()));
  }

  // Function to send forgot password request
 Future<void> verifyCode() async {
    final String url =
        "https://eparivartan.co.in/rentalapp/public/forgotverification?vcode=${codeverifier.text}";

    try {
      showLoader(); // Show loader before API call

      final response = await http.get(Uri.parse(url));

      hideLoader(); // Hide loader after response

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['message'] == "Verification successful") {
          // Navigate to the next page
           hideLoader();
        } else if (responseData['message'] == "Verification Failed") {
          // Show toast message for failed verification
          Fluttertoast.showToast(
            msg: "Verification Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          // Handle unexpected messages
          Fluttertoast.showToast(
            msg: responseData['message'] ?? "Unknown response from server.",
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
      hideLoader(); // Hide loader on error
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                'Verify yor verification code',
                style: GoogleFonts.urbanist(
                    color: const Color(0xff848FAC),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Your verification code',
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: codeverifier,
                decoration: InputDecoration(
                  fillColor: ColorConstants.whiteColor,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  hintText: 'Enter your verfication code',
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
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  }
                  // Simple email validation
        
                  return null;
                },
              ),
              const SizedBox(height: 16),
               GestureDetector(
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final code  = codeverifier.text.trim();
                   Provider.of<CodeProvider>(context, listen: false)
                    .setCode(code);

                  // Call the API to send the forgot password request
                 verifyCode();
        
                  // Clear the email input field
                  codeverifier.clear();
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
        ),
      ),
    );
  }
}
