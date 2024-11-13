import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Config.dart';

class Description_Page_Widget extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? paragraph1;
  final String? paragraph2;
  final String? adspace;

  const Description_Page_Widget(
      { Key? key,
        this.title,
        this.subtitle,
        this.paragraph1,
        this.paragraph2,
        this.adspace})
      : super(key: key);

  @override
  State<Description_Page_Widget> createState() => _Description_Page_WidgetState();
}

class _Description_Page_WidgetState extends State<Description_Page_Widget> {
  String? title;
  String? subtitle;
  String? paragraph1;
  String? paragraph2;
  String? adspace;


  @override
  Widget build(BuildContext context) {
    return ListView(
          children: [
            Container(
              color: Config.containerColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/pg12-1.png',
                      width: 20.w,
                      // height: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(title ?? '',
                          style: TextStyle(
                              fontSize: 10.sp,color: Config.primaryTextColor
                          )),
                        Text(subtitle ?? '',
                          style:GoogleFonts.poppins(textStyle: TextStyle(
                              fontSize: 10.sp,color: Config.primaryTextColor
                          ),),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 85.h,
              width: 100.w,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.w),
                      Text(subtitle ?? '',textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ))),
                      SizedBox(height: 1.w),
                      Text(paragraph1 ?? '',
                        style:GoogleFonts.poppins(textStyle: TextStyle(
                            fontSize: 10.sp
                        ))),
                      SizedBox(height: 3.w),
                      //AD Space
                      Container(
                        color: Config.containerColor,
                        height: 13.5.h,
                        width: 90.w,
                        child: Center(
                          child: Text("Ad Space",textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffE8E4F0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.w),
                      Text(paragraph2 ?? '',
                        style:GoogleFonts.poppins(textStyle: TextStyle(
                            fontSize: 10.sp
                        ),
                      ),),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
  }
}
