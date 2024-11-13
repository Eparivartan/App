import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
// import 'package:flutter_pagination/flutter_pagination.dart';
// import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:number_pagination/number_pagination.dart';
//import 'package:number_paginator/number_paginator.dart';
import 'package:sizer/sizer.dart';
import '../College Information/our_recommendations.dart';
import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  String? userId;
  final int _numPages = 3;
  int _currentPage = 0;

  List? Info;

  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  void initState() {
    loadJson();
    super.initState();
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
            'ROOT1': "Information",
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

  Future loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/college_info1.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      Info = jsonMap["info"];
    });
    print("Printing the length : ${Info?.length}");
  }

  @override
  Widget build(BuildContext context) {
    var pages = List.generate(
      _numPages,
      (index) => const Center(
          // child: Text(
          //   "Page ${index + 1}",
          //   style: Theme.of(context).textTheme.headline1,
          // ),
          ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: Text(
                  'College Information',
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
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
        //child: (Info == null) ? const Center(child: CircularProgressIndicator()) :
        child: ListView(
          children: [
            pages[_currentPage],
            // Container(
            //   height: 60,
            //   width: 375,
            //   color: const Color(0xfff9f9fb),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 10, right: 10),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Image.asset(
            //           'assets/images/Group 896.png',
            //           height: 50,
            //           width: 100,
            //         ),
            //         Text('College Information',
            //             style: GoogleFonts.poppins(
            //                 textStyle: TextStyle(
            //               fontSize: 10.sp,
            //             ))),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Image.asset(
                'assets/images/collegeInformation.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 35),
              child: Card(
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 22, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color(0xfff9f9f9),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 10.sp,
                          )),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Config.mainBorderColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Config.mainBorderColor),
                            ),
                            labelText: '    Search',
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 8, bottom: 5),
                      child: Text(
                        'Ex: college name,university,PIN,college code,location..',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 25,
                              top: 3,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50)),
                                  color: Color(0xffebebeb),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(
                                    'Click for our Recommendations',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 8.sp,
                                        color: const Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: const Color(0xff8bb83d),
                                child: Image.asset("assets/images/thumb.png"),
                              ),
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         const OurRecommendations()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: Info?.length ?? 0,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade100),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedBackgroundColor: Colors.white,
                                backgroundColor: const Color(0xfff9f9fb),
                                iconColor: const Color(0xff000000),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        Info?[index]["title"] ?? '',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff333333),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        Info?[index]["sub"] ?? '',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 9.sp,
                                            color: const Color(0xff333333),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Info?[index]["title1"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["title2"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["title3"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["title4"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["title5"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["title6"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Info?[index]["data1"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["data2"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["data3"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["data4"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["data5"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Info?[index]["data6"] ?? '',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: PaginationWidget(
                        numOfPages: 10,
                        selectedPage: selectedPage,
                        pagesVisible: 3,
                        spacing: 10,
                        onPageChanged: (page) {
                          setState(() {
                            selectedPage = page;
                          });
                        },
                        nextIcon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                        previousIcon: const Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                        ),
                        activeTextStyle: const TextStyle(
                          color: Color(0xff333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        activeBtnStyle: ButtonStyle(
                          visualDensity: const VisualDensity(horizontal: -4),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Color(0xfff9f9fb),
                                width: 2,
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          shadowColor: MaterialStateProperty.all(
                            const Color(0xfff1f1f1),
                          ),
                        ),
                        inactiveBtnStyle: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          visualDensity: const VisualDensity(horizontal: 0),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xfff9f9fb),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: Color(0xffffffff),
                                width: 10,
                              ),
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

                    /*NumberPagination(
                      onPageChanged: (int pageNumber) {
                        //do somthing for selected page
                        // setState(() {
                        //   selectedPageNumber = pageNumber;
                        // });
                      },
                      pageTotal: 3,
                      fontSize: 20,
                     // pageInit: selectedPageNumber, // picked number when init page
                      colorPrimary: Colors.grey,
                      colorSub: Colors.grey.shade50,
                      iconToFirst: Container(),
                      iconPrevious: Icon(Icons.access_time_filled),
                      iconNext: Icon(Icons.arrow_forward_ios),
                      iconToLast: Container(),
                    ),*/

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Pagination(
                    //       width: 300,
                    //       //width: MediaQuery.of(context).size.width * .6,
                    //       // this prop is optional
                    //       paginateButtonStyles: PaginateButtonStyles(
                    //         paginateButtonBorderRadius:
                    //             BorderRadius.circular(7),
                    //         activeBackgroundColor: Colors.blue,
                    //         // const Color(0xffffffff),
                    //         activeTextStyle: const TextStyle(
                    //           color: Color(0xff333333),
                    //         ),
                    //         backgroundColor: Colors.green,
                    //         //const Color(0xfff9f9fb),
                    //         textStyle: const TextStyle(
                    //           color: Color(0xff333333),
                    //         ),
                    //       ),
                    //       prevButtonStyles: PaginateSkipButton(
                    //         //borderRadius: BorderRadius.circular(7),
                    //         buttonBackgroundColor: const Color(0xfffffff),
                    //         icon: const Icon(
                    //           Icons.arrow_back_ios_new,
                    //           color: Color(0xff333333),
                    //           size: 15,
                    //         ),
                    //       ),
                    //       nextButtonStyles: PaginateSkipButton(
                    //         // borderRadius: BorderRadius.circular(7),
                    //         buttonBackgroundColor: const Color(0xffffffff),
                    //         icon: const Icon(
                    //           Icons.arrow_forward_ios,
                    //           color: Color(0xff333333),
                    //           size: 15,
                    //         ),
                    //       ),
                    //       onPageChange: (number) {
                    //         setState(
                    //           () {
                    //             _currentPage = number;
                    //           },
                    //         );
                    //       },
                    //       useGroup: true,
                    //       totalPage: 6,
                    //       show: 3,
                    //       currentPage: _currentPage,
                    //     ),
                    //   ],
                    // )

                    /*NumberPaginator(
                        controller: _controller,
                        numberPages: _numPages,
                        config: NumberPaginatorUIConfig(
                          buttonSelectedBackgroundColor: Color(0xffffffff),
                          buttonUnselectedBackgroundColor: Color(0xfff9f9fb),
                          buttonShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: BorderSide(color: Color(0xfff1f1f1),),
                          ),
                          mode: ContentDisplayMode.numbers,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        onPageChange: (index) {
                          setState(
                            () {
                              _currentPage = index;
                              debugPrint("Printing index of the pages $index");
                            },
                          );
                        },
                        // config: NumberPaginatorUIConfig(
                        //   height: 5.h,
                        //   buttonShape: RoundedRectangleBorder(
                        //     side: const BorderSide(
                        //       color: Color(0xfff1f1f1),
                        //     ),
                        //     borderRadius: BorderRadius.circular(7),
                        //   ),
                        //   buttonSelectedBackgroundColor: Color(0xffffffff),
                        //   buttonSelectedForegroundColor: Colors.black,
                        //   buttonUnselectedForegroundColor: Colors.black,
                        //   buttonUnselectedBackgroundColor: Color(0xfff9f9fb),//const Color(0xfff9f9fb),
                        // ),
                      ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
