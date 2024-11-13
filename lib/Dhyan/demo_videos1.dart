import 'dart:convert';
import 'package:careercoach/Dhyan/demo.dart';
import 'package:careercoach/Dhyan/demoi1.dart';
import 'package:careercoach/Home%20Page.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Models/learnAssistModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'package:http/http.dart' as http;
import 'demo_video_play.dart';
import 'demo_videos2.dart';

class DemoVideo extends StatefulWidget {
  const DemoVideo({Key? key}) : super(key: key);

  @override
  State<DemoVideo> createState() => _DemoVideoState();
}

class _DemoVideoState extends State<DemoVideo> {
  static const double dataPagerHeight = 70.0;

  List? details;
  String? Demo;
  String? Img;
  String? Timg;
  String? Pic;
  String? userId;
  List<ExternalTrainingVideosModel> dhyanVideosList = [];

  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  numberOfPages1() {
    double pgNum = dhyanVideosList.length / 5;
    return pgNum.ceil();
  }

  bool colorBool = false;

  Future<void> postFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);

    print(userId.toString());
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postmyfavourite/endpoint.php');
    print(url.toString());

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': userId.toString(),
          'PATH': jsonEncode({
            'ROOT1': "Dhyan Course Demo Vedios",
          }),
        },
      );
      print(response.toString());
      print(response.body.toString());
      print(response.statusCode.toString());

      if (response.statusCode == 200) {
        colorBool = true;
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Success!!",
                  ),
                  content: const Text("Added to Favorite's successfully!!"),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Config.careerCoachButtonColor),
                      //return false when click on "NO"
                      child: const Text('OK'),
                    ),
                  ],
                ));
        print('Response data: ${response.body}');
      } else {
        print('Error - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending POST request: $error');
    }
  }

  Future getDhyanVideosListDetails(from) async {
    final response =
        await http.get(Uri.parse('${Config.baseURL}listdemovideos/$from/5'));

    print(response.toString());
    // https://psmprojects.net/cadworld/listdemovideos/0/5
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["demovideos"];

      print(jsonData.toString() + '>>>>>>>>>>>>>>>>>>');
      setState(() {
        dhyanVideosList = jsonData
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
    debugPrint("dhyanVideosList : $dhyanVideosList");
    // debugPrint("Service Details : $serviceDetails");
  }

  pageList(page) {
    switch (page) {
      case 1:
        getDhyanVideosListDetails(0);
        break;
      case 2:
        getDhyanVideosListDetails(5);
        break;
      case 3:
        getDhyanVideosListDetails(10);
        break;
      case 4:
        getDhyanVideosListDetails(15);
        break;
      case 5:
        getDhyanVideosListDetails(20);
        break;
      case 6:
        getDhyanVideosListDetails(25);
        break;
      case 7:
        getDhyanVideosListDetails(30);
        break;
      case 8:
        getDhyanVideosListDetails(35);
        break;
      case 9:
        getDhyanVideosListDetails(40);
        break;
      case 10:
        getDhyanVideosListDetails(45);
        break;
      case 11:
        getDhyanVideosListDetails(50);
        break;
      case 12:
        getDhyanVideosListDetails(55);
        break;
      case 13:
        getDhyanVideosListDetails(60);
        break;
      case 14:
        getDhyanVideosListDetails(65);
        break;
      case 15:
        getDhyanVideosListDetails(70);
        break;
      case 16:
        getDhyanVideosListDetails(75);
        break;
      case 17:
        getDhyanVideosListDetails(80);
        break;
      case 18:
        getDhyanVideosListDetails(85);
        break;
      case 19:
        getDhyanVideosListDetails(90);
        break;
      case 20:
        getDhyanVideosListDetails(95);
        break;
      default:
        getDhyanVideosListDetails(100);
    }
  }

  @override
  void initState() {
    loadJson();

    getDhyanVideosListDetails(0);
    super.initState();
  }

  String? vedio;
  String? duration;
  String? date;
  String? name;

  Future loadJson() async {
    String jsonString = await rootBundle.loadString('assets/files/demo.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      details = jsonMap["Demo"];
      Img = jsonMap['img'];
      Timg = jsonMap['timg'];
      Pic = jsonMap['pic'];
      print(details);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.3.h),
          child: AppBar(
            elevation: 0,
            backgroundColor: Config.containerColor,
            leadingWidth: 85,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: InkWell(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 6.1.h,
                  width: 22.6.w,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            actions: [
              Center(
                child: Image.asset(
                  'assets/images/dhyanacademy-logo.png',
                  height: 6.h,
                  width: 30.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 17),
                child: InkWell(
                  onTap: () {
                    postFavourite();
                  },
                  child: Icon(
                    Icons.star_border,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ],
          )),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (dhyanVideosList.isEmpty)
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
                  Center(
                    child: Container(
                      // height: MediaQuery.of(context).size.height,
                      // width: MediaQuery.of(context).size.width,
                      child: Column(
                        verticalDirection: VerticalDirection.down,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            Pic ?? '',
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.w,
                              top: 2.h,
                            ),
                            child: Text(
                              'Demo Videos',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 1.h, left: 1.w, right: 1.w),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: dhyanVideosList?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 1.h),
                                    child: InkWell(
                                      onTap: () {
                                        print(dhyanVideosList?[index]
                                            .videoName
                                            .toString());
                                        print(
                                            "Duration: ${dhyanVideosList?[index].videoDuration.toString()}" ??
                                                '');
                                        print("test");
                                        print(
                                            "${dhyanVideosList?[index].videoEmbed.toString()}");
                                        setState(() {
                                          vedio =
                                              "${dhyanVideosList?[index].videoEmbed.toString()}";
                                          name =
                                              "${dhyanVideosList?[index].videoName.toString()}";
                                          date =
                                              "${dhyanVideosList?[index].addedOn.toString()}";
                                          duration =
                                              "${dhyanVideosList?[index].videoDuration.toString()}";
                                        });
                                        print(vedio.toString());

                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) => VHM(
                                        //             index1: index,
                                        //             Id: vedio.toString(),
                                        //             vedioname: name.toString(),
                                        //             vediodate: date.toString(),
                                        //             vedioduration:
                                        //                 duration.toString())));

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoListScreen()));

                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             DemoVideoPlay(
                                        //                 index1: index)));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0XFFF1F1F1)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 1.h,
                                                  left: 2.w,
                                                  bottom: 1.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  //Title
                                                  Container(
                                                    width: 60.w,
                                                    child: Text(
                                                      dhyanVideosList?[index]
                                                              .videoName
                                                              .toString() ??
                                                          '',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                              .font_size_12.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Config
                                                              .primaryTextColor),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  //Date and Duration
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Date: ${dhyanVideosList?[index].addedOn.toString()}" ??
                                                            '',
                                                        style: TextStyle(
                                                            fontSize: 8.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Color(
                                                                0xff999999)),
                                                      ),
                                                      SizedBox(
                                                        width: 13.w,
                                                      ),
                                                      Text(
                                                        "Duration: ${dhyanVideosList?[index].videoDuration.toString()}" ??
                                                            '',
                                                        style: TextStyle(
                                                            fontSize: 8.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Color(
                                                                0xff999999)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // width: 25.w,
                                              child: Image.network(
                                                "${Config.imageURL}${dhyanVideosList?[index].videoThumbnail.toString()}",
                                                fit: BoxFit.fill,
                                                width: 25.w,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(bottom: 1.h, left: 1.w, right: 1.w),
                          //   child: ListView.builder(
                          //       shrinkWrap: true,
                          //       physics: const ClampingScrollPhysics(),
                          //       itemCount: 2,
                          //       itemBuilder: (context, index)
                          //       {
                          //         return Padding(
                          //           padding: EdgeInsets.only(top: 1.h),
                          //           child: InkWell(
                          //             onTap: () {
                          //               Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DemoVideoPlay(index1: index)));
                          //             },
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                 borderRadius: BorderRadius.circular(7),
                          //                 border: Border.all(width: 1,color: Color(0XFFF1F1F1)),
                          //               ),
                          //               child: Row(
                          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Padding(
                          //                     padding: EdgeInsets.only(top: 1.h, left: 2.w, bottom: 1.h),
                          //                     child: Column(
                          //                       crossAxisAlignment: CrossAxisAlignment.start,
                          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                       children: [
                          //                         //Title
                          //                         Container(
                          //                           width: 60.w,
                          //                           child: Text("AutoCAD 2D v1 : Demo Class 1" ?? '',
                          //                             overflow: TextOverflow.ellipsis,
                          //                             maxLines: 2,
                          //                             style: TextStyle(
                          //                                 fontSize: Config.font_size_12.sp,
                          //                                 fontWeight: FontWeight.bold,
                          //                                 color: Config.primaryTextColor
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         SizedBox(height: 2.h,),
                          //                         //Date and Duration
                          //                         Row(
                          //                           children: [
                          //                             Text("Date: " ?? '',
                          //                               style: TextStyle(
                          //                                   fontSize: 8.sp,
                          //                                   fontWeight: FontWeight.normal,
                          //                                   color: Color(0xff999999)
                          //                               ),
                          //                             ),
                          //                             SizedBox(width: 15.w,),
                          //                             Text("Duration: " ?? '',
                          //                               style: TextStyle(
                          //                                   fontSize: 8.sp,
                          //                                   fontWeight: FontWeight.normal,
                          //                                   color: Color(0xff999999)
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                   Container(
                          //                     width: 25.w,
                          //                     child:
                          //                     Image.asset(Pic ?? '',fit: BoxFit.fitHeight, height: 8.h,),
                          //                     // Image.network("${Config.imageURL}${dhyanVideosList?[index].videoThumbnail.toString()}",
                          //                     //   fit: BoxFit.fill,
                          //                     //   width: 25.w,
                          //                     ),
                          //                   // )
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       }
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      //Pagination
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 5.h,
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
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff8cb93d)),
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
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
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
        ),
        /*PaginationWidget(
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
            color: selectedPage == numberOfPages1() ? Colors.grey : Color(0xff000000),
          ),
          previousIcon: Icon(
            Icons.arrow_back_ios,
            size: 12,
            color: selectedPage==1 ? Colors.grey : Color(0xff000000),
          ),
          activeTextStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
          activeBtnStyle: ButtonStyle(
            visualDensity:
            VisualDensity(horizontal: -4),
            backgroundColor:
            MaterialStateProperty.all(
                const Color(0xff8cb93d)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(7),
                // side: const BorderSide(
                //  // color: Color(0xfff1f1f1),
                //   width: 1,
                // ),
              ),
            ),
            padding: MaterialStateProperty.all(
                const EdgeInsets.all(12)),
            // shadowColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff1f1f1),
            // ),
          ),
          inactiveBtnStyle: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.all(20)),
            visualDensity:
            const VisualDensity(horizontal: 0),
            elevation:
            MaterialStateProperty.all(0),
            // backgroundColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff9f9fb),
            // ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(15),
              ),
            ),
          ),
          inactiveTextStyle: const TextStyle(
            fontSize: 15,
            color: Color(0xff333333),
            fontWeight: FontWeight.w700,
          ),
        ),*/
      ),
    );
  }
}
