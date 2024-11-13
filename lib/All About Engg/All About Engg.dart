import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Models/allAboutEngineeringModel.dart';
import '../Models/headerModel.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/App_Bar_Widget.dart';

class AllAboutEngineers extends StatefulWidget {
  const AllAboutEngineers({Key? key}) : super(key: key);

  @override
  State<AllAboutEngineers> createState() => _AllAboutEngineersState();
}

class _AllAboutEngineersState extends State<AllAboutEngineers> {
  List? data;
  String? head;
  String? sub;
  String? imagee;
  String? logo;
  List? pages;
  List<AllAboutEngineersModel> branchTypes = [];
  List<headerModel> headerList = [];
  List<String> recentlyViewList = [];
  String? recentlyViewed;

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "All About Engineering",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  @override
  void initState() {
    getData();
    getDetails();
    saveToRecent();
    HeaderList();
    super.initState();
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
      debugPrint('printing header List, ${headerList[6].headerName}');
    } else {
      debugPrint('get call error');
    }
  }

  Future getDetails() async {
    final response =
        await http.get(Uri.parse('${Config.baseURL}allaboutengcategory'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];
      recentlyViewList.add("AllAboutEngineers");
      debugPrint("Recently Viewed: --->  ${recentlyViewList}");
      recentlyViewed = jsonEncode(recentlyViewList);
      debugPrint("Recently Viewed: --->  ${recentlyViewed}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("recentView", "${recentlyViewed}");

      setState(() {
        branchTypes = jsonData
                .map<AllAboutEngineersModel>(
                    (data) => AllAboutEngineersModel.fromJson(data))
                .toList() ??
            [];
        //  Map<String, dynamic> extractData = jsonDecode(response.body);
        //  FresherJobTypes = extractData["recordset"];
        //  var showLoading = false;
      });
      debugPrint("branchTypes Viewed: --->  ${branchTypes}");
      debugPrint("branchTypes Viewed: --->  ${branchTypes.runtimeType}");
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json Model, $AllAboutEngineersModel');
    } else {
      debugPrint('get call error');
    }
    debugPrint("Fresher2Industry123 : $branchTypes");
    // debugPrint("Service Details : $serviceDetails");
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/AllAbtEnggPG.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      data = jsonMap["details"];
      head = jsonMap['main'];
      sub = jsonMap["sub"];
      imagee = jsonMap["Immage"];
      logo = jsonMap["logoo"];
      pages = jsonMap["paages"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget(title: head ?? ''),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (branchTypes.isEmpty || headerList.isEmpty)
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
                  Image.asset(
                    "assets/images/AllAboutEngg.png",
                    height: 19.7.h,
                    width: 100.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 2.h, bottom: 2.h, right: 4.w, left: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          headerList.isNotEmpty
                              ? (headerList[11].headerName ?? '')
                              : '',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Config.primaryTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          headerList.isNotEmpty
                              ? (headerList[11].headerContent ?? '')
                              : '',
                          textAlign: TextAlign.justify,
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                        SizedBox(height: 1.h),
                        (branchTypes.isEmpty)
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
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: branchTypes.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 1.5.h),
                                      child: Container(
                                        width: 91.73,
                                        height: 7.8.h,
                                        margin: const EdgeInsets.all(1),
                                        // padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Config.mainBorderColor),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.w),
                                              child: SizedBox(
                                                width: 50.w,
                                                child: Text(
                                                  branchTypes[index].catname ??
                                                      '',
                                                  style: TextStyle(
                                                    color:
                                                        Config.primaryTextColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 7.8.h,
                                              width: 26.6.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0,
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.w),
                                                child: Image.network(
                                                    Config.imageURL +
                                                        branchTypes[index]
                                                            .catimage
                                                            .toString(),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          pages?[index]['page'] ?? '/');
                                    },
                                  );
                                })
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
