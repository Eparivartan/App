import 'dart:convert';
import 'package:careercoach/Models/collegeInfo.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'our_recommendations.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final List<CollegeSearchResultModel> totalCollegeList;
  final List<CollegeSearchResultModel> recommendedCollege;
  const Result(
      {Key? key,
      required this.totalCollegeList,
      required this.recommendedCollege})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
//  final double _dataPagerHeight = 60.0;
  String? userId;
  int selectedPage = 1;
  bool _isSearching = false;
  List? info;
  String? Title;
  String? sub;
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
  final _searchController = TextEditingController();
  List _searchList = [];

  void _search(String val) {
    if (val.isNotEmpty == true) {
      setState(() {
        // _searchList = (widget.totalCollegeList).where((element) => element.collegeName!.toLowerCase().contains(val.toLowerCase())).toList();
        _searchList = ((widget.totalCollegeList)
            .where((element) =>
                element.toString().toLowerCase().contains(val.toLowerCase()))
            .toList());
        debugPrint("dataa Search List:${_searchList}");
      });
    } else {
      setState(() {
        debugPrint("came to else of search");
        _searchList = widget.totalCollegeList;
      });
    }
  }

  int selected = 0;

  @override
  void initState() {
    debugPrint("Came to Print:??${widget.totalCollegeList}");
    debugPrint("Came to Print:??${widget.recommendedCollege}");
    _searchList = widget.totalCollegeList;
    loadJson();
    super.initState();
  }

  numberOfPages() {
    double pgNum = widget.totalCollegeList.length / 5;
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
            'ROOT1': "College Information Result",
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
    // debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      info = jsonMap["info"];
      Title = jsonMap['title'];
      sub = jsonMap['sub'];
      Title1 = jsonMap['title1'];
      Data1 = jsonMap['data1'];
      Title2 = jsonMap['title2'];
      Data2 = jsonMap['data2'];
      Title3 = jsonMap['title3'];
      Data3 = jsonMap['data3'];
      Title4 = jsonMap['title4'];
      Data4 = jsonMap['data4'];
      Title5 = jsonMap['title5'];
      Data5 = jsonMap['data5'];
      Title6 = jsonMap['title6'];
      Data6 = jsonMap['data6'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                    'Educational Institutions / \n' ' University courses',
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
          child: Center(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Image.asset(
                    'assets/images/collegeInformation.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 19, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your search, Our results!!',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.refresh_outlined,
                              color: Color(0xff333333),
                              size: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Search again',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xffffffff),
                      border: Border.all(
                        color: Color(0xfff1f1f1),
                      ),
                    ),
                    child:
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20, top: 10),
                        border: InputBorder.none,
                        hintText: 'Refine your search',
                        suffixIcon: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchResult()));
                            },
                            child: Icon(Icons.search)),
                      ),
                    ),
                  ),
                ),*/
                //Search
                Padding(
                  padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                  child: Container(
                    padding: EdgeInsets.only(left: 10.sp),
                    width: 20.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Color(0xff425481)),
                    ),
                    child: Row(children: [
                      _buildSearchField(),
                      Spacer(),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 9.0, bottom: 9.0),
                      //   child: VerticalDivider(
                      //     color: Color(0xff425481),
                      //     thickness: 2,
                      //   ),
                      // ),
                      IconButton(
                        icon: Icon(_isSearching ? Icons.search : Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          _searchList = widget.totalCollegeList;
                          setState(() {
                            _isSearching = !_isSearching;
                          });
                        },
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Ex: college name, university, PIN, code, location..',
                    style: TextStyle(
                      color: const Color(0xff999999),
                      fontSize: 9.sp,
                    ),
                  ),
                ),
                //Recomendation
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OurRecommendations(
                                recommendedColleges:
                                    widget.recommendedCollege)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 27, bottom: 20),
                    child: Center(
                      child: Container(
                        height: 4.8.h,
                        width: 92.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xffC5C794),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40.h,
                                width: 14.9.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xffffffff),
                                ),
                                child: Image.asset(
                                  'assets/images/recomendationIcon.png',
                                  width: 15.w,
                                  height: 5.h,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                'Click for our Recommendations',
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: Config.font_size_12.sp,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Image.asset(
                                'assets/images/thumb.png',
                                height: 5.h,
                                width: 5.w,
                              ),
                              // Icon(Icons.thumb_up_alt_outlined,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                (widget.totalCollegeList.length == 0)
                    ? Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Text(
                            "No result found for your search",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600),
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: _searchList.length,
                        //  itemCount: info?.length?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
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
                                  key: Key(index.toString()),
                                  collapsedBackgroundColor: Colors.white,
                                  backgroundColor: const Color(0xfff9f9fb),
                                  iconColor: const Color(0xff333333),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 95.w,
                                        child: Text(
                                          _searchList[index].collegeName ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: Config.font_size_12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff333333),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          /*Text(_searchList[index].collegeRank ?? '',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          // fontWeight: FontWeight.bold,
                                          color: const Color(0xff333333),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                        child: Text("|" ?? '',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            // fontWeight: FontWeight.bold,
                                            color: const Color(0xff333333),
                                          ),
                                        ),
                                      ),*/
                                          Text(
                                            "Rank: ${_searchList[index].collegeRank}" ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              // fontWeight: FontWeight.bold,
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  children: [
                                    Divider(
                                      color: Color(0xfff1f1f1),
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 18),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                    // border: Border.all(color: Colors.black)
                                                    ),
                                                child: Text(
                                                  "${_searchList[index].collegeCode}" ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
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
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                    // border: Border.all(color: Colors.black)
                                                    ),
                                                child: Text(
                                                  "${_searchList[index].collegeBranches}" ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
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
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                    // border: Border.all(color: Colors.black)
                                                    ),
                                                child: Text(
                                                  "${_searchList[index].affiliatedTo}" ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
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
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                    // border: Border.all(color: Colors.black)
                                                    ),
                                                child: Text(
                                                  "${_searchList[index].collegeAddress}" ??
                                                      '',
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
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
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                    // border: Border.all(color: Colors.black)
                                                    ),
                                                child: Text(
                                                  "${_searchList[index].collegeContactno}" ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
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
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                    // border: Border.all(color: Colors.black)
                                                    ),
                                                child: Text(
                                                  "${_searchList[index].collegeEmailId}" ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color:
                                                        const Color(0xff333333),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
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
                // SizedBox(height: 3.h,),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: PaginationWidget(
            numOfPages: numberOfPages(),
            selectedPage: selectedPage,
            pagesVisible: 3,
            spacing: 0,
            onPageChanged: (page) {
              setState(() {
                selectedPage = page;
              });
            },
            nextIcon: Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: selectedPage == numberOfPages()
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
                ),
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
              shadowColor: MaterialStateProperty.all(
                const Color(0xfff1f1f1),
              ),
            ),
            inactiveBtnStyle: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
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
      ),
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      width: 65.w,
      height: 10.h,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5, bottom: 2, top: -5),
          hintText: 'Search here...',
          hintStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize:
                  SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 9.sp),
          border: InputBorder.none,
        ),
        onChanged: (val) {
          _search(val);
        },
      ),
    );
  }
}
