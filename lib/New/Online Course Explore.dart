import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:careercoach/Config.dart';
import 'package:careercoach/New/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Learn Assist/External Training Videos play.dart';
import '../Models/learnAssistModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import '../paymentScreen.dart';
import 'Online Course Explore play.dart';
import 'Payment.dart';

class OnlineCourseExplore extends StatefulWidget {
  final String courseId;
  final List purchasedCourses;
  const OnlineCourseExplore(
      {Key? key, required this.courseId, required this.purchasedCourses})
      : super(key: key);

  @override
  State<OnlineCourseExplore> createState() => _OnlineCourseExploreState();
}

class _OnlineCourseExploreState extends State<OnlineCourseExplore> {
  int selectedPage = 1;
  List<ExternalTrainingVideosModel> trainingVideosList = [];
  //Status = 1 <----------> for not purchased the course
  int status = 1;
  String? paymentStatus;
  var user_Id;

  Future getTrainingVideosDetails(from) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString('userId') ?? '';
    user_Id = userId;
    debugPrint("Printing the value of USER_ID: $userId");
    // final response = await http.get(Uri.parse('${Config.baseURL}listtrainingvideos/$from/5'));
    final response = await http
        .get(Uri.parse('${Config.baseURL}listchapters/${widget.courseId}'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["allchapters"];
      setState(() {
        trainingVideosList = jsonData
                .map<ExternalTrainingVideosModel>(
                    (data) => ExternalTrainingVideosModel.fromJson(data))
                .toList() ??
            [];
        // getQuestionPaperDetails(0);
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
    } else {
      debugPrint('get call error');
    }
    debugPrint("trainingVideosList : $trainingVideosList");
    // debugPrint("Service Details : $serviceDetails");
  }

  numberOfPages1() {
    double pgNum = trainingVideosList.length / 5;
    return pgNum.ceil();
  }

  pageList(page) {
    switch (page) {
      case 1:
        getTrainingVideosDetails(0);
        break;
      case 2:
        getTrainingVideosDetails(5);
        break;
      case 3:
        getTrainingVideosDetails(10);
        break;
      case 4:
        getTrainingVideosDetails(15);
        break;
      case 5:
        getTrainingVideosDetails(20);
        break;
      case 6:
        getTrainingVideosDetails(25);
        break;
      case 7:
        getTrainingVideosDetails(30);
        break;
      case 8:
        getTrainingVideosDetails(35);
        break;
      case 9:
        getTrainingVideosDetails(40);
        break;
      case 10:
        getTrainingVideosDetails(45);
        break;
      case 11:
        getTrainingVideosDetails(50);
        break;
      case 12:
        getTrainingVideosDetails(55);
        break;
      case 13:
        getTrainingVideosDetails(60);
        break;
      case 14:
        getTrainingVideosDetails(65);
        break;
      case 15:
        getTrainingVideosDetails(70);
        break;
      case 16:
        getTrainingVideosDetails(75);
        break;
      case 17:
        getTrainingVideosDetails(80);
        break;
      case 18:
        getTrainingVideosDetails(85);
        break;
      case 19:
        getTrainingVideosDetails(90);
        break;
      case 20:
        getTrainingVideosDetails(95);
        break;
      default:
        getTrainingVideosDetails(100);
    }
  }

  getPaymentStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    paymentStatus = await prefs.getString('status') ?? '';
    debugPrint("Printing paymentStatus:---------: ${paymentStatus} ");
  }

  @override
  void initState() {
    getPaymentStatus();
    debugPrint("Printing --- CourseId:: ${widget.courseId} ");
    // debugPrint("Printing paymentStatus:: ${paymentStatus} ");
    getTrainingVideosDetails(0);
    super.initState();
  }

  Future<bool> courseAlert() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            content: Container(
              width: 60.w,
              height: 5.h,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(''),
                      InkWell(
                        child: Icon(Icons.close_rounded),
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                      )
                    ],
                  ),
                  Text(
                    'To unlock this course',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: [
              Center(
                child: Container(
                  width: 20.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Color(0XFFCCCCCC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>));
                      //SystemNavigator.pop(animated: true);
                    },
                    child: const Text(
                      'Explore',
                      style: TextStyle(color: Color(0xff333333)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: App_Bar_widget(
            title: 'AutoCAD 2D',
          )),
      body: SafeArea(
        child: (trainingVideosList.isEmpty)
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Loading',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: Config.primaryTextColor,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    const CupertinoActivityIndicator(
                      radius: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            : ListView(
                children: [
                  //Topic and Brief
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Container(
                      width: 92.w,
                      height: 17.h,
                      decoration: BoxDecoration(
                          color: Color(0XFFFFDEB2),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Color(0XFFFFDEB2))),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 16, right: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'AutoCAD 2D\n',
                              style: TextStyle(
                                  fontSize: Config.font_size_12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Config.primaryTextColor),
                            ),
                            TextSpan(
                              text: 'About: ',
                              style: TextStyle(
                                  fontSize: Config.font_size_12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Config.primaryTextColor),
                            ),
                            TextSpan(
                              text: 'About: Lorem Ipsum is simply dummy '
                                  'text of the printing and typesetting '
                                  'industry. Lorem Ipsum has been the industry’s '
                                  'standard dummy text ever since the 1500s\n',
                              style: TextStyle(
                                  fontSize: Config.font_size_12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Config.primaryTextColor),
                            ),
                            TextSpan(
                              text: 'Course by: ',
                              style: TextStyle(
                                  fontSize: Config.font_size_12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Config.primaryTextColor),
                            ),
                            TextSpan(
                              text: 'DHYAN',
                              style: TextStyle(
                                  fontSize: Config.font_size_12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Config.primaryTextColor),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  //Course Content
                  /*ListView.builder(
              shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index){
              return InkWell(
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.h),
                  child: Container(
                    height: 11.9.h,
                    width: 92.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1,color: Config.mainBorderColor)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 2,right: 2, bottom: 2),
                          child: Container(
                            width: 45.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Course Content',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp
                                  ),),
                                SizedBox(height: 0.5.h,),
                                Text('Lorem Ipsum is simply dummy text of the '
                                    'printing and typesetting industry….',
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Config.primaryTextColor
                                  ),
                                ),
                                SizedBox(height: 0.5.h,),
                                Text('Duration: 10 Min',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0XFF999999)
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 34.1.w,height: 11.9.h,
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //       image: AssetImage('assets/images/demov_3.png'),
                          //   fit: BoxFit.fill)
                          // ),
                          child: Image.asset('assets/images/demov_3.png',fit: BoxFit.fill,),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ExploreVideosPlay()));
                },
              );
            }
            ),*/
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 1.h, left: 4.w, right: 4.w),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: trainingVideosList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: InkWell(
                              onTap: () {
                                (widget.purchasedCourses
                                        .contains(widget.courseId))
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ExploreVideosPlay(
                                            index1: index,
                                          ),
                                        ),
                                      )
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => PaymentCashFree(
                                              courseId: widget.courseId),
                                        ),
                                      );
                                (widget.purchasedCourses
                                        .contains(widget.courseId))
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ExploreVideosPlay(
                                            index1: index,
                                          ),
                                        ),
                                      )
                                    : null;
                                /*Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ExploreVideosPlay(
                                      index1: index,
                                      status: status,
                                    ),
                                  ),
                                );*/
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      width: 1, color: Color(0XFFF1F1F1)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 1.h, left: 2.w, bottom: 1.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 60.w,
                                            child: Text(
                                              trainingVideosList?[index]
                                                      .videoName
                                                      .toString() ??
                                                  '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize:
                                                      Config.font_size_12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      Config.primaryTextColor),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Date: ${trainingVideosList?[index].addedOn.toString()}" ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xff999999)),
                                              ),
                                              /*SizedBox(width: 15.w,),
                                        Text("Duration: ${trainingVideosList?[index].videoDuration.toString()}" ?? '',
                                          style: TextStyle(
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff999999)
                                          ),
                                        ),*/
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    (widget.purchasedCourses
                                            .contains(widget.courseId))
                                        ? Container(
                                            // width: 25.w,
                                            child: Image.network(
                                              "${Config.imageURL}${trainingVideosList?[index].videoThumbnail.toString()}",
                                              fit: BoxFit.fill,
                                              width: 25.w,
                                            ),
                                          )
                                        : Stack(
                                            children: [
                                              Container(
                                                // width: 25.w,
                                                child: Image.network(
                                                  "${Config.imageURL}${trainingVideosList?[index].videoThumbnail.toString()}",
                                                  fit: BoxFit.fill,
                                                  width: 25.w,
                                                ),
                                              ),
                                              (index == 0 || index == 1)
                                                  ? Container()
                                                  : Container(
                                                      width: 25.w,
                                                      // height: 5.h,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.5)
                                                          // border: Border.all(
                                                          //     width: 1,
                                                          //     color: Color(0XFFF1F1F1)),
                                                          ),
                                                      child: Center(
                                                        child: Image.asset(
                                                          "assets/images/videoLock.png",
                                                          alignment:
                                                              Alignment.center,
                                                          fit: BoxFit.fitHeight,
                                                          // width: 10.w,
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
      ),
      /*//Pagination
      bottomNavigationBar: BottomAppBar(
        child: PaginationWidget(
          numOfPages: numberOfPages1(),
          selectedPage: selectedPage,
          pagesVisible: 3,
          spacing: 0,
          onPageChanged: (page) {
            pageList(page);
            setState(() {
              selectedPage = page;
            });
          },
          nextIcon: Icon(
            Icons.arrow_forward_ios,
            size: 12,
            color: selectedPage == numberOfPages1()
                ? Colors.grey
                : Color(0xff000000),
          ),
          previousIcon: Icon(
            Icons.arrow_back_ios,
            size: 12,
            color: selectedPage == 1 ? Colors.grey : Color(0xff000000),
          ),
          activeTextStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
          activeBtnStyle: ButtonStyle(
            visualDensity: VisualDensity(horizontal: -4),
            backgroundColor: MaterialStateProperty.all(const Color(0xff8cb93d)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                // side: const BorderSide(
                //  // color: Color(0xfff1f1f1),
                //   width: 1,
                // ),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            // shadowColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff1f1f1),
            // ),
          ),
          inactiveBtnStyle: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            visualDensity: const VisualDensity(horizontal: 0),
            elevation: MaterialStateProperty.all(0),
            // backgroundColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff9f9fb),
            // ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          inactiveTextStyle: const TextStyle(
            fontSize: 15,
            color: Color(0xff333333),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),*/
    );
  }
}
