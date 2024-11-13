import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Models/interviewPrepModel.dart';
import '../Models/softwareInUseModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'interviewPrep.dart';

class TechQuestions extends StatefulWidget {
  const TechQuestions({Key? key}) : super(key: key);

  @override
  State<TechQuestions> createState() => _TechQuestionsState();
}

class _TechQuestionsState extends State<TechQuestions> {
  String? head;
  List? Query;
  String?dataa;
  String? _Value1;
  String? drophead;
  List<InterviewTypeModel> techQuestions = [];
  List<BranchDropdownModel> branchDropdown = [];
  int selectedPage = 1;
  List<InterviewTypeModel> mechTechQue = [];
  List<InterviewTypeModel> arctecTechQue = [];
  List<InterviewTypeModel> civilTechQue = [];



  //Get Call
  InterviewTypeDetailList(val, from) async{
    final response1 = await http.get(Uri.parse('${Config.baseURL}questionbank/$val/$from/5'));
    final response2 = await http.get(Uri.parse('${Config.baseURL}questionbank/$val/$from/5'));
    final response3 = await http.get(Uri.parse('${Config.baseURL}questionbank/$val/$from/5'));
    // https://psmprojects.net/cadworld/questionbank/1/0/5
    if(response1.statusCode == 200){
      var jsonData = jsonDecode(response1.body)["questionbank"];
      setState(() {
        mechTechQue = jsonData.map<InterviewTypeModel>((data)=>InterviewTypeModel.fromJson(data)).toList();
        debugPrint("printing The VALUE OF the MechTechQue : ${mechTechQue.length}");
        debugPrint("printing The VALUE OF the MechTechQue : ${mechTechQue}");
        // for(var i = 0 ; i < techQuestions.length; i++){
        //   if(techQuestions[i].postType == 3){
        //     mechTechQue.add(techQuestions[i]);
        //     // debugPrint("printing The VALUE OF the MechTechQue : $mechTechQue");
        //   }
        // }
      });

      debugPrint("printing The VALUE OF the MechTechQue : $mechTechQue");

      debugPrint('GetCall in questionbank was Success');
      debugPrint('printing questionbank json data headers, $jsonData');
      // debugPrint('printing header List, ${techQuestions}');
    }
    else{
      debugPrint('get call error');
    }
    if(response2.statusCode == 200){
      var jsonData = jsonDecode(response2.body)["questionbank"];
      setState(() {
        arctecTechQue = jsonData.map<InterviewTypeModel>((data)=>InterviewTypeModel.fromJson(data)).toList();
        debugPrint("printing The VALUE OF the arctecTechQue : ${arctecTechQue.length}");
        debugPrint("printing The VALUE OF the arctecTechQue : ${arctecTechQue}");
        // for(var i = 0 ; i < techQuestions.length; i++){
        //   if(techQuestions[i].postType == 3){
        //     mechTechQue.add(techQuestions[i]);
        //     // debugPrint("printing The VALUE OF the MechTechQue : $mechTechQue");
        //   }
        // }
      });

      debugPrint("printing The VALUE OF the MechTechQue : $mechTechQue");

      debugPrint('GetCall in questionbank was Success');
      debugPrint('printing questionbank json data headers, $jsonData');
      // debugPrint('printing header List, ${techQuestions}');
    }
    else{
      debugPrint('get call error');
    }
    if(response3.statusCode == 200){
      var jsonData = jsonDecode(response3.body)["questionbank"];
      setState(() {
        civilTechQue = jsonData.map<InterviewTypeModel>((data)=>InterviewTypeModel.fromJson(data)).toList();
        debugPrint("printing The VALUE OF the civilTechQue : ${civilTechQue.length}");
        debugPrint("printing The VALUE OF the civilTechQue : ${civilTechQue}");
        // for(var i = 0 ; i < techQuestions.length; i++){
        //   if(techQuestions[i].postType == 3){
        //     mechTechQue.add(techQuestions[i]);
        //     // debugPrint("printing The VALUE OF the MechTechQue : $mechTechQue");
        //   }
        // }
      });

      debugPrint("printing The VALUE OF the MechTechQue : $mechTechQue");

      debugPrint('GetCall in questionbank was Success');
      debugPrint('printing questionbank json data headers, $jsonData');
      // debugPrint('printing header List, ${techQuestions}');
    }
    else{
      debugPrint('get call error');
    }
  }

