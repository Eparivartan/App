import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import 'college_information1.dart';
import 'our_recommendations.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  int selectedPage = 1;

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
  var jsonData;

  @override
  void initState(){
    loadJson();
    searchResultList(0);
    super.initState();
  }

  //GET CALL >>>>>>>>>

  Future searchResultList(from) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString('userId') ?? '';
    debugPrint("came with UserId to Search Page : $userId");

    final response = await http.get(Uri.parse('${Config.baseURL}my-profile/$userId'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      jsonData = jsonDecode(response.body);
      debugPrint("Profile Details ++ ${jsonData}");
    }else{
      debugPrint('get call error');
    }
  }

  pageList(page) {
    switch(page){
      case 1:
        searchResultList(0);
        break;
      case 2:
        searchResultList(5);
        break;
      case 3:
        searchResultList(10);
        break;
      case 4:
        searchResultList(15);
        break;
      case 5:
        searchResultList(20);
        break;
      case 6:
        searchResultList(25);
        break;
      case 7:
        searchResultList(30);
        break;
      case 8:
        searchResultList(35);
        break;
      case 9:
        searchResultList(40);
        break;
      case 10:
        searchResultList(45);
        break;
      case 11:
        searchResultList(50);
        break;
      case 12:
        searchResultList(55);
        break;
      case 13:
        searchResultList(60);
        break;
      case 14:
        searchResultList(65);
        break;
      case 15:
        searchResultList(70);
        break;
      case 16:
        searchResultList(75);
        break;
      case 17:
        searchResultList(80);
        break;
      case 18:
        searchResultList(85);
        break;
      case 19:
        searchResultList(90);
        break;
      case 20:
        searchResultList(95);
        break;
      default:
        searchResultList(100);
    }
  }

  Future loadJson() async{
    String jsonString = await rootBundle.loadString('assets/files/searchResult.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      info = jsonMap["info"];
      Title = jsonMap['title'];
      sub = jsonMap['sub'];
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
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(preferredSize: Size.fromHeight(7.3.h),
          child: App_Bar_widget1(title: 'Educational Institutions / \n' ' University courses',
          ),
        ),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: Center(
            child: ListView(
              children: [
                Image.asset('assets/images/collegeInformation.png',),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 19,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your search, Our results!!',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.refresh_outlined,
                            color: Color(0xff333333),
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Search again',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
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
                        border: InputBorder.none,
                        hintText: '   Refine your search',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,bottom: 27),
                  child: Text('Ex: college name, university, PIN, code, location..',
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 9.sp,
                    ),
                  ),
                ),
                ListView.builder(
                    itemCount: info?.length?? 0,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 15,top: 5,right: 15),
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
                                  Text(info?[index]["title"] ?? '',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff333333),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(info?[index]["sub"] ?? '',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      // fontWeight: FontWeight.bold,
                                      color: const Color(0xff999999),
                                    ),
                                  ),
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
                                          Text(
                                            info?[index]["title1"] ?? '',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 60),
                                            child: Text(
                                              info?[index]["data1"] ?? '',
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
                                          Text(
                                            info?[index]["title2"] ?? '',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 31,),
                                            child: Text(
                                              info?[index]["data2"] ?? '',
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
                                          Text(
                                            info?[index]["title3"] ?? '',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 33),
                                            child: Text(
                                              info?[index]["data3"] ?? '',
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
                                          Text(
                                            info?[index]["title4"] ?? '',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 38),
                                            child: Text(
                                              info?[index]["data4"] ?? '',
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
                                          Text(
                                            info?[index]["title5"] ?? '',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 18),
                                            child: Text(
                                              info?[index]["data5"] ?? '',
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
                                          Text(
                                            info?[index]["title6"] ?? '',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 42),
                                            child: Text(
                                              info?[index]["data6"] ?? '',
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
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 15),
                  child: Divider(
                    color: Color(0xffcccccc),
                  ),
                ),
                InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> OurRecommendations()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 27,bottom: 20),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 38.h,
                                width: 14.9.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xffffffff),
                                ),
                                child: Image.asset('assets/images/recomendationIcon.png'),
                              ),
                              Text('Click for our Recommendations',
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 11.sp,
                                ),
                              ),
                              Image.asset('assets/images/thumb.png'),
                              // Icon(Icons.thumb_up_alt_outlined,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
