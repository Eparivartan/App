import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dotted_line/dotted_line.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_uuids/short_uuids.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import 'Config.dart';
import 'Models/payment.dart';
import 'New/Online Course Explore.dart';

class PaymentCashFree extends StatefulWidget {
  final String courseId;
  const PaymentCashFree({Key? key, required this.courseId}) : super(key: key);

  @override
  State<PaymentCashFree> createState() => _PaymentCashFreeState();
}

class _PaymentCashFreeState extends State<PaymentCashFree> {
  var cfPaymentGatewayService = CFPaymentGatewayService();
  String? quizdata;
  String? txStatus;
  var uniqueId = ShortUuid();
  var jsonData;

  Map? paymentResponse;
  Map<String, dynamic>? extractdata, responseRequest;
  var short = const ShortUuid();
  List<PaymentModel> paymentList = [];

  Future getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString('userId') ?? '';
    debugPrint("came with UserId to PROFILE_Pg : $userId");

    final response =
        await http.get(Uri.parse('${Config.baseURL}my-profile/$userId'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      // jsonData = jsonDecode(response.body)["profiledetails"];
      debugPrint("Printing data came in get call: ${jsonData}");
      debugPrint(
          "Printing data came in get call: ${jsonData['profiledetails']['profileName']}");
    } else {
      debugPrint('get call error');
    }
  }

  //POST CALL>>>>>>>>>>>>>>>>

