import 'package:careercoach/Config.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/App_Bar_Widget.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: App_Bar_widget(title: 'AutoCAD 2D',)
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                  child: Container(
                    height: 25.h,
                    decoration: BoxDecoration(
                        color: Color(0XFFFFE59B),
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Text('Successful',
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                          SizedBox(height: 3,),
                          Container(
                            width: 80.w,
                            child: Text(
                              'Your subscription / order for “AutoCAD” is received, '
                                  'please access this course under',style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal
                            ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('My Subscriptions',
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Color(0xff1F5FD9),
                              decoration: TextDecoration.underline
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(''),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Color(0xff999999),
                                    elevation: 2,
                                    side: BorderSide(color: Color(0xff999999)),
                                    backgroundColor: Colors.white
                                  ),
                                  child: Text('Launch Course >>',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Config.primaryTextColor
                                  ),),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
