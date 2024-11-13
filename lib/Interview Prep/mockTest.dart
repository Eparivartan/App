import 'dart:convert';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:careercoach/Interview%20Prep/MockTestMCQ.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../Config.dart';
import '../Home Page.dart';
import '../Models/headerModel.dart';
import '../Models/interviewPrepModel.dart';
import '../Models/softwareInUseModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'mockTest/mocktestScreen.dart';

class MockTest extends StatefulWidget {
  const MockTest({Key? key}) : super(key: key);

  @override
  State<MockTest> createState() => _MockTestState();
}

class _MockTestState extends State<MockTest>
    with SingleTickerProviderStateMixin {
  List? data1;
  String? head;
  String? sub;
  String? imagee;
  String? logo;
  List? pages;
  List? dataa;
  String? _value1;
  String? _value2;
  String? drophead;
  String? activePage;
  bool changeButtonColor = true;
  int widgetType = 1;
  TabController? _controller;
  bool tileExpanded = false;
  int selectedTile = -1;
  int selectedPage = 1;
  String? selectedValue;
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  int? selectedId;
  int? selected = -1;
  bool value = true;
  String alpha = 'A';
  List<BranchDropdownModel> branchDropdown = [];
  List<McqTestListModel> mcqList = [];
  List<headerModel> headerList = [];
  List<CommandsListModel> commandsList1 = [];

  final List<String> items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
  ];

  @override
  void initState() {
    // getDetails();
    debugPrint("mcqListmcqListmcqList: $mcqList");
    BreachDropDown();
    // getMcqTest();
    // getCmdDetails();
    HeaderList();
    // getDetails2(data1?[index]["Topic"].toString());
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller?.addListener(_handleTabSelection);
  }

  Future HeaderList() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listheaders'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];

      setState(() {
        headerList = jsonData
                .map<headerModel>((data) => headerModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data headers, $jsonData');
      debugPrint(
          'printing header List, ${headerList[6].headerName}, ${headerList[7].headerName}');
    } else {
      debugPrint('get call error');
    }
  }

  void _handleTabSelection() {
    setState(() {
      selected = -1;
    });
  }

  Future BreachDropDown() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listcategory'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];
      // selectedValue1==null;
      // debugPrint("null:: ${selectedValue1}");
      // debugPrint("null:123: ${selectedValue}");

      setState(() {
        branchDropdown = jsonData
                .map<BranchDropdownModel>(
                    (data) => BranchDropdownModel.fromJson(data))
                .toList() ??
            [];
      });
      getData(0);
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json Model, $BranchDropdownModel');
    } else {
      debugPrint('getDetails get call error');
    }
    //debugPrint("Fresher2Industry123 : $branchDropdown");
    // debugPrint("Service Details : $serviceDetails");
  }

  Future GetMcqList() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listmcq/$selectedValue/$selectedValue1'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["listmcqs"];

      setState(() {
        mcqList = jsonData
                .map<McqTestListModel>(
                    (data) => McqTestListModel.fromJson(data))
                .toList() ??
            [];
      });
      getData(0);
      debugPrint('GetCall Success for GetMCQLIST');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json--------data, $mcqList');
      debugPrint('printing json----1234567----data, $mcqList');
      debugPrint('printing json Model, $McqTestListModel');
    } else {
      debugPrint('getDetails get call error');
    }
    //debugPrint("Fresher2Industry123 : $branchDropdown");
    // debugPrint("Service Details : $serviceDetails");
  }

  Future getMcqTest() async {
    final response = await http.get(Uri.parse('${Config.baseURL}viewmcq/4'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];
      // selectedValue1==null;
      // debugPrint("null:: ${selectedValue1}");
      // debugPrint("null:123: ${selectedValue}");

      setState(() {
        branchDropdown = jsonData
                .map<BranchDropdownModel>(
                    (data) => BranchDropdownModel.fromJson(data))
                .toList() ??
            [];
      });
      getData(0);
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json Model, $BranchDropdownModel');
    } else {
      debugPrint('getDetails get call error');
    }
    //debugPrint("Fresher2Industry123 : $branchDropdown");
    // debugPrint("Service Details : $serviceDetails");
  }

  final _headerStyle = const TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

  Future getData(from) async {
    String jsonString =
        await rootBundle.loadString('assets/files/Software_in_use.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      data1 = jsonMap["data"];
      head = jsonMap['main'];
      sub = jsonMap["sub"];
      imagee = jsonMap["Immage"];
      logo = jsonMap["logoo"];
      pages = jsonMap["paages"];
      dataa = jsonMap["abt"];
    });
    debugPrint("printing Values ->> $data1");
  }

  getPageData(from) {
    var count = 7 + from;
    for (var i = from; i < count; i++) {
      if (i < 7) {
        debugPrint('came i<7!!!');
        return Accordion(
          maxOpenSections: 1,
          headerBackgroundColorOpened: Colors.white,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: false,
              rightIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.black),
              headerBackgroundColor: Colors.white,
              headerBackgroundColorOpened: Colors.white,
              header: Text('A', style: _headerStyle),
              content: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: commandsList1.length ?? 0,
                  itemBuilder: (context, indexes) {
                    return
                        // commandList.length==0 ? CircularProgressIndicator() :
                        Column(
                      children: [
                        // const Divider(thickness: 1, color: Config.mainBorderColor),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 8, top: 8, bottom: 8),
                                child: Container(
                                  width: 10.w,
                                  child: Text(
                                      commandsList1[indexes].swCode.toString()),
                                )),
                            // SizedBox(width: 3.w,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 60.w,
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: commandsList1[indexes]
                                            .codeDescription ??
                                        '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ])),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }),
              // content: Text(_loremIpsum, style: _contentStyle),
              contentHorizontalPadding: 20,
              contentBorderWidth: 1,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
          ],
        );
      } else if (i > 7) {
        debugPrint('came i>7!!!');
        Accordion(
          maxOpenSections: 1,
          headerBackgroundColorOpened: Colors.white,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: false,
              rightIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.black),
              headerBackgroundColor: Colors.white,
              headerBackgroundColorOpened: Colors.white,
              header: Text('I', style: _headerStyle),
              content: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: commandsList1.length ?? 0,
                  itemBuilder: (context, indexes) {
                    return
                        // commandList.length==0 ? CircularProgressIndicator() :
                        Column(
                      children: [
                        // const Divider(thickness: 1, color: Config.mainBorderColor),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 8, top: 8, bottom: 8),
                                child: Container(
                                  width: 10.w,
                                  child: Text(
                                      commandsList1[indexes].swCode.toString()),
                                )),
                            // SizedBox(width: 3.w,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 60.w,
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: commandsList1[indexes]
                                            .codeDescription ??
                                        '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ])),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }),
              // content: Text(_loremIpsum, style: _contentStyle),
              contentHorizontalPadding: 20,
              contentBorderWidth: 1,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
          ],
        );
      } else {
        return print("Hello");
      }
    }
  }

  pageList(page) {
    switch (page) {
      case 1:
        getPageData(0);
        break;
      case 2:
        getPageData(7);
        break;
      case 3:
        getPageData(14);
        break;
      case 4:
        getPageData(21);
        break;
      case 5:
        getPageData(28);
        break;
      default:
        getPageData(35);
    }
  }

  Future<bool> showExitPopup() async {
    return await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  numberOfPages() {
    double num = 5 / 5;
    return num.ceil();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: const App_Bar_widget(title: 'MCQ'),
        ),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(left: 4.w, right: 2.w),
                child: Text(
                  "These Mock Tests will prepare you for "
                  "written (technical) round of interviews….",
                  style: TextStyle(
                      fontSize: Config.font_size_12.sp, color: Colors.black),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Branch dropdown Container
                  Padding(
                    padding: EdgeInsets.only(top: 2.2.h, left: 4.w, right: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: 50.w,
                          child: Text(
                            'Select branch*',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 11.sp,
                              color: const Color(0XFF1F1F39),
                            ),
                          ),
                        ),
                        (branchDropdown == null ||
                                branchDropdown == '' ||
                                branchDropdown.length == 0)
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
                                      radius: 10,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )
                            : DropdownButton2(
                                dropdownElevation: 5,
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                selectedItemHighlightColor: Colors.lightGreen,
                                underline: Container(),
                                items: branchDropdown
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item.id,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              "${item.cname}" ?? "",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue1 = null;
                                    selectedValue = value as String;
                                    debugPrint(
                                        "SelectedValue: is : $selectedValue");
                                    // GetMcqList();
                                  });
                                  // selectedValue1 == null;
                                },
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                iconSize: 30,
                                iconEnabledColor: Colors.black,
                                buttonHeight: 3.9.h,
                                buttonWidth: 55.w,
                                buttonPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: const Color(0XFFF1F1F1)),
                                  color: Colors.white,
                                ),
                                buttonElevation: 0,
                                itemHeight: 30,
                                itemPadding: const EdgeInsets.only(
                                    left: 1, right: 1, top: 0, bottom: 0),
                                dropdownWidth: 55.w,
                                dropdownMaxHeight: 100.h,
                                dropdownPadding: null,
                                //EdgeInsets.all(1),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                  color: Colors.grey.shade100,
                                ),
                                offset: const Offset(0, 0),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  // Select Skill Level dropdown container
                  Padding(
                    padding: EdgeInsets.only(top: 2.2.h, left: 4.w, right: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: 50.w,
                          child: Text(
                            'Skill Level',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 11.sp,
                              color: const Color(0XFF1F1F39),
                            ),
                          ),
                        ),
                        DropdownButton2(
                          dropdownElevation: 5,
                          isExpanded: true,
                          hint: const Text(
                            'Select',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          selectedItemHighlightColor: Colors.lightGreen,
                          underline: Container(),
                          items: items
                              .map((items) => DropdownMenuItem<String>(
                                    value: items,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        items ?? "",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue1,
                          onChanged: (value1) {
                            setState(() {
                              selectedValue1 = value1.toString();
                              debugPrint("selectedValue1:: $selectedValue1");
                              GetMcqList();
                            });
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          iconSize: 30,
                          iconEnabledColor: Colors.black,
                          buttonHeight: 3.9.h,
                          buttonWidth: 55.w,
                          buttonPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: const Color(0XFFF1F1F1)),
                            color: Colors.white,
                          ),
                          buttonElevation: 0,
                          itemHeight: 30,
                          itemPadding: const EdgeInsets.only(
                              left: 1, right: 1, top: 0, bottom: 0),
                          dropdownWidth: 55.w,
                          dropdownMaxHeight: 100.h,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                            color: Colors.grey.shade100,
                          ),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  // Divider
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w),
                    child: const Divider(
                      thickness: 1,
                      color: Config.mainBorderColor,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  //Instructions
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w),
                    child: Container(
                      width: 95.w,
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Color(0xffFFFFFF)),
                          color: Color(0xfff3f7f4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Per Text
                          Text(
                            "Per Test #20 MCQs | #Time 10 minutes",
                            style: TextStyle(
                                color: Color(0xff8B0A0A),
                                fontSize: Config.font_size_12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          //Test rules
                          Text(
                            'Test Rules:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Config.font_size_12.sp,
                                color: Config.primaryTextColor),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          //1
                          Text(
                            '1.On selection will launch Test page ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: Config.font_size_12.sp,
                                color: Config.primaryTextColor),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          //2
                          Text(
                            '2.Timer starts Instantly; Use ‘Pause’ to'
                            ' halt /short break; ‘End’ to Submit Test & Ex ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: Config.font_size_12.sp,
                                color: Config.primaryTextColor),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          //3
                          Text(
                            '3.Each Test # 20 Questions # Time 10 minutes',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: Config.font_size_12.sp,
                                color: Config.primaryTextColor),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  //ListViewBuilder
                  (mcqList.isEmpty)
                      ? Center(
                          child: Container(
                            child: Text(
                              "Please Select Branch And Skill Level To Get MCQ TEST List",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade400),
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mcqList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MockPageViewBuilder(
                                        totalList: mcqList,
                                        id: mcqList[index].mcqId.toString(),
                                        title: mcqList[index]
                                            .mcqTitle
                                            .toString())));
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => MockTestScreen(
                                //         id: mcqList[index].mcqId.toString(),
                                //         title:
                                //             mcqList[index].mcqTitle.toString())));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 4.w, right: 4.w, top: 1.w),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 3.w,
                                      right: 1.w,
                                      top: 3.w,
                                      bottom: 3.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${mcqList[index].mcqTitle}",
                                        style: TextStyle(
                                          fontSize: Config.font_size_12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      InkWell(
                                        // onTap: () {
                                        //   Navigator.of(context).push(
                                        //       MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               MockTestScreen(
                                        //                   id: mcqList[index]
                                        //                       .mcqId
                                        //                       .toString(),
                                        //                   title: mcqList[index]
                                        //                       .mcqTitle
                                        //                       .toString())));
                                        // },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Image.asset(
                                              'assets/images/DoubleArrowIcon.png',
                                              width: 3.w),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: PaginationWidget(
            numOfPages: numberOfPages(),
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
}