  Future<void> orderDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString('userId') ?? '';
    debugPrint("CAME TO orderDetails PostTrail call");
    final url = Uri.parse(
        'https://psmprojects.net/cadworld/Home/createorder/endpoint.php');
    // final url = Uri.parse('${Config.baseURL}placeorder/endpoint.php');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': userId.toString(),
          "COURSE_ID": widget.courseId.toString(),
          "ORDER_ID": order_Id.toString(),
          'TRANSACTION_ID': transactionId.toString(),
          'ORDER_AMOUNT': orderAmount.toString(),
          'ORDER_STATUS': orderStatus.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Response Payment Post call data: ${response.body}');
      } else {
        print('Error - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending POST request: $error');
    }
  }

  @override
  void initState() {
    getProfileDetails();
    debugPrint("printing Got CourseId: ${widget.courseId}");
    super.initState();
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.careerCoachButtonColor,
        title: const Text('Payment'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0XFFFFE59B),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AutoCAD 2D',
                            style: TextStyle(
                                fontSize: 11.sp, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 70.w,
                            child: Text(
                              'To unlock the full course content subscribe'
                              ' to this course now!',
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                      Stack(children: [
                        Image.asset(
                          "assets/images/paymentbanner.png",
                          width: 75,
                          height: 75,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0, left: 12),
                          child: Text(
                            '₹499/-',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                decoration: const BoxDecoration(color: Config.containerColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'Course by: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                              color: Config.primaryTextColor),
                        ),
                        TextSpan(
                            text: 'ABC Limited',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Config.primaryTextColor))
                      ])),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 90.w,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Bill to:  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Config.font_size_12.sp,
                                color: Config.primaryTextColor),
                          ),
                          TextSpan(
                              text:
                                  '${jsonData?['profiledetails']['profileName'].toString() ?? ''} ',
                              style: TextStyle(
                                  fontSize: Config.font_size_12.sp,
                                  color: Config.primaryTextColor))
                        ])),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DottedLine(
                        dashLength: 2,
                        dashGapLength: 2,
                        lineThickness: 1,
                        dashColor: Color(0XFFE2E2E2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Charges:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                                color: Config.primaryTextColor),
                          ),
                          Text('₹499/-')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount Code:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                                color: Config.primaryTextColor),
                          ),
                          Text('₹49/-')
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 40.5.w,
                        height: 3.34.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Color(0XFFEBEBEB))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('CA23PEC15'),
                            Icon(
                              Icons.cancel,
                              color: Color(0XFFCCCCCC),
                              size: 15,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DottedLine(
                        dashLength: 2,
                        dashGapLength: 2,
                        lineThickness: 1,
                        dashColor: Color(0XFFE2E2E2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Net Payable Amount:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                                color: Config.primaryTextColor),
                          ),
                          Text(
                            '₹450/-',
                            style: TextStyle(fontSize: 11.sp),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Color(0XFF00000029),
                      blurRadius: 10.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Color(0XFF999999), width: 1)),
              child: TextButton(
                  // style: TextButton.styleFrom(
                  //   foregroundColor: Color(0xff8CB93D),
                  //   backgroundColor: Color(0xff8CB93D),
                  // ),
                  child: Text(
                    'Confirm & Pay ₹450/->>',
                    style: TextStyle(
                        fontSize: 12.sp, color: Config.primaryTextColor),
                  ),
                  onPressed: () {
                    String uniqueId = short.generate();
                    bookOrder('$uniqueId', '200.0', 'Sai', 'teja@gmail.com',
                        '7893841416', '0', '999', 'Dummy');
                  }),
              // TextButton(
              //   onPressed: () {
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(
              //         builder: (context) => PaymentCashFree()));
              //   },
              //   child: Text(
              //     'Confirm & Pay ₹450/->>',
              //     style: TextStyle(
              //         fontSize: 12.sp, color: Config.primaryTextColor),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  bookOrder(
      String orderId,
      String orderAmount,
      String customerName,
      String customerEmail,
      String customerMobile,
      String courseId,
      String userId,
      String courseTitle) async {
    debugPrint("Its ORDER ID : " + orderId);
    debugPrint("Its ORDER AMOUNT : " + orderAmount);
    debugPrint("Its CUSTOMER NAME : " + customerName);
    debugPrint("Its CUSTOMER EMAIL : " + customerEmail);
    debugPrint("ITS CUSTOMER MOBILE : " + customerMobile);

    var body = json.encode({
      "order_id": orderId,
      "order_amount": orderAmount,
      "order_currency": "INR",
      "order_note": "Additional order info",
      "customer_details": {
        "customer_id": "7893841416",
        "customer_name": "Gnana Sai",
        "customer_email": "sairatna1199@gmail.com",
        "customer_phone": "7893841416"
      }
    });
    responseRequest = {
      'orderId': orderId,
      'orderAmount': orderAmount,
      'orderCurrency': "INR"
    };
    Map<String, String> headers = {
      'x-client-id': 'TEST10067466d4b7841c52925f8854f266476001',
      'x-client-secret': 'TEST75b51125c7e970e18cf08be6a34b8e2bc353cc4a',
      'x-api-version': '2022-09-01',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.post(
      Uri.parse('https://sandbox.cashfree.com/pg/orders'),
      headers: headers,
      body: body,
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      debugPrint(response.body);
      debugPrint(jsonDecode(response.body)["payment_session_id"]);
      var value = jsonDecode(response.body);
      debugPrint("session : ${value["payment_session_id"]}");
      Lottie.asset("assets/lotties/payment-successful.json");

      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(jsonDecode(response.body)["payment_session_id"])
          .build();
      List<CFPaymentModes> components = <CFPaymentModes>[
        CFPaymentModes.CARD,
        CFPaymentModes.UPI,
        CFPaymentModes.WALLET,
        CFPaymentModes.NETBANKING,
        CFPaymentModes.PAYLATER,
        CFPaymentModes.EMI
      ];
      var paymentComponent =
          CFPaymentComponentBuilder().setComponents(components).build();

      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#8CB93D")
          .setPrimaryFont("Menlo")
          .setSecondaryFont("Futura")
          .build();
      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();
      await cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
      // print(e.message);
    } else {
      debugPrint(response.body);
      //displayDialog(context, "Error", "An unknown error occurred.");
    }
  }

  AlertDialog() {
    Container(child: Lottie.asset("assets/lotties/payment-successful.json"));
  }

  void verifyPayment(String orderId) async {
    print("Verify Payment $orderId");

    final response = await http.get(
        Uri.parse('https://sandbox.cashfree.com/pg/orders/$orderId'),
        headers: {
          'x-client-id': 'TEST10067466d4b7841c52925f8854f266476001',
          'x-client-secret': 'TEST75b51125c7e970e18cf08be6a34b8e2bc353cc4a',
          'x-api-version': '2022-09-01',
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    try {
      if (response.statusCode == 200) {
        debugPrint(response.body);
        debugPrint("printing Success :- ${response.body}");
        paymentStatus(orderId, "dy");
        return AlertDialog();
      }
    } catch (e) {
      debugPrint('e');
    }
  }

  AlertDialog1() {
    Container(child: Lottie.asset("assets/lotties/error.json"));
  }

  void onError(CFErrorResponse errorResponse, String orderId) async {
    print(errorResponse.getMessage());
    print("Error while making payment");

    final response = await http.get(
        Uri.parse('https://sandbox.cashfree.com/pg/orders/$orderId'),
        headers: {
          'x-client-id': 'TEST10067466d4b7841c52925f8854f266476001',
          'x-client-secret': 'TEST75b51125c7e970e18cf08be6a34b8e2bc353cc4a',
          'x-api-version': '2022-09-01',
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    try {
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return AlertDialog1();
      }
    } catch (e) {
      debugPrint("e");
    }
  }

  var paymentData; //userId`, `courseId`, `transactionId`, `orderAmount`, `orderStatus`, `purchaseDate`
  var transactionId;
  var order_Id;
  var orderAmount;
  var orderStatus;

  void paymentStatus(String orderId, String payments) async {
    print("Payment Status $payments");

    final response = await http.get(
        Uri.parse('https://sandbox.cashfree.com/pg/orders/$orderId/payments'),
        headers: {
          'x-client-id': 'TEST10067466d4b7841c52925f8854f266476001',
          'x-client-secret': 'TEST75b51125c7e970e18cf08be6a34b8e2bc353cc4a',
          'x-api-version': '2022-09-01',
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    try {
      if (response.statusCode == 200) {
        debugPrint(response.body);
        debugPrint(
            "printing the value of the payment details :${response.body}");

        orderDetails();
        paymentData = jsonDecode(response.body);
        transactionId = paymentData[0]["cf_payment_id"];
        order_Id = paymentData[0]["order_id"];
        orderAmount = paymentData[0]["payment_amount"];
        orderStatus = paymentData[0]["payment_status"];

        // debugPrint("printing Success transaction Data0:- ${paymentData}");
        // debugPrint(
        //     "printing Success cf_payment_id :- ${paymentData[0]["cf_payment_id"]}");
        // debugPrint(
        //     "printing Success payment_amount :- ${paymentData[0]["payment_amount"]}");
        // debugPrint("printing Success order_id:- ${paymentData[0]["order_id"]}");
        // debugPrint("printing Success transaction Data0:- ${paymentData}");
        // debugPrint("printing Success transaction Data1:- ${paymentList}");
        // debugPrint("printing Success transaction Data:- ${paymentData}");
        // debugPrint("printing Success transaction Data:- ${paymentData.length}");
        // debugPrint(
        //     "printing Success transaction Data:- ${paymentData.runtimeType}");
        // var id =
        AlertDialog();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("status", "2");
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (BuildContext context) =>
        //         OnlineCourseExplore(courseId: widget.courseId)));
      }
    } catch (e) {
      debugPrint("Catch e");
    }
  }

  String orderId = "121";
  String paymentSessionId =
      "session_uqHIFgC_FFSLCIW1NLcT3UY9GVqpiI18oh7xDOLq7qbVMUoK1jqIq0MKTt1VflYsCXC3oZc9-XL6gFYmHmK3jKETobhHT7SHMFGKXqwMdEwa"
      ""
      "";
  CFEnvironment environment = CFEnvironment.SANDBOX;

  CFSession? createSession() {
    try {
      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      return session;
    } on CFException catch (e) {
      print(e.message);
    }
    return null;
  }
}
