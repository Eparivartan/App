import 'dart:async';

import 'package:careercoach/Widgets/App_Bar_Widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Config.dart';
import 'Payment Success.dart';

class PaymentGateway extends StatefulWidget {
  const PaymentGateway({Key? key}) : super(key: key);

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => PaymentSuccessful())));
    return Scaffold(
      backgroundColor: Config.whiteColor,
      appBar: PreferredSize(preferredSize: Size.fromHeight(6.h),
      child: App_Bar_widget(title: 'AutoCAD 2D',)),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text("Payment gateway",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
