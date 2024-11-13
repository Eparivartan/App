import 'dart:convert';
import 'package:careercoach/Config.dart';
import 'package:careercoach/Home%20Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import '../Models/interviewPrepModel.dart';
import '../SqlLiteDB/db_helper.dart';
import '../Widgets/App_Bar_Widget.dart';
import 'package:http/http.dart' as http;

class InterviewPrep extends StatefulWidget {
  const InterviewPrep({Key? key}) : super(key: key);

  @override
  State<InterviewPrep> createState() => _InterviewPrepState();
}

class _InterviewPrepState extends State<InterviewPrep> {
  List? tile;
  String? head;
  List? pagees;
  List<InterviewPrepModel> interviewPrepItems = [];

  Future InterviewPrepDetailList() async {
    final response =
        await http.get(Uri.parse('${Config.baseURL}listinterviewcategories'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["interviewcategories"];

      setState(() {
        interviewPrepItems = jsonData
                .map<InterviewPrepModel>(
                    (data) => InterviewPrepModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data headers, $jsonData');
      debugPrint('printing header List, ${interviewPrepItems}');
    } else {
      debugPrint('get call error');
    }
  }

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "Interview Prep",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  @override
  void initState() {
    InterviewPrepDetailList();
    getData();
    saveToRecent();
    super.initState();
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/interviewPrep.json');
    debugPrint("Checking map : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map: $jsonMap");
    setState(() {
      tile = jsonMap["Data"];
      pagees = jsonMap["pages"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.3.h),
          child: const App_Bar_widget1(title: 'Interview Prep')),
      body: (interviewPrepItems.isEmpty)
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
                Image.asset('assets/images/interprep.png'),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: interviewPrepItems?.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 5.0, right: 5, bottom: 5, top: 5),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Config.gradientBottom),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Container(
                                          width: 55.w,
                                          child: Text(
                                            interviewPrepItems[index].catname ??
                                                '',
                                            style: TextStyle(
                                                fontSize:
                                                    Config.font_size_12.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        (interviewPrepItems[index].catimage ==
                                                    null ||
                                                interviewPrepItems[index]
                                                        .catimage ==
                                                    '')
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
                                                      radius: 15,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Image.network(
                                                "${Config.imageURL}${interviewPrepItems[index].catimage}",
                                                height: 7.88.h,
                                                width: 25.w,
                                              ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, pagees?[index]['page'] ?? '/');
                                  },
                                  //  onTap: (){
                                  //   Navigator.push(context,MaterialPageRoute(builder: (context)=> MockTests(),));
                                  //  },
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
