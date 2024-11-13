import 'dart:async';
import 'dart:convert';
import 'package:careercoach/Config.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Home Page.dart';
import '../../Successfully Logged In.dart';
import '../../random password generator.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  String country = '+91 ';
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  Color otpButton = Colors.white;
  String? mobile;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;
  int userCount = 0;
  bool showLoading = false;
  String? value;
  bool loggedin = false;
  bool _btnEnabled = false;
  bool onPressedValue = true;
  bool otpsucss = true;
  bool valueCheck = true;
  bool terms = true;
  String userId = '';

  static const _timerDuration = 30;
  final StreamController _timerStream = StreamController<int>();
  int? timerCounter;
  Timer? _resendCodeTimer;

  Future login(String MOBILE_NUMBER) async {
    final response =
        await http.post(Uri.parse(Config.baseURL + 'register'), headers: {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    }, body: {
      'MOBILE_NUMBER': MOBILE_NUMBER,
    });
    try {
      if (response.statusCode == 200) {
        debugPrint("Hello printing body:" + response.body);
        var cameData = jsonDecode(response.body);
        debugPrint(
            "Profile Details profId:: ++ ${cameData['profiledet']['userId']}");
        userId = ("${cameData['profiledet']['userId']}");
        debugPrint("!!!!!!!!?? ${cameData}");
        debugPrint("!!!!!!!!?? ${userId}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await SharedPreferencesHelper.setMobileNumber(MOBILE_NUMBER);
      await SharedPreferencesHelper.setUserId(userId);
      } else if (response.statusCode == 401) {
        debugPrint(response.body);
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "User Doesn't Exist!!!",
                  ),
                  content: const Text(
                      "Some technical error occurred. Please try again after some time."),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    )
                  ],
                ));
      }
    } catch (e) {
      print(e);
    }
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  void initState() {
    activeCounter();
    super.initState();
  }

  @override
  dispose() {
    _timerStream.close();
    _resendCodeTimer?.cancel();
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  activeCounter() {
    _resendCodeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_timerDuration - timer.tick > 0) {
        _timerStream.sink.add(_timerDuration - timer.tick);
      } else {
        _timerStream.sink.add(0);
        _resendCodeTimer!.cancel();
      }
    });
  }

  final String _generatedPassword =
      generatePassword(true, true, true, false, 10);

  void signInWithPhoneAuthCredential(AuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _generatedPassword = prefs.getString('') ?? '';

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoggedIn(userid: "${userId}")));
      }
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        content: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: 'Invalid OTP',
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '  Verification Failed...',
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0XFF78C111),
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        backgroundColor: Colors.white,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        showLoading = false;
      });
    }
  }

  void verifyPhoneNumber() async {
    setState(() {
      showLoading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: country + phoneController.text,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) async {
        setState(() {
          showLoading = false;
        });
        signInWithPhoneAuthCredential(phoneAuthCredential);
      },
      verificationFailed: (verificationFailed) async {
        setState(() {
          showLoading = false;
        });
        Fluttertoast.showToast(
            msg: verificationFailed.message ?? 'Verification failed');
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          showLoading = false;
          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          otpButton = Colors.white;
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        setState(() {
          this.verificationId = verificationId;
          showLoading = false;
          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
        });
      },
    );
  }

  DateTime timeBackPressed = DateTime.now();

  mobileFormWidget(context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          final message = "Press back again to exit";
          Fluttertoast.showToast(msg: message, fontSize: 18);

          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color(0xff8CB93D),
          body: SafeArea(
            child: ListView(
              children: [
                // IMAGE
                Container(
                  height: 32.h,
                  child: Image.asset('assets/images/loginPg.png',
                      height: 29.h, width: 77.w),
                ),
                SizedBox(
                  height: 2.h,
                ),
                // Phone Number CONTAINER
                Center(
                  child: Container(
                    height: 62.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 3.h),
                        Text(
                          'OTP Verification',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: Config.primaryTextColor),
                        ),
                        SizedBox(height: 13.h),
                        Text(
                          "Please enter mobile number to receive\nOne Time Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.sp,
                              color: Config.primaryTextColor),
                        ),
                        SizedBox(height: 3.h),
                        // TEXT FORM FIELD
                        Container(
                          height: 5.h,
                          width: 72.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 1, color: const Color(0xff999999))),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: Colors.black,
                            controller: phoneController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(13),
                              hintText: "Enter 10 digit mobile number",
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.length == 10 && terms == true) {
                                FocusScope.of(context).nextFocus();
                                setState(() {
                                  _btnEnabled = true;
                                  otpButton = Config.containerGreenColor;
                                });
                              } else {
                                setState(() {
                                  _btnEnabled = false;
                                  otpButton = Config.whiteColor;
                                });
                              }
                              setState(() {
                                mobile = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        // GET OTP BUTTON
                        Container(
                          height: 5.h,
                          width: 36.w,
                          decoration: BoxDecoration(
                              color: otpButton,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xffcccccc), width: 1)),
                          child: TextButton(
                            onPressed: mobile?.length == 10 && terms == true
                                ? () async {
                                    if (phoneController.text.isNotEmpty) {
                                      FocusScope.of(context).nextFocus();
                                      login(phoneController.text);
                                    } else {
                                      debugPrint(
                                          "Please provide valid value....");
                                    }

                                    debugPrint(
                                        'Hello : ${phoneController.text}');
                                    setState(
                                      () {
                                        showLoading = true;
                                      },
                                    );
                                    verifyPhoneNumber();
                                  }
                                : () {},
                            child: Text(
                              'Get OTP',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        // TERMS AND CONDITIONS CHECK BOX
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                                checkColor: Colors.black,
                                focusColor: Colors.lightBlue,
                                activeColor: Colors.white,
                                value: terms,
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                      width: 1.0, color: Colors.black),
                                ),
                                onChanged: (newValue) {
                                  if (terms == false && mobile?.length == 10) {
                                    setState(() {
                                      _btnEnabled = false;
                                      otpButton = Config.containerGreenColor;
                                    });
                                  } else {
                                    setState(() {
                                      _btnEnabled = true;
                                      otpButton = Config.whiteColor;
                                    });
                                  }
                                  setState(() => terms = newValue!);
                                }),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'I Agree to the ',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                                TextSpan(
                                    text: 'Terms of use ',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var url = "https://link/tandc.html";
                                        try {
                                          await launch(url);
                                        } catch (e) {
                                          rethrow;
                                        }
                                      },
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff1D7c98),
                                        decoration: TextDecoration.underline)),
                                TextSpan(
                                    text: ' & ',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                                TextSpan(
                                    text: 'Privacy ',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var url = "https://link/tandc.html";
                                        try {
                                          await launch(url);
                                        } catch (e) {
                                          rethrow;
                                        }
                                      },
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                                TextSpan(
                                    text: 'Policy ',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var url = "https://link/tandc.html";
                                        try {
                                          await launch(url);
                                        } catch (e) {
                                          rethrow;
                                        }
                                      },
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff1D7C98),
                                        decoration: TextDecoration.underline))
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool showError = false;
  String? otp;
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 40,
    height: 40,
    textStyle: const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xff999999)),
    ),
  );
  Color borderColor = const Color(0xff999999);
  Color errorColor = Colors.red;
  Color fillColor = Colors.white;

  otpFormWidget(context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xff8CB93D),
        body: SafeArea(
          child: Center(
            child: ListView(
              children: [
                Container(
                  height: 32.h,
                  child: Image.asset('assets/images/loginPg.png',
                      height: 29.h, width: 77.w),
                ),
                SizedBox(
                  height: 2.h,
                ),
                // OTP CONTAINER
                Center(
                  child: Container(
                    height: 62.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 3.h),
                        Text(
                          'OTP Verification',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: Config.primaryTextColor),
                        ),
                        SizedBox(height: 13.h),
                        Text(
                          "Enter the OTP sent to",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.sp,
                              color: Config.primaryTextColor),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          "$mobile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: Config.primaryTextColor),
                        ),
                        SizedBox(height: 3.h),
                        // OTP PIN INPUT FIELD
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 18.0),
                          child: SizedBox(
                            height: 55,
                            child: Pinput(
                              length: 6,
                              controller: controller,
                              focusNode: focusNode,
                              defaultPinTheme: defaultPinTheme,
                              onCompleted: (pin) {
                                otp = pin;

                                if (otp?.length == 6 &&
                                    verificationId != null) {
                                  AuthCredential phoneAuthCredential =
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId!,
                                          smsCode: otp.toString());

                                  signInWithPhoneAuthCredential(
                                      phoneAuthCredential);
                                } else {
                                  setState(() {
                                    otpButton = Config.whiteColor;
                                  });
                                }
                              },
                              focusedPinTheme: defaultPinTheme.copyWith(
                                height: 68,
                                width: 64,
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  border: Border.all(
                                      color: const Color(0xff999999)),
                                ),
                              ),
                              errorPinTheme: defaultPinTheme.copyWith(
                                decoration: BoxDecoration(
                                  color: errorColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        // VERIFY OTP BUTTON
                        Container(
                          height: 6.h,
                          width: 36.w,
                          decoration: BoxDecoration(
                              color: otpButton,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Config.mainBorderColor, width: 1)),
                          child: TextButton(
                            onPressed: otp?.length == 6
                                ? () async {
                                    if (otp?.length == 6) {
                                      AuthCredential phoneAuthCredential =
                                          PhoneAuthProvider.credential(
                                              verificationId: verificationId!,
                                              smsCode: otp.toString());
                                      signInWithPhoneAuthCredential(
                                          phoneAuthCredential);
                                      setState(() {
                                        _btnEnabled = false;
                                        otpButton = Config.containerGreenColor;
                                      });
                                    } else {
                                      setState(() {
                                        _btnEnabled = true;
                                        otpButton = Config.whiteColor;
                                      });
                                    }
                                  }
                                : () {
                                    CircularProgressIndicator();
                                  },
                            child: Text(
                              'Verify OTP',
                              style: TextStyle(
                                  color: Config.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        // RESEND OTP
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Didn\'t receive OTP? ',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black)),
                              SizedBox(width: 2.w),
                              InkWell(
                                  child: Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                        color: const Color(0xff6E6BE8),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onTap: () async {
                                    controller.clear();
                                    verifyPhoneNumber();
                                  }),
                            ]),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.whiteColor,
      body: showLoading
          ? const Center(
              child: CupertinoActivityIndicator(
                radius: 25,
                color: Colors.black,
              ),
            )
          : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? mobileFormWidget(context)
              : otpFormWidget(context),
    );
  }
}
