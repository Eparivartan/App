import 'dart:convert';

import 'package:careercoach/Models/collegeInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';

class OurRecommendations extends StatefulWidget {
  List<CollegeSearchResultModel> recommendedColleges;
  OurRecommendations({Key? key, required this.recommendedColleges}) : super(key: key);

  @override
  State<OurRecommendations> createState() => _OurRecommendationsState();
}

class _OurRecommendationsState extends State<OurRecommendations> {

  List? info;
  String? Title;
 // String? sub;
  String? Title1;
  String? Data1;
  String? Title2;
  String? Data2;
  String? Title3;
  String? Data3;
  String? Title4;
  String? Data4;
  String? Title5;
  String? Data5;
  String? Title6;
  String? Data6;
  // String? Img;
  // String? Timg;
  // String? Pic;
  // String? Nos;
  // String? Mail;
  // String? Call;
  // String? Mailing;
  // String? Contact;

  @override
  void initState(){
    debugPrint("Printing::Our Recommendations : ${widget.recommendedColleges}");
    loadJson();
    super.initState();
  }

  Future loadJson() async{
    String jsonString = await rootBundle.loadString('assets/files/ourRecommendation.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      info = jsonMap["info"];
      Title = jsonMap['title'];
     // sub = jsonMap['sub'];
      Title1 = jsonMap['title1'];
      Data1 = jsonMap['data1'];
      Title2 =jsonMap['title2'];
      Data2 = jsonMap['data2'];
      Title3 = jsonMap['title3'];
      Data3 = jsonMap['data3'];
      Title4 = jsonMap['title4'];
      Data4 = jsonMap['data4'];
      Title5 = jsonMap['title5'];
      Data5 = jsonMap['data5'];
      Title6 = jsonMap['title6'];
      Data6 = jsonMap['data6'];


      // Img = jsonMap['img'];
      // Timg = jsonMap['timg'];
      // Pic = jsonMap['pic'];
      // Mail = jsonMap['mail'];
      // Call = jsonMap['call'];
      // Mailing = jsonMap['mailing'];
      // Contact = jsonMap['contact'];
      // Nos = jsonMap['nos'];

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.3.h),
        child: App_Bar_widget1(title: 'Educational Institutions / \n University courses'),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: ListView(
          children: [
            Image.asset('assets/images/collegeInformation.png',),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Padding(
                 padding: const EdgeInsets.only(left: 15,top: 17,bottom: 20),
                 child: Text('CAD Career Coach Recommendations',
                 style: TextStyle(
                   fontSize: 14.sp,
                   fontWeight: FontWeight.bold,
                 ),
                 ),
               ),
                ListView.builder(
                    itemCount: widget.recommendedColleges.length?? 0,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 10,top: 5,right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1, color: Colors.grey.shade100),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              collapsedBackgroundColor: Colors.white,
                              backgroundColor: const Color(0xfff9f9fb),
                              iconColor: const Color(0xff333333),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.recommendedColleges[index].collegeName ?? '',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff333333),
                                    ),
                                  ),
                                  // SizedBox(height: 5,),
                                  // Text(info?[index]["sub"] ?? '',
                                  //   style: TextStyle(
                                  //     fontSize: 11.sp,
                                  //     // fontWeight: FontWeight.bold,
                                  //     color: const Color(0xff333333),
                                  //   ),
                                  // ),
                                ],
                              ),
                              children: [
                                Divider(
                                  color: Color(0xfff1f1f1),
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 18),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              info?[index]["title1"] ?? '',
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              "${widget.recommendedColleges[index].collegeCode}" ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Container(
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              info?[index]["title2"] ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              "${widget.recommendedColleges[index].collegeBranches}" ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Container(
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              info?[index]["title3"] ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              "${widget.recommendedColleges[index].affiliatedTo}" ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Container(
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              info?[index]["title4"] ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              "${widget.recommendedColleges[index].collegeAddress}" ?? '',
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Container(
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              info?[index]["title5"] ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              "${widget.recommendedColleges[index].collegeContactno}" ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Container(
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              info?[index]["title6"] ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.black)
                                            ),
                                            child: Text(
                                              "${widget.recommendedColleges[index].collegeEmailId}" ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(0xff333333),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
