import 'dart:convert';
import 'package:careercoach/Models/askExperts.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'package:http/http.dart' as http;

class ExpertsQuery extends StatefulWidget {
  const ExpertsQuery({Key? key}) : super(key: key);

  @override
  State<ExpertsQuery> createState() => _ExpertsQueryState();
}

class _ExpertsQueryState extends State<ExpertsQuery>
    with TickerProviderStateMixin {
  final nameController = TextEditingController();
  final mailidController = TextEditingController();
  final subjectController = TextEditingController();
  final detailController = TextEditingController();

  int selectedPage = 1;
  late TabController _controller;
  late PageController _pageController;
  bool changeButtonColor = true;
  bool _isVisible = true;
  int widgetType = 1;
  List? data;
  String? head;
  String? sub;
  String? imagee;
  String? logo;
  String? discreption;
  List? expntile;
  String? evlbtnn1;
  String? evlbtnn2;
  List? drpvlue;
  String? drphed;
  String? valuue;
  String? jobfund;
  String? updte;
  String? _value1;
  int selectedTile = -1;
  bool isVisible = true;
  List? fresherjobs;
  List? experiencejobs;
  List? answered;
  String? activePage;
  String? userId;
  var jsonData;
  final _searchController = TextEditingController();
  List _searchList = [];
  bool _isSearching = false;

  void _handleTabSelection() {
    setState(() {
      _searchList = askList;
    });
  }

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  void showToast() {
    setState(() {
      isVisible = true;
    });
  }

  //GET CALL >>>>>>>>>

  Future getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);
    final response =
        await http.get(Uri.parse('${Config.baseURL}my-profile/$userId'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      // var jsonData = jsonDecode(response.body)["profiledetails"];
      debugPrint("Printing data came in get call: ${jsonData}");
      setState(() {
        nameController.text =
            ('${jsonData['profiledetails']['profileName']}') ?? '';
        mailidController.text =
            ('${jsonData['profiledetails']['emailId']}') ?? '';
      });
      debugPrint("Profile Details ++ $jsonData");
    } else {
      debugPrint('get call error');
    }
  }

  //POST CALL>>>>>>>>>>>>>>>>

  Future<void> postQuestion() async {
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postquery/endpoint.php');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': userId.toString(),
          'NAME': nameController.text,
          'MAIL_ID': mailidController.text,
          'SUBJECT': subjectController.text,
          "DETAILS": detailController.text,
        },
      );

      if (response.statusCode == 200) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Success!!",
                  ),
                  content: const Text(
                      "You Question has been successfully submitted!!"),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        subjectController.clear();
                        detailController.clear();
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

  String? selectedValue;

  List<AskExpertModel> askList = [];

  Future getAskExpertDetails(from) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);
    final response = await http
        .get(Uri.parse('${Config.baseURL}my-queries/$userId/$from/5'));

    print(response.toString());
    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["querydetails"];
      setState(() {
        // commandList = jsonData;
        askList = jsonData
                .map<AskExpertModel>((data) => AskExpertModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('printing jsondata of askDetails, $jsonData');
      // debugPrint('printing commandListttt of askDetails, ${askList[0].userId}');
    } else {
      debugPrint('get call error');
    }
  }

  pageList(page) {
    switch (page) {
      case 1:
        getAskExpertDetails(0);
        break;
      case 2:
        getAskExpertDetails(5);
        break;
      case 3:
        getAskExpertDetails(10);
        break;
      case 4:
        getAskExpertDetails(15);
        break;
      case 5:
        getAskExpertDetails(20);
        break;
      case 6:
        getAskExpertDetails(25);
        break;
      case 7:
        getAskExpertDetails(30);
        break;
      case 8:
        getAskExpertDetails(35);
        break;
      case 9:
        getAskExpertDetails(40);
        break;
      case 10:
        getAskExpertDetails(45);
        break;
      case 11:
        getAskExpertDetails(50);
        break;
      case 12:
        getAskExpertDetails(55);
        break;
      case 13:
        getAskExpertDetails(60);
        break;
      case 14:
        getAskExpertDetails(65);
        break;
      case 15:
        getAskExpertDetails(70);
        break;
      case 16:
        getAskExpertDetails(75);
        break;
      case 17:
        getAskExpertDetails(80);
        break;
      case 18:
        getAskExpertDetails(85);
        break;
      case 19:
        getAskExpertDetails(90);
        break;
      case 20:
        getAskExpertDetails(95);
        break;
      default:
        getAskExpertDetails(100);
    }
  }

  numberOfPages() {
    double pgNum = askList.length / 5;
    return pgNum.ceil();
  }

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "Ask Our Experts",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  @override
  void initState() {
    getData1();
    getData2();
    getData3();
    getProfileDetails();
    saveToRecent();
    getAskExpertDetails(0);
    _searchList = askList;
    _pageController = PageController();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(_handleTabSelection);
    super.initState();
  }

  //SEARCH.................

  void _search(String val) {
    if (val.isNotEmpty == true) {
      setState(() {
        // _searchList = (widget.totalCollegeList).where((element) => element.collegeName!.toLowerCase().contains(val.toLowerCase())).toList();
        _searchList = ((askList)
            .where((element) => element
                .searchableList()
                .toLowerCase()
                .contains(val.toLowerCase()))
            .toList());
        debugPrint("dataa Search List:${_searchList}");
      });
    } else {
      setState(() {
        debugPrint("came to else of search");
        _searchList = askList;
      });
    }
  }

  Future getData1() async {
    String jsonString =
        await rootBundle.loadString('assets/files/fresherjobs.json');
    //debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      fresherjobs = jsonMap["details"];
    });
  }

  Future getData2() async {
    String jsonString =
        await rootBundle.loadString('assets/files/experiencedjobs.json');
    //debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      experiencejobs = jsonMap["details1"];
    });
  }

  Future getData3() async {
    String jsonString =
        await rootBundle.loadString('assets/files/AskOurExperts.json');
    //debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      answered = jsonMap["details2"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TabController _controller = TabController(length: 2, vsync: this);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: const App_Bar_widget(
              title: 'Ask our Experts\n(Your Queries, Our Answers)'),
        ),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: (jsonData == null)
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
              : Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: ListView(
                    children: [
                      DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TabBar(
                                  isScrollable: false,
                                  padding: EdgeInsets.zero,
                                  labelPadding: EdgeInsets.zero,
                                  controller: _controller,
                                  unselectedLabelColor: Colors.black,
                                  indicatorColor: Config.containerGreenColor,
                                  labelColor: Config.whiteColor,
                                  labelStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                    color: Config.primaryTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.sp,
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Container(
                                      height: 4.h,
                                      width: 46.w,
                                      //margin: EdgeInsets.only(left: 30, right: 30),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          color: _controller?.index == 0
                                              ? Config.containerGreenColor
                                              : Config.mainBorderColor),
                                      child: Tab(
                                        key: UniqueKey(),
                                        child: Text(
                                          'Query Form',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            // fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 4.h,
                                      width: 46.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          color: _controller.index == 1
                                              ? Config.containerGreenColor
                                              : Config.mainBorderColor),
                                      child: Tab(
                                        // key: UniqueKey(),
                                        child: Text(
                                          'Q&A Answered',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            //color: _controller.index == 1 ? Config
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            //const Divider(thickness: 6, color: Config.containerGreenColor,),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 3.8.w, right: 3.8.w),
                              height: 0.5.h,
                              width: 100.w,
                              decoration: const BoxDecoration(
                                color: Config.containerGreenColor,
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.85,
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _controller,
                                children: <Widget>[
                                  //Query Form
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 4.w, right: 4.w),
                                    child: Column(
                                      children: [
                                        //Text Paragaph
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.w),
                                          child: Text(
                                            "Whatever the query you have - pertaining to Arch.,"
                                            " Civil, Mech., branches, Your training needs, Career guidance,"
                                            " s/w downloads……",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize:
                                                    Config.font_size_12.sp),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        //Name
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Name*',
                                              style: TextStyle(
                                                  fontSize:
                                                      Config.font_size_12.sp),
                                            ),
                                            Container(
                                                padding:
                                                    EdgeInsets.only(bottom: 3),
                                                height: 5.h,
                                                width: 73.8.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Color(0xffEBEBEB))),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 6),
                                                    child: Text(
                                                      nameController.text,
                                                      style: GoogleFonts.inter(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        //Mail ID
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Mail ID*',
                                              style: TextStyle(
                                                  fontSize:
                                                      Config.font_size_12.sp),
                                            ),
                                            Container(
                                                padding:
                                                    EdgeInsets.only(bottom: 3),
                                                height: 5.h,
                                                width: 73.8.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Color(0xffEBEBEB))),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 6),
                                                    child: Text(
                                                      mailidController.text,
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts.inter(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        //Subject
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Subject',
                                              style: TextStyle(
                                                  fontSize:
                                                      Config.font_size_12.sp),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 3),
                                              height: 5.h,
                                              width: 73.8.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Color(0xffEBEBEB))),
                                              child: TextFormField(
                                                textAlign: TextAlign.left,
                                                cursorColor: Colors.black,
                                                controller: subjectController,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(11),
                                                  hintText: "Subject",
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Config
                                                            .containerColor),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Config
                                                            .mainBorderColor),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        //Detail
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Detail',
                                              style: TextStyle(
                                                  fontSize:
                                                      Config.font_size_12.sp),
                                            ),
                                            Container(
                                              height: 15.4.h,
                                              width: 73.8.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Color(0xffEBEBEB))),
                                              child: TextFormField(
                                                textAlign: TextAlign.left,
                                                cursorColor: Colors.black,
                                                controller: detailController,
                                                decoration:
                                                    const InputDecoration(
                                                  counterText: "",
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  hintText:
                                                      "Please Explain in detail.....",
                                                ),
                                                //labelText: 'Enter 10 digit mobile number',
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLength: 250,
                                                maxLines: null,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  LengthLimitingTextInputFormatter(
                                                      250),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        //Submit Button
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(''),
                                            Container(
                                              width: 28.3.w,
                                              height: 4.3.h,
                                              decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color:
                                                          Color(0xff00000029),
                                                      blurRadius: 5.0,
                                                    ),
                                                  ],
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(
                                                      color: const Color(
                                                          0XFF999999),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: TextButton(
                                                  onPressed: () {
                                                    if (subjectController
                                                            .text.isNotEmpty &&
                                                        detailController
                                                            .text.isNotEmpty) {
                                                      postQuestion();
                                                      print(
                                                          nameController.text);
                                                      print(mailidController
                                                          .text);
                                                      print(userId.toString());
                                                      print(subjectController
                                                          .text);
                                                      print(detailController
                                                          .text);
                                                    } else {
                                                      var snackBar = SnackBar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          content: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                color: Colors
                                                                    .grey
                                                                    .shade200),
                                                            child: Text(
                                                              'Please Fill Subject and Details To submit!!',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: Config
                                                                      .font_size_12
                                                                      .sp,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ));
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                      debugPrint(
                                                          "please enter subject field and detail field");
                                                    }
                                                  },
                                                  child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black),
                                                  )),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.5.h,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 2.5.h,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Like what you see? Further training needs?',
                                              style: TextStyle(
                                                  fontSize:
                                                      Config.font_size_12.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 2.h, bottom: 1.h),
                                              child: Text(
                                                'Reach us at:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        Config.font_size_12.sp),
                                              ),
                                            ),
                                            //Phone
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone_in_talk_outlined,
                                                  size: 4.w,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Text(
                                                  '+91 9X9X9X1234; 040-24892489',
                                                  style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: Config
                                                          .font_size_12.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            //Mail
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.mail_outline_sharp,
                                                  size: 5.w,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'support@gmail.com',
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          fontSize: Config
                                                              .font_size_12.sp),
                                                    ),
                                                    Text(
                                                      'enquiry@gmail.com',
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          fontSize: Config
                                                              .font_size_12.sp),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Q/A Answered
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 4.w, right: 4.w, top: 3.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 90.w,
                                          child: Text(
                                            "Our users, their queries & our expert team "
                                            "answers are captured here in….come benefit from the "
                                            "industry audience …..",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Container(
                                          width: 90.w,
                                          child: Text(
                                            'Search below our Q&A forum, relevant topics answered in past!',
                                            style: TextStyle(
                                                fontSize:
                                                    Config.font_size_12.sp,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.sp, right: 10.sp),
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(left: 10.sp),
                                            // width: 20.w,
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              border: Border.all(
                                                  color: Color(0xff425481)),
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
                                                icon: Icon(_isSearching
                                                    ? Icons.search
                                                    : Icons.close),
                                                onPressed: () {
                                                  _searchController.clear();
                                                  _searchList = askList;
                                                  setState(() {
                                                    _isSearching =
                                                        !_isSearching;
                                                  });
                                                },
                                              ),
                                            ]),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        (_searchList.isEmpty)
                                            ? Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Loading',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.sp,
                                                        color: Config
                                                            .primaryTextColor,
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
                                                key: Key(
                                                    selectedTile.toString()),
                                                shrinkWrap: true,
                                                physics: const ScrollPhysics(),
                                                itemCount:
                                                    _searchList?.length ?? 0,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 1.h),
                                                    child: GestureDetector(
                                                      onTap: (() {
                                                        print(_searchList[index]
                                                                .replyDetails
                                                                .toString() +
                                                            'this is result');
                                                      }),
                                                      child: Container(
                                                        // margin: const EdgeInsets.only(top: 10, bottom: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: Config
                                                                    .mainBorderColor,
                                                                width: 1)),
                                                        child: Theme(
                                                          data: ThemeData().copyWith(
                                                              dividerColor: Colors
                                                                  .transparent),
                                                          child: ExpansionTile(
                                                            initiallyExpanded:
                                                                index ==
                                                                    selectedTile,
                                                            collapsedBackgroundColor:
                                                                Colors.white,
                                                            backgroundColor: Config
                                                                .containerColor,
                                                            title: Container(
                                                              width: 60.w,
                                                              child: Text(
                                                                "Q${index + 1}) ${_searchList[index].subject}" ??
                                                                    'Q) Question?',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Config
                                                                      .primaryTextColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            trailing:
                                                                const Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_outlined,
                                                              color: Config
                                                                  .primaryTextColor,
                                                            ),
                                                            onExpansionChanged:
                                                                ((newState) {
                                                              if (newState)
                                                                setState(() {
                                                                  selectedTile =
                                                                      index;
                                                                });
                                                              else
                                                                setState(() {
                                                                  selectedTile =
                                                                      -1;
                                                                });
                                                            }),
                                                            children: [
                                                              Divider(
                                                                thickness: 1,
                                                                color: Color(
                                                                    0XFFF1F1F1),
                                                              ),
                                                              Column(
                                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            3.w,
                                                                        right:
                                                                            3.w,
                                                                        bottom:
                                                                            2.h),
                                                                    child: (_searchList[index].replyDetails ==
                                                                                "" ||
                                                                            _searchList[index].replyDetails ==
                                                                                null)
                                                                        ? Text(
                                                                            'Still Not Answered',
                                                                            style: TextStyle(
                                                                                fontSize: Config.font_size_12.sp,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500),
                                                                          )
                                                                        : Text(
                                                                            "${_searchList[index].replyDetails}",
                                                                            style:
                                                                                TextStyle(fontSize: 11.sp, color: Colors.black),
                                                                          ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: (_controller.index == 0)
              ? null
              : PaginationWidget(
                  numOfPages: numberOfPages(),
                  selectedPage: selectedPage,
                  pagesVisible: 3,
                  spacing: 0,
                  onPageChanged: (page) {
                    (askList.isEmpty)
                        ? const Center(
                            child: CupertinoActivityIndicator(
                              radius: 25,
                              color: Colors.black,
                            ),
                          )
                        : pageList(page);
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
                        // side: const BorderSide(
                        //  // color: Color(0xfff1f1f1),
                        //   width: 1,
                        // ),
                      ),
                    ),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(12)),
                    // shadowColor:
                    // MaterialStateProperty.all(
                    //   const Color(0xfff1f1f1),
                    // ),
                  ),
                  inactiveBtnStyle: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
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
          contentPadding: EdgeInsets.only(left: 10),
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
