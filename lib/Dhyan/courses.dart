import 'dart:convert';
import 'package:careercoach/Dhyan/contact.dart';
import 'package:careercoach/Home%20Page.dart';
import 'package:careercoach/Models/DhyanModel.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import 'package:http/http.dart' as http;
import '../Widgets/App_Bar_Widget.dart';

class courses extends StatefulWidget {
  const courses({Key? key}) : super(key: key);

  @override
  State<courses> createState() => _coursesState();
}

class _coursesState extends State<courses> {
  final ScrollController _scrollController = ScrollController();
  List? course;
  String? Useridnum;
  String? Course;
  String? Title;
  String? Data;
  String? Title2;
  String? TO;
  String? Title3;
  String? CD;
  String? Title4;
  String? CC;
  String? Img;
  String? Timg;
  String? Pic;
  String? Nos;
  String? Mail;
  String? Call;
  String? Mailing;
  String? Contact;
  List<CoursesModel> courseList = [];
  List<bool>? likedList;

  Future getDetails() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listcourses'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["coursesoffered"];
      setState(() {
        courseList = jsonData
                .map<CoursesModel>((data) => CoursesModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json Model ReviewModel, $GalleryModel');
    } else {
      debugPrint('get call error');
    }
    debugPrint("Fresher2Industry123 : $courseList");
    // debugPrint("Service Details : $serviceDetails");
  }

  @override
  void initState() {
    loadJson();
    getDetails();
    super.initState();
  }

  Future loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/courses.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      course = jsonMap["course"];
      Course = jsonMap["Course"];
      Title = jsonMap['title'];
      Data = jsonMap['data'];
      Title2 = jsonMap['title2'];
      TO = jsonMap['to'];
      Title3 = jsonMap['title3'];
      CD = jsonMap['cd'];
      Title4 = jsonMap['title4'];
      CC = jsonMap['cc'];
      Img = jsonMap['img'];
      Timg = jsonMap['timg'];
      Pic = jsonMap['pic'];
      Mail = jsonMap['mail'];
      Call = jsonMap['call'];
      Mailing = jsonMap['mailing'];
      Contact = jsonMap['contact'];
      Nos = jsonMap['nos'];
      print(course);
      print(Course);
    });
  }

  bool colorBool = false;

  Future<void> postFavourite() async {
    Useridnum = (await SharedPreferencesHelper.getUserId()) ?? "Not set";
    print(Useridnum.toString());

    print(Useridnum.toString());
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postmyfavourite/endpoint.php');

    print(url.toString() + '>>>>>>>>>');
    print(Useridnum.toString() + '<><><><><><>');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': Useridnum.toString(),
          'PATH': jsonEncode({
            'ROOT1': "Dyan Courses",
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

  // Define a map to keep track of which icons are liked and their corresponding colors
  Map<int, Color> likedColorMap = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Config.whiteColor,
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
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
        ),
      ),
      body: Container(
        child: (course == null)
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
            : Center(
                child: ListView(
                  children: [
                    Image.asset(Pic ?? ''),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 17, bottom: 11),
                          child: Text(
                            'Courses offered',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 18),
                          child: Text(
                            Course ?? '',
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xff333333)),
                          ),
                        ),
                        (courseList.length == 0)
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
                            : ListView.builder(
                                // controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: courseList.length ?? 0,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: Color(0xffF1F1F1)),
                                      ),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            dividerColor: Colors.transparent),
                                        child: ExpansionTile(
                                          collapsedIconColor: Color(0xff000000),
                                          collapsedBackgroundColor:
                                              Colors.white,
                                          backgroundColor:
                                              const Color(0xfff9f9fb),
                                          iconColor: const Color(0xff000000),
                                          title: GestureDetector(
                                            onTap: (() {
                                              setState(() {
                                                // Toggle color based on the current color
                                                if (likedColorMap
                                                    .containsKey(index)) {
                                                  likedColorMap.remove(index);
                                                } else {
                                                  likedColorMap[index] = Colors
                                                      .green; // Liked color
                                                }
                                              });
                                            }),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  courseList?[index]
                                                          .courseName ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: (() {
                                                    setState((() {
                                                      likedColorMap[index] =
                                                          Colors.green;
                                                    }));
                                                  }),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: likedColorMap
                                                              .containsKey(
                                                                  index)
                                                          ? likedColorMap[index]
                                                          : Color(0xffCCCCCC),
                                                    ),
                                                    height: 3.h,
                                                    width: 6.w,
                                                    child: Icon(
                                                      Icons
                                                          .thumb_up_alt_outlined,
                                                      color: Color(0xffFFFFFF),
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          children: [
                                            const Divider(
                                              thickness: 1,
                                              color: Color(0xffF1F1F1),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Scrollbar(
                                                      
                                                        controller:
                                                            _scrollController,
                                                        child:
                                                            SingleChildScrollView(
                                                          // controller: _scrollController,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child: (courseList
                                                                      ?.length ==
                                                                  0)
                                                              ? Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Loading',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              15.sp,
                                                                          color:
                                                                              Config.primaryTextColor,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            2.w,
                                                                      ),
                                                                      const CupertinoActivityIndicator(
                                                                        radius:
                                                                            15,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 20.h,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              0,
                                                                          bottom:
                                                                              8,
                                                                          left:
                                                                              16,
                                                                          right:
                                                                              14),
                                                                      child:
                                                                          Text(
                                                                        courseList?[index].courseDescription ??
                                                                            '',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              11.sp,
                                                                          color:
                                                                              const Color(0xff333333),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 14),
                                                        child: Text(
                                                          course?[index]
                                                                  ["title2"] ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                                0xff333333),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 14,
                                                                left: 3),
                                                        child: Text(
                                                          courseList?[index]
                                                                  .trainingOptions ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 11.sp,
                                                            color: const Color(
                                                                0xff333333),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Text(
                                                          course?[index]
                                                                  ["title3"] ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                                0xff333333),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3,
                                                                top: 10),
                                                        child: Text(
                                                          courseList?[index]
                                                                  .courseDuration ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 11.sp,
                                                            color: const Color(
                                                                0xff333333),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Text(
                                                          course?[index]
                                                                  ["title4"] ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                                0xff333333),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Text(
                                                          courseList?[index]
                                                                  .courseCertificate ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 11.sp,
                                                            color: const Color(
                                                                0xff333333),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                    color: Color(0xffF1F1F1),
                                                  ),
                                                  Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Show Interest',
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12,
                                                                right: 24),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: likedColorMap
                                                                    .containsKey(
                                                                        index)
                                                                ? likedColorMap[
                                                                    index]
                                                                : Color(
                                                                    0xffCCCCCC),
                                                          ),
                                                          height: 3.h,
                                                          width: 6.w,
                                                          child: Icon(
                                                            Icons
                                                                .thumb_up_alt_outlined,
                                                            color: Color(
                                                                0xffFFFFFF),
                                                            size: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ContactUs()));
                                                          },
                                                          child: Text(
                                                            'Book/Buy this course',
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                fontSize: 11.sp,
                                                                color: Color(
                                                                    0xff1F5FD9)),
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .double_arrow_sharp,
                                                        color:
                                                            Color(0xff1f5fd9),
                                                        size: 20,
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
                                }),
                      ],
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(top: 14),
          height: 30.h,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 5),
                child: Container(
                  height: 11.2.h,
                  width: 92.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Color(0xfff3f4f3),
                    border: Border.all(
                      color: Color(0xffd9dfd6),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 14, right: 15, left: 16, bottom: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wanted to Join one of our courses ?',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          ),
                        ),
                        Text(
                          'Did not find the course you are looking for ?',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactUs()),
                            );
                          }),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Drop an Enquiry',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff1F5FD9),
                                  fontSize: 11.sp,
                                ),
                              ),
                              TextSpan(
                                text: ' to know detailed offerings.',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Container(
                  height: 13.h,
                  width: 92.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Color(0xfff3f4f3),
                    border: Border.all(
                      color: Color(0xffd9dfd6),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 10, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Contact Us',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff333333),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Icon(Icons.phone_in_talk_outlined),
                              Text(Nos ?? ''),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.mail_outline_rounded),
                            Column(
                              children: [
                                Text(
                                  Mail ?? '',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
