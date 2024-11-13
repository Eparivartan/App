import 'dart:convert';
import 'package:careercoach/Home%20Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';

class CodesAndStandardsDec extends StatefulWidget {
  final String? title, content;
  final String? subtitle;
  final String? paragraph1;
  final String? paragraph2;
  final String? adspace;

  const CodesAndStandardsDec({
    Key? key,
    this.title,
    this.subtitle,
    this.paragraph1,
    this.paragraph2,
    this.adspace,
    this.content,
  }) : super(key: key);

  @override
  State<CodesAndStandardsDec> createState() => _CodesAndStandardsDecState();
}

class _CodesAndStandardsDecState extends State<CodesAndStandardsDec>
    with SingleTickerProviderStateMixin {
  String? heading0;
  String? heading1;
  String? mainheading;
  String? logo;
  String? firstpara1;
  String? secondpara1;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/Codes&StdsDec.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      heading0 = jsonMap['head0'];
      heading1 = jsonMap["head1"];
      mainheading = jsonMap["mainhead"];
      logo = jsonMap["logoo"];
      firstpara1 = jsonMap["firstpara"];
      secondpara1 = jsonMap["secondpara"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Config.whiteColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: AppBar(
            elevation: 0,
            backgroundColor: Config.containerColor,
            leadingWidth: 85,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: InkWell(
                child: Image.asset(
                  'assets/images/pg12-1.png',
                  height: 6.1.h,
                  width: 22.6.w,
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                    child: Text('Codes and Standards',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Config.primaryTextColor))),
              ),
            ],
          )),
      body: SafeArea(
        child: (mainheading == null)
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Container(
                    width: 100.w,
                    height: 3.5.h,
                    decoration: const BoxDecoration(color: Color(0xffF1F1F1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  ${content}  ${title}
                        Padding(
                          padding: EdgeInsets.only(left: 3.w, right: 3.w),
                          child: Text(
                            '  All About Engineering / Codes and Standards / ${widget.title}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                                color: Config.pathColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 8.0, left: 4.w, right: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.w),
                        Text(
                          widget.title ?? '',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          widget.content ?? '',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
