// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:sizer/sizer.dart';
//
// import 'Config.dart';
// import 'Register Page.dart';
// import 'Successfully Logged In.dart';
//
// class ResendOTP extends StatefulWidget {
//   const ResendOTP({Key? key}) : super(key: key);
//
//   @override
//   State<ResendOTP> createState() => _ResendOTPState();
// }
//
// class _ResendOTPState extends State<ResendOTP> {
//
//   // MobileVerificationState currentState =
//   //     MobileVerificationState.SHOW_MOBILE_FORM_STATE;
//
//   String country = '+91 ';
//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();
//
//   Color otpButton = Colors.white;
//   String? mobile;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   String? verificationId;
//
//   int userCount = 0;
//   bool showLoading = false;
//   String? value;
//   bool loggedin = false;
//
//   void signInWithPhoneAuthCredential(AuthCredential phoneAuthCredential) async {
//     try {
//       final authCredential =
//       await _auth.signInWithCredential(phoneAuthCredential);
//
//       setState(() {
//         showLoading = false;
//       });
//
//       if (authCredential.user != null) {
//         // SharedPreferences prefs = await SharedPreferences.getInstance();
//         // await prefs.setBool("login",true);
//
//         Timer(
//           const Duration(seconds: 2),
//               () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const LoggedIn(),
//             ),
//           ),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         showLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.message!),
//           backgroundColor: Colors.grey,
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             getOtpFormWidget(context)
//           ],
//         ),
//       ),
//     );
//   }
//
//   String? otp;
//   getOtpFormWidget(context) {
//     var height = MediaQuery.of(context).size.height;
//     return GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           backgroundColor: Config.whiteColor,
//           body: Center(
//             child: ListView(
//               padding: const EdgeInsets.all(20),
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 SizedBox(height: 20.w),
//                 Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.all(15),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Image.asset('assets/images/pg2-1.png'),
//                           SizedBox(
//                             height: 15.w,
//                           ),
//                           Text(
//                             'OTP Verification',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.poppins(
//                               textStyle: TextStyle(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 // color: Colors.deepPurple,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5.w,
//                           ),
//                           Text(
//                             "Enter the code sent to",
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.poppins(
//                               textStyle: TextStyle(
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             "$mobile",
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.poppins(
//                               textStyle: TextStyle(
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   height: 65.w,
//                   width: 80.w,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(color: Config.mainBorderColor)),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20, top: 18),
//                         child: Row(
//                           children: [
//                             Text(
//                               'Your code',
//                               style: GoogleFonts.poppins(
//                                 textStyle: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       OTPTextField(
//                         length: 6,
//                         width: MediaQuery.of(context).size.width,
//                         textFieldAlignment: MainAxisAlignment.spaceAround,
//                         fieldWidth: 30,
//                         fieldStyle: FieldStyle.underline,
//                         style: const TextStyle(fontSize: 16),
//                         onChanged: (pin) {
//                           otp = pin;
//                           setState(() {
//                             otpButton = Config.mainBorderColor;
//                           });
//                         },
//                         onCompleted: (pin) {
//                           debugPrint("Completed: " + pin);
//                         },
//                       ),
//                       SizedBox(
//                         height: 1.w,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10, right: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'OTP resent successfully',
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                     color: const Color(0XFF999999), fontSize: 8.sp),
//                               ),
//                             ),
//                             // InkWell(
//                             //   child: TextButton(
//                             //     onPressed: () async {
//                             //       await _auth.verifyPhoneNumber(
//                             //           phoneNumber:
//                             //           country + phoneController.text,
//                             //           timeout: const Duration(seconds: 60),
//                             //           verificationCompleted:
//                             //               (phoneAuthCredential) async {
//                             //             setState(() {
//                             //               showLoading = false;
//                             //             });
//                             //             signInWithPhoneAuthCredential(
//                             //                 phoneAuthCredential);
//                             //           },
//                             //           verificationFailed:
//                             //               (verificationFailed) async {
//                             //             setState(() {
//                             //               showLoading = false;
//                             //             });
//                             //             ScaffoldMessenger.of(context)
//                             //                 .showSnackBar(SnackBar(
//                             //                 content: Text(verificationFailed
//                             //                     .message!)));
//                             //           },
//                             //           codeSent: (verificationId,
//                             //               resendingToken) async {
//                             //             setState(() {
//                             //               showLoading = false;
//                             //               otpButton = Colors.white;
//                             //               currentState = MobileVerificationState
//                             //                   .SHOW_OTP_FORM_STATE;
//                             //               this.verificationId = verificationId;
//                             //             });
//                             //           },
//                             //           codeAutoRetrievalTimeout:
//                             //               (verificationId) async {
//                             //             setState(() {
//                             //               showLoading = false;
//                             //               currentState = MobileVerificationState
//                             //                   .SHOW_OTP_FORM_STATE;
//                             //               otpButton = Colors.white;
//                             //               this.verificationId = verificationId;
//                             //             });
//                             //           });
//                             //     },
//                             //     child: Text(
//                             //       "RESEND OTP",
//                             //       style: TextStyle(
//                             //         fontSize: 8.sp,
//                             //         fontWeight: FontWeight.bold,
//                             //         color: const Color(0XFF6E6BE8),
//                             //       ),
//                             //     ),
//                             //   ),
//                             //   onTap: () {
//                             //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResendOTP()));
//                             //   },
//                             // ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 1.w,
//                       ),
//                       ButtonTheme(
//                         minWidth: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             AuthCredential phoneAuthCredential =
//                             PhoneAuthProvider.credential(
//                                 verificationId: verificationId!,
//                                 smsCode: otp.toString());
//                             signInWithPhoneAuthCredential(
//                                 phoneAuthCredential);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: otpButton,
//                             elevation: 0,
//                             side: const BorderSide(
//                                 width: 1, color: Config.mainBorderColor),
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30.w, vertical: 5.w),
//                           ),
//                           child: Text(
//                             'Verify OTP',
//                             style: GoogleFonts.poppins(
//                               textStyle: TextStyle(
//                                   color: Config.primaryTextColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 10.sp),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10.w),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
