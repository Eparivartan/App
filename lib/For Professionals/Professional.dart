import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../Config.dart';
import '../Models/TechnologyFresherProfessionalModel.dart';
import '../Models/headerModel.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'Professional Dec.dart';

class Professionals extends StatefulWidget {
  const Professionals({Key? key}) : super(key: key);

  @override
  State<Professionals> createState() => _ProfessionalsState();
}

class _ProfessionalsState extends State<Professionals> {

  String? Img;
  String? Title;
  String? Title1;
  String? Picture;
  String? Data;
  List? Details;
  List<TechnologyFresherProfessionalModel> professional = [];
  List professionalList = [];
  List<headerModel> headerList = [];


  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  numberOfPages() {
    double pgNum = professional.length/5;
    return pgNum.ceil();
  }

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "For Professionals",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }


  @override
  void initState(){
    forProfessionalList(0);
    saveToRecent();
    professionalList;
    getDetails();
    HeaderList();
    super.initState();
  }

  Future HeaderList() async{

    final response = await http.get(Uri.parse('${Config.baseURL}listheaders'));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["categories"];

      setState(() {
        headerList = jsonData.map<headerModel>((data) =>headerModel.fromJson(data)).toList() ?? [];

      });
      debugPrint('GetCall Success');
      debugPrint('printing json data headers, $jsonData');
      debugPrint('printing header List, ${headerList[2].headerName}');
    }else{
      debugPrint('get call error');
    }
  }


  Future getDetails() async{

    final response = await http.get(Uri.parse('${Config.baseURL}forprofessionals/0/50'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["proffessionals"];

      setState(() {
        professional = jsonData.map<TechnologyFresherProfessionalModel>((data) =>TechnologyFresherProfessionalModel.fromJson(data)).toList() ?? [];
        //  Map<String, dynamic> extractData = jsonDecode(response.body);
        //  FresherJobTypes = extractData["recordset"];
        //  var showLoading = false;
      });
      forProfessionalList(0);
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json Model, $TechnologyFresherProfessionalModel');
    }else{
      debugPrint('get call error');
    }
    //debugPrint("Fresher2Industry123 : $professional");
    // debugPrint("Service Details : $serviceDetails");

  }

  forProfessionalList(from) async{
    professionalList.clear();
    final response = await http.get(Uri.parse('${Config.baseURL}forprofessionals/$from/5'));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["proffessionals"];
      setState(() {
        professionalList = jsonData.map<TechnologyFresherProfessionalModel>((data)=>TechnologyFresherProfessionalModel.fromJson(data)).toList();
      });

    }else{
      debugPrint('getDetailsJob get call error');
    }
  }

  pageList(page) {
    switch(page){
      case 1:
        forProfessionalList(0);
        break;
      case 2:
        forProfessionalList(5);
        break;
      case 3:
        forProfessionalList(10);
        break;
      case 4:
        forProfessionalList(15);
        break;
      case 5:
        forProfessionalList(20);
        break;
      case 6:
        forProfessionalList(25);
        break;
      case 7:
        forProfessionalList(30);
        break;
      case 8:
        forProfessionalList(35);
        break;
      case 9:
        forProfessionalList(40);
        break;
      case 10:
        forProfessionalList(45);
        break;
      case 11:
        forProfessionalList(50);
        break;
      case 12:
        forProfessionalList(55);
        break;
      case 13:
        forProfessionalList(60);
        break;
      case 14:
        forProfessionalList(65);
        break;
      case 15:
        forProfessionalList(70);
        break;
      case 16:
        forProfessionalList(75);
        break;
      case 17:
        forProfessionalList(80);
        break;
      case 18:
        forProfessionalList(85);
        break;
      case 19:
        forProfessionalList(90);
        break;
      case 20:
        forProfessionalList(95);
        break;
      default:
        forProfessionalList(100);
    }
  }

  Future loadJson() async{
    String jsonString = await rootBundle.loadString('assets/files/for_professionals.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      Img = jsonMap["img"];
      Title1 = jsonMap["text1"];
      Title = jsonMap["text"];
      Picture = jsonMap["pic"];
      Data = jsonMap["data"];
      Details = jsonMap["details"];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: const App_Bar_widget(title: "For Professionals\n(Career Enhancing guide)"),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (professional.isEmpty)
            ? const Center(
            child: CupertinoActivityIndicator(
            radius: 25,
            color: Colors.black,
          ),)
            : Center(
            child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0,right: 0),
                child: Image.asset('assets/images/fresher2ind.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text( headerList.isNotEmpty  ? (headerList[2].headerName ?? '') : '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 1.5.h,left: 4.w,right: 4.w),
                    child: Text(headerList.isNotEmpty ? (headerList[2].headerContent ?? '') : '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),),
                  ),
                  SizedBox(height: 1.h,),
                ],
              ),
              (professionalList.isEmpty) ?
              const Center(
                child: CupertinoActivityIndicator(
                  radius: 25,
                  color: Colors.black,
                ),
              ) :
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: professionalList.length,
                  itemBuilder: (context, index)
                  {
                    return Padding(
                      padding:  EdgeInsets.only(left: 4.w, right: 4.w, top: 1.h),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>ProfessionalDec(
                                  content:professionalList[index].postContent.toString() ?? '',
                                  title: professionalList[index].postTitle.toString() ?? '')));
                        },
                        child: Container(
                          height: 10.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1,color: Colors.grey.shade100),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 3.w,bottom: 0.5.h,top: 0.5.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 2.2.h,
                                  child: Text(professionalList[index].postTitle.toString() ?? '',
                                    style: TextStyle(
                                      // letterSpacing: 1,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 5.h,
                                      width: 70.w,
                                      child: Text(professionalList[index].postContent.toString() ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                          color: Colors.black
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 2.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 4.w),
                                          child: InkWell(
                                            child: Image.asset('assets/images/DoubleArrowIcon.png',width: 3.w),
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(builder: (context)=>ProfessionalDec(content:professional?[index].postContent.toString() ?? '', title: professional[index].postTitle.toString() ?? '')));
                                              },),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
              //Pagination

              // SizedBox(height: 1.w),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: SizedBox(
          height: 7.h,
          child: PaginationWidget(
            numOfPages: numberOfPages(),
            selectedPage: selectedPage,
            pagesVisible: 3,
            spacing: 0,
            onPageChanged: (page) {
              (professionalList.isEmpty)
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
              color: selectedPage == numberOfPages() ? Colors.grey : Color(0xff000000),
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
                  const EdgeInsets.all(10)
              ),
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
          ),
        ),
      ),
    );
  }
}