  Future getDetailsDrpDwn() async{

    final response = await http.get(Uri.parse('${Config.baseURL}listcategory'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["categories"];
      // selectedValue1==null;
      // debugPrint("null:: ${selectedValue1}");
      // debugPrint("null:123: ${selectedValue}");
      setState(() {
        branchDropdown = jsonData.map<BranchDropdownModel>((data) =>BranchDropdownModel.fromJson(data)).toList() ?? [];
      });
      debugPrint('GetCall Success for get_Details');
      debugPrint('printing json data, $jsonData');
    }else{
      debugPrint('getDetails get call error');
    }
  }

  // getQuestionBankList(from) async{
  //   final response = await http.get(Uri.parse('https://psmprojects.net/cadworld/listjobtypes/$from/5'));
  //   if(response.statusCode == 200){
  //     var jsonData = jsonDecode(response.body)["listjobtypes"];
  //     setState(() {
  //       fresherJobTypesList = jsonData.map<TechnologyFresherProfessionalModel>((data)=>TechnologyFresherProfessionalModel.fromJson(data)).toList();
  //     });
  //   }else{
  //     debugPrint('getDetailsJob get call error');
  //   }
  // }
  //
  // numberOfPages() {
  //   double pgNum = Query?.length/5;
  //   return pgNum.ceil();
  // }
  //
  // pageList1(page) {
  //   switch(page){
  //     case 1:
  //       getDetailsJobList(0);
  //       break;
  //     case 2:
  //       getDetailsJobList(5);
  //       break;
  //     case 3:
  //       getDetailsJobList(10);
  //       break;
  //     case 4:
  //       getDetailsJobList(15);
  //       break;
  //     case 5:
  //       getDetailsJobList(20);
  //       break;
  //     case 6:
  //       getDetailsJobList(25);
  //       break;
  //     case 7:
  //       getDetailsJobList(30);
  //       break;
  //     case 8:
  //       getDetailsJobList(35);
  //       break;
  //     case 9:
  //       getDetailsJobList(40);
  //       break;
  //     case 10:
  //       getDetailsJobList(45);
  //       break;
  //     case 11:
  //       getDetailsJobList(50);
  //       break;
  //     case 12:
  //       getDetailsJobList(55);
  //       break;
  //     case 13:
  //       getDetailsJobList(60);
  //       break;
  //     case 14:
  //       getDetailsJobList(65);
  //       break;
  //     case 15:
  //       getDetailsJobList(70);
  //       break;
  //     case 16:
  //       getDetailsJobList(75);
  //       break;
  //     case 17:
  //       getDetailsJobList(80);
  //       break;
  //     case 18:
  //       getDetailsJobList(85);
  //       break;
  //     case 19:
  //       getDetailsJobList(90);
  //       break;
  //     case 20:
  //       getDetailsJobList(95);
  //       break;
  //     default:
  //       getDetailsJobList(100);
  //   }
  // }

  // paginationList() {
  //   return PaginationWidget(
  //     numOfPages: numberOfPages(),
  //     selectedPage: selectedPage,
  //     pagesVisible: 3,
  //     spacing: 0,
  //     onPageChanged: (page) {
  //       debugPrint("Sending page $page");
  //       pageList1(page);
  //       setState(() {
  //         selectedPage = (page);
  //       });
  //     },
  //     nextIcon: const Icon(
  //       Icons.arrow_forward_ios,
  //       size: 12,
  //       color: Color(0xff000000),
  //     ),
  //     previousIcon: const Icon(
  //       Icons.arrow_back_ios,
  //       size: 12,
  //       color: Color(0xff000000),
  //     ),
  //     activeTextStyle: TextStyle(
  //       color: const Color(0xffffffff),
  //       fontSize: 11.sp,
  //       fontWeight: FontWeight.w700,
  //     ),
  //     activeBtnStyle: ButtonStyle(
  //       visualDensity: const VisualDensity(horizontal: -4),
  //       backgroundColor:
  //       MaterialStateProperty.all(
  //           const Color(0xff8cb93d)),
  //       shape: MaterialStateProperty.all(
  //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
  //       ),
  //       padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
  //       shadowColor: MaterialStateProperty.all(const Color(0xfff1f1f1),
  //       ),
  //     ),
  //     inactiveBtnStyle: ButtonStyle(
  //       padding: MaterialStateProperty.all(
  //           const EdgeInsets.all(20)),
  //       visualDensity:
  //       const VisualDensity(horizontal: 0),
  //       elevation:
  //       MaterialStateProperty.all(0),
  //       backgroundColor:
  //       MaterialStateProperty.all(
  //         const Color(0xfff9f9fb),
  //       ),
  //       shape: MaterialStateProperty.all(
  //         RoundedRectangleBorder(
  //           borderRadius:
  //           BorderRadius.circular(15),
  //           side: const BorderSide(
  //             color: Color(0xffffffff),
  //             width: 10,
  //           ),
  //         ),
  //       ),
  //     ),
  //     inactiveTextStyle: const TextStyle(
  //       fontSize: 15,
  //       color: Color(0xff333333),
  //       fontWeight: FontWeight.w700,
  //     ),
  //   );
  // }

  Future getData() async{
    String jsonString = await rootBundle.loadString('assets/files/TechQuess.json');
    debugPrint("Checking json: $jsonString");
    Map<String,dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map: $jsonMap");
    setState(() {
      Query=jsonMap['Tech'];
      dataa=jsonMap['info'];
      drophead=jsonMap['drop'];
    });
  }

  void _handleTabSelection() {
    setState(() {
      debugPrint('Tapped on tab && tab Changes');
      // getDetails();
      // paginationList();
      selectedPage = 1;
    });
  }

  /*pageList(page) {
    switch(page){
      case 1:
        technologyTrends(0);
        break;
      case 2:
        technologyTrends(5);
        break;
      case 3:
        technologyTrends(10);
        break;
      case 4:
        technologyTrends(15);
        break;
      case 5:
        technologyTrends(20);
        break;
      case 6:
        technologyTrends(25);
        break;
      case 7:
        technologyTrends(30);
        break;
      case 8:
        technologyTrends(35);
        break;
      case 9:
        technologyTrends(40);
        break;
      case 10:
        technologyTrends(45);
        break;
      case 11:
        technologyTrends(50);
        break;
      case 12:
        technologyTrends(55);
        break;
      case 13:
        technologyTrends(60);
        break;
      case 14:
        technologyTrends(65);
        break;
      case 15:
        technologyTrends(70);
        break;
      case 16:
        technologyTrends(75);
        break;
      case 17:
        technologyTrends(80);
        break;
      case 18:
        technologyTrends(85);
        break;
      case 19:
        technologyTrends(90);
        break;
      case 20:
        technologyTrends(95);
        break;
      default:
        technologyTrends(100);
    }
  }

  paginationList() {
    if(_controller.index==0)
    {
      pageList(0);
      return PaginationWidget(
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
      );
    }
    else if (_controller.index ==1)
    {
      pageList(0);
      technologyTrendsList1.clear();
      technologyTrendsList3.clear();
      return PaginationWidget(
        numOfPages: numberOfPages2(),
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
          color: selectedPage == numberOfPages2() ? Colors.grey : Color(0xff000000),
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
      );
    }
    else if (_controller.index ==2)
    {
      pageList(0);
      technologyTrendsList1.clear();
      technologyTrendsList2.clear();
      return PaginationWidget(
        numOfPages: numberOfPages3(),
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
          color: selectedPage == numberOfPages3() ? Colors.grey : Color(0xff000000),
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
      );
    }
  }

  numberOfPages1() {
    double pgNum = listlatesttech.length/5;
    return pgNum.ceil();
  }

  numberOfPages2() {
    double pgNum = listsoftwarereleases.length/5;
    return pgNum.ceil();
  }

  numberOfPages3() {
    double pgNum = sotwareversions.length/5;
    return pgNum.ceil();
  }
  */


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // InterviewTypeDetailList(0);
    getDetailsDrpDwn();
    getData();
  }

  final List<String>items=[
    'All',
    'Mechanical',
    'Civil',
    'Architecture'
  ];


  String? selectedValue;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:Size.fromHeight(8.h),
        child: App_Bar_widget1(title :head?? 'Question Bank\n(Technical)'),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (dataa==null) ?
        Center(
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
        ) :
        ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(2.w),
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text( dataa ?? '',
                        textAlign:TextAlign.justify,
                        style: TextStyle(fontSize: 11.sp),),
                    ),
                  ),
                  //dropdown
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Branch",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Config.font_size_12.sp
                          ),),
                        (branchDropdown.length == 0)?
                        Center(
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
                        ) :
                        DropdownButton2(
                          dropdownElevation: 5,
                          isExpanded: true,
                          hint: Text(' Select',
                            style: TextStyle(
                              fontSize: Config.font_size_12.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          selectedItemHighlightColor: Colors.lightGreen,
                          underline: Container(),
                          items: branchDropdown.map((item) => DropdownMenuItem<String>(
                            value: item.id,
                            child: Column(
                              children: [
                                SizedBox(height: 0.8.h,),
                                //Divider(thickness: 2,),
                                Padding(
                                  padding: EdgeInsets.only(left: 1.w),
                                  child: Text( "${item.cname}" ?? "",textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                //Divider(color: Colors.black,),
                              ],
                            ),
                          ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                              debugPrint("printing the selected value: $selectedValue");
                              // getDropdownValue();
                              InterviewTypeDetailList(selectedValue, 0);
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down_outlined,size: 5.w,),
                          iconSize: 30,
                          iconEnabledColor: Colors.black,
                          buttonHeight: 4.h,
                          buttonWidth: 68.5.w,
                          buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1,color: Config.mainBorderColor),
                            color: Colors.white,
                          ),
                          buttonElevation: 0,
                          itemHeight: 30,
                          itemPadding: const EdgeInsets.only(left: 1, right: 1, top: 0, bottom: 0),
                          dropdownWidth: 68.5.w,
                          dropdownMaxHeight: 100.h,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.grey.shade100,
                          ),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                 /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Branch',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      DropdownButton2(
                        dropdownElevation: 5,
                        isExpanded: true,
                        hint: const Text('All',
                          style: TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        selectedItemHighlightColor: Colors.lightGreen,
                        underline: Container(),
                        items: branchDropdown.map((item) => DropdownMenuItem<String>(
                          value: item.cname,
                          child: Column(
                            children: [
                              SizedBox(height: 1.h,),
                              //Divider(thickness: 2,),
                              Padding(
                                padding: EdgeInsets.only(left: 3.w),
                                child: Text( item.cname.toString(),
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              //Divider(color: Colors.black,),
                            ],
                          ),
                        ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        iconSize: 30,
                        iconEnabledColor: Colors.black,
                        //barrierColor: Colors.green.withOpacity(0.2),
                        // iconDisabledColor: Colors.grey,
                        buttonHeight: 5.h,
                        buttonWidth: 65.06.w,
                        buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black26),
                          color: Colors.white,
                        ),
                        buttonElevation: 0,
                        itemHeight: 30,
                        itemPadding: const EdgeInsets.only(left: 1, right: 1, top: 0, bottom: 0),
                        dropdownWidth: 65.06.w,
                        dropdownMaxHeight: 100.h,
                        dropdownPadding: null,
                        //EdgeInsets.all(1),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.grey.shade100,
                        ),
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),*/
                  Divider(),
                  (selectedValue == null) ?
                  Center(child: Container(child: Center(child: Text(" please select any value from drop down ")),)) :
                  (selectedValue == "1") ?
                  (mechTechQue.length == 0) ?
                  Center(
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
                  ) :
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      //const NeverScrollableScrollPhysics(),
                      itemCount: mechTechQue?.length,
                      itemBuilder: (context, index) {
                        return (civilTechQue.length == 0) ?
                        Center(
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
                        ) :
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            border: Border.all(color: Config.containerColor),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              iconColor: Colors.black,
                              collapsedBackgroundColor: Colors.white,
                              backgroundColor :Config.containerColor,
                              title: Text(
                                mechTechQue?[index].postTitle ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: Config.font_size_12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Config.primaryTextColor
                                ),
                              ),
                              // trailing: const Icon(Icons
                              //     .keyboard_arrow_down_outlined,color: Config.primaryTextColor,),
                              children: [
                                Divider(thickness: 1,color: Config.gradientBottom,),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      top: 0,
                                      bottom: 8,
                                      left: 16,
                                      right: 14),
                                  child:Text(mechTechQue?[index].postContent??'',
                                    style: TextStyle(fontSize: 11.sp,
                                        color: Config.primaryTextColor),),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      ) :
                  (selectedValue == "2") ?
                  (arctecTechQue.length == 0) ?
                  Center(
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
                  ) :
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      //const NeverScrollableScrollPhysics(),
                      itemCount: arctecTechQue?.length,
                      itemBuilder: (context, index) {
                        return (civilTechQue.length == 0) ?
                        Center(
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
                        ) :
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            border: Border.all(color: Config.containerColor),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              iconColor: Colors.black,
                              collapsedBackgroundColor: Colors.white,
                              backgroundColor :Config.containerColor,
                              title: Text(
                                arctecTechQue?[index].postTitle ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: Config.font_size_12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Config.primaryTextColor
                                ),
                              ),
                              // trailing: const Icon(Icons
                              //     .keyboard_arrow_down_outlined,color: Config.primaryTextColor,),
                              children: [
                                Divider(thickness: 1,color: Config.gradientBottom,),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      top: 0,
                                      bottom: 8,
                                      left: 16,
                                      right: 14),
                                  child:Text(arctecTechQue?[index].postContent??'',
                                    style: TextStyle(fontSize: 11.sp,
                                        color: Config.primaryTextColor),),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ) :
                  (selectedValue == "3") ?
                  (civilTechQue.length == 0) ?
                  Center(
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
                  ) :
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      //const NeverScrollableScrollPhysics(),
                      itemCount: civilTechQue?.length,
                      itemBuilder: (context, index) {
                        return (civilTechQue.length == 0) ?
                        Center(
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
                        ) :
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            border: Border.all(color: Config.containerColor),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              iconColor: Colors.black,
                              collapsedBackgroundColor: Colors.white,
                              backgroundColor :Config.containerColor,
                              title: Text(
                                civilTechQue?[index].postTitle ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: Config.font_size_12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Config.primaryTextColor
                                ),
                              ),
                              // trailing: const Icon(Icons
                              //     .keyboard_arrow_down_outlined,color: Config.primaryTextColor,),
                              children: [
                                Divider(thickness: 1,color: Config.gradientBottom,),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      top: 0,
                                      bottom: 8,
                                      left: 16,
                                      right: 14),
                                  child:Text(civilTechQue?[index].postContent??'',
                                    style: TextStyle(fontSize: 11.sp,
                                        color: Config.primaryTextColor),),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ) :
                  Container( child: Text("NOTHING TO SHOW"),)
                ],
              ),
            ),

            /*Padding(
              padding: const EdgeInsets.only(left: 8,right: 7,top: 8,bottom: 30),
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffDBEBE2)),
                    borderRadius: BorderRadius.circular(8), color: Color(0xffF3F6F4)),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Like what you see? Further training needs?'
                          'reach us below:',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.sp, height: 1.5),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 1.w,),
                        Image.asset('assets/images/call.png',height: 2.5.h,),
                        SizedBox(width: 1.w,),
                        Text("   +91 9X9X9X9X9X; 040-24892489"),
                      ],
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 1.w,),
                        Icon(Icons.mail,size: 20.sp,),
                        SizedBox(width: 2.8.w,),
                        Text('support@cadcareercoach.com\nenquiry@gmail.com'),
                      ],
                    ),

                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 25.h,
            child: Column(
              children: [
                Container(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 7,top: 8,bottom: 30),
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffDBEBE2)),
                        borderRadius: BorderRadius.circular(8), color: Color(0xffF3F6F4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Like what you see? Further training needs?'
                              'reach us below:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.sp, height: 1.5),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 1.w,),
                            Image.asset('assets/images/call.png',height: 2.5.h,),
                            SizedBox(width: 1.w,),
                            Text("   +91 9X9X9X9X9X; 040-24892489"),
                          ],
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 1.w,),
                            Column(
                              children: [
                                Icon(Icons.mail,size: 20.sp,),
                              ],
                            ),
                            SizedBox(width: 3.w,),
                            Column(
                              children: [
                                Text('support@cadcareercoach.com\nenquiry@gmail.com'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        // (engineeringBranches.length > 5) ? paginationList() : null,
      ),

    );
  }
}
