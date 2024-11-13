/*
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/App_Bar_Widget.dart';
class MockTestMCQ extends StatefulWidget {
  const MockTestMCQ({super.key});

  @override
  State<MockTestMCQ> createState() => _MockTestMCQState();
}

class _MockTestMCQState extends State<MockTestMCQ> {
  List? data;
  int? selectedRadioValue;
  List<int> selectedValues = [];
  int _secondsLeft = 600;
  Timer? _timer;
  bool _isShow = true;

  @override
  void initState() {
    super.initState();
    loadData();
    startTimer();
    selectedRadioValue = null;
    // Savedata();
  }
  
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _timer?.cancel();
          _isShow = !_isShow;
        }
      });
    });
  }

  String timerDisplayString(values) {
    int minutes = values ~/ 60;
    int seconds = values % 60;
    return '$minutes m:${seconds.toString().padLeft(2, '0')} s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void handleRadioValuechange(int?  value) {
    setState(() {
      selectedRadioValue = value!;
      debugPrint('$selectedRadioValue');
      selectedValues.add(value); // Add the selected value to the list
    });
  }

  Future loadData() async {
    debugPrint('im here');
    // debugPrint ('${data?[0]["que"]}');
    String jsonString = await rootBundle.loadString('assets/files/question.json');
    Map<String, dynamic>jsonMap = jsonDecode(jsonString);
    setState(() {
      data = jsonMap["data"];
    });
    debugPrint('$data');
    // Timer(const Duration(seconds: 2),()=>loadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: const App_Bar_widget(title: 'MCQ'),
        ),
        body:SafeArea(
            child: ListView(
              padding: EdgeInsets.all(2.w),
                children: [
                  SizedBox(height:2.h),
                  Text('Fresher: MCQ Test1',
                    style: TextStyle(fontSize: 12.sp,
                      color: Color(0xff333333),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height:3.h),
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                          children: [
                            Container(
                              height: 25.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                color: Color(0xffF7F7F7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:  Column(
                                  children: [
                                    SizedBox(height: 1.h,),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 12.0),
                                        child: Text(data?[index]["que"] ?? '',
                                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    SizedBox(height:2.h),
                                    Padding(
                                      padding:  EdgeInsets.only(left: 5.sp,top:2.sp),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 20,
                                            child: RadioListTile(
                                              value: 1,
                                              groupValue: selectedRadioValue,

                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRadioValue = value!;
                                                  selectedValues.add(value);

                                                });
                                              },
                                              toggleable: true,),
                                          ),
                                          SizedBox(width:4.w),
                                          Text(data?[index]["op1"] ?? '',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(width:40.w),
                                          Container(
                                            height: 60,
                                            width: 20,
                                            child: RadioListTile(
                                              value: 2,
                                              groupValue: selectedRadioValue,

                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRadioValue = value!;
                                                  selectedValues.add(value);

                                                });
                                              },
                                              toggleable: true,),
                                          ),
                                          SizedBox(width:4.w),
                                          Text(
                                            data?[index]["op2"] ?? '',
                                            style: TextStyle(
                                                fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height:5.h),
                                    Padding(
                                      padding:  EdgeInsets.only(left: 8.sp,top:2.sp),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 20,
                                            child: RadioListTile(
                                              value: 3,
                                              groupValue: selectedRadioValue,

                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRadioValue = value!;
                                                  selectedValues.add(value);

                                                });
                                              },
                                              toggleable: true,),
                                          ),
                                          SizedBox(width:4.w),
                                          Text(
                                            data?[index]["op3"] ?? '',
                                            style: TextStyle(
                                                fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width:40.w),
                                          Container(

                                            height: 60,
                                            width: 30,
                                            child: RadioListTile(
                                              value: 4,
                                              groupValue: selectedRadioValue,

                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRadioValue = value!;
                                                  selectedValues.add(value);

                                                });
                                              },
                                              toggleable: true,),
                                          ),
                                          SizedBox(width:4.w),
                                          Text(
                                            data?[index]["op4"] ?? '',
                                            style: TextStyle(
                                                fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),

                            ),
                            SizedBox(height: 4.h,)
                          ],
                        );},),
                ]
            )
        ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade200,
        child: Container(
          height: 15.h,
          padding: EdgeInsets.all(2.w),
          child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height:10.h,
                        width:40.w,
                        child: Lottie.asset('assets/lotties/timer.json',
                            height: 3.h,width:5.w),
                    ),
                    // SizedBox(width: 2.w),
                    Container(
                      // height:10.h,
                      width:40.w,
                      child: Text(
                        timerDisplayString(_secondsLeft),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(width:10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.h,),
                    Container(
                      height:5.h,
                      width:40.w,
                      decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Row(
                          children: [
                            Image.asset('assets/images/start.png'),
                            SizedBox(width:3.w),
                            Center(child: Text('Start | Pause',style: TextStyle(fontSize: 12.sp))),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Container(
                      height:5.h,
                      width:40.w,
                      decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Row(
                          children: [
                            Image.asset('assets/images/dot123.png'),
                            SizedBox(width:3.w),
                            Center(child: Text('End & Submit',style: TextStyle(fontSize: 12.sp)

                            )) ],
                        ),
                      ),
                    )
                  ],
                )
              ]
          ),
        ),),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';

class MockTestScreen extends StatefulWidget {
  const MockTestScreen({Key? key}) : super(key: key);

  @override
  State<MockTestScreen> createState() => _MockTestScreenState();
}

class _MockTestScreenState extends State<MockTestScreen> {
  String _selection = '';
  String _selection1 = '';
  String _selection2 = '';

  List<List<String>> choices = [
    ["ABC", "AAB", "ACD"], // 1st qns has 3 choices
    ["AND", "CQA", "QWE", "QAL"], // 2nd qns has 4 choices
    ["ASD", "JUS", "JSB"] // 3rd qns has 3 choices
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: const App_Bar_widget(title: 'MCQ'),
      ),
      backgroundColor: Config.whiteColor,
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Question here1?'),
          Column(
            children: choices[0].map((item) {
              //change index of choices array as you need
              return RadioListTile(
                groupValue: _selection1,
                title: Text(item),
                value: item,
                activeColor: Colors.blue,
                onChanged: (val) {
                  print(val);
                  setState(() {
                    _selection1 = val!;
                  });
                },
              );
            }).toList(),
          ),
          Text('Question here2?'),
          Column(
            children: choices[0].map((item) {
              //change index of choices array as you need
              return RadioListTile(
                groupValue: _selection1,
                title: Text(item),
                value: item,
                activeColor: Colors.blue,
                onChanged: (val) {
                  print(val);
                  setState(() {
                    _selection1 = val!;
                  });
                },
              );
            }).toList(),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text('Question here?'),
                    GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: choices[0].map((item) {
                              //change index of choices array as you need
                              return RadioListTile(
                                groupValue: _selection1,
                                title: Text(item),
                                value: item,
                                activeColor: Colors.blue,
                                onChanged: (val) {
                                  print(val);
                                  setState(() {
                                    _selection1 = val!;
                                  });
                                },
                              );
                            }).toList(),
                          );
                        })
                  ],
                );
              }),
        ],
      ),
      // SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: ListView(
      //       children: [
      //         Text(
      //           "Fresher: MCQ Test1",
      //           style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               fontSize: Config.font_size_12.sp),
      //         ),
      //         ListView.builder(
      //             shrinkWrap: true,
      //             physics: ClampingScrollPhysics(),
      //             itemCount: 10,
      //             itemBuilder: (context, index) {
      //               return Padding(
      //                 padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(7),
      //                       border: Border.all(color: Colors.grey.shade200)),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Padding(
      //                         padding: const EdgeInsets.all(8.0),
      //                         child: Text(
      //                           "1) How many sides does Square have?",
      //                           textAlign: TextAlign.start,
      //                           style: TextStyle(
      //                               fontSize: Config.font_size_12.sp,
      //                               fontWeight: FontWeight.bold),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             })
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}*/

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../Config.dart';
import '../Models/interviewPrepModel.dart';

class MockTestScreen extends StatefulWidget {
  final String id;
  final String title;
  const MockTestScreen({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  State<MockTestScreen> createState() => _MockTestScreenState();
}

class _MockTestScreenState extends State<MockTestScreen> {
  List<McqQuestionsModel> mcqQuestionList = [];
  String _selection1 = '';
  String? selectedOption;
  List<String> selectedValues = [];
  int? _value;
  List MCQs = [];

  @override
  void initState() {
    getMcqTest();
    debugPrint("PRinting:: id came: ${widget.id}");
    // TODO: implement initState
    super.initState();
  }

  Future getMcqTest() async {
    // final response = await http.get(Uri.parse('${Config.baseURL}viewmcq/4'));
    final response =
        await http.get(Uri.parse('${Config.baseURL}viewmcq/${widget.id}'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["getallrecords"];
      setState(() {
        mcqQuestionList = jsonData
                .map<McqQuestionsModel>(
                    (data) => McqQuestionsModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json----------Data, $mcqQuestionList');
      debugPrint('printing json----------Data, ${mcqQuestionList.runtimeType}');
      debugPrint(
          'printing json----length------Data, ${mcqQuestionList.length}');
      for (var i = 0; i <= (mcqQuestionList.length * 4); i++) {
        MCQs.add(i);
        // return MCQs;
      }
      debugPrint('printing json Model, $McqQuestionsModel');
      debugPrint('printing-----MCQS LIST, ${MCQs}');
    } else {
      debugPrint('getDetails get call error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Config.careerCoachButtonColor,
          title: Text('Multiple Questions'),
        ),
        body: SafeArea(
          child: (mcqQuestionList == [])
              ? Center(
                  child: Container(
                  child: Text("NO QUESTIONS TO DISPLAY"),
                ))
              : (mcqQuestionList == null)
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16, bottom: 8),
                          child: Container(
                            child: Text(
                              "${widget.title}",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.9,
                          // height: 50.h,
                          child: (mcqQuestionList.isEmpty)
                              ? Center(
                                  child: Container(
                                    child: Text("NO QUESTIONS TO DISPLAY"),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: mcqQuestionList.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return (mcqQuestionList.isEmpty)
                                        ? Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Loading',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.sp,
                                                    color:
                                                        Config.primaryTextColor,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Config.grey),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //QUESTION
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8,
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 16),
                                                    child: RichText(
                                                        text:
                                                            TextSpan(children: [
                                                      TextSpan(
                                                        text: "${index + 1}) ",
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                .font_size_12
                                                                .sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${mcqQuestionList?[index].question ?? ""}",
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                .font_size_12
                                                                .sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ])),
                                                  ),
                                                  //
                                                  /*Expanded(
                                                    flex: 1,
                                                    child: GridView.count(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 10,
                                                      children: <Widget>[
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Radio(
                                                                value: 1,
                                                                groupValue:
                                                                    _value,
                                                                activeColor:
                                                                    Colors.blue,
                                                                // contentPadding: EdgeInsets.zero,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _value =
                                                                        value!;
                                                                  });
                                                                },
                                                                // Text("${mcqQuestionList[index].optionA}"),
                                                              ),
                                                            ),
                                                            Container(
                                                                width: 30.w,
                                                                child: Text(
                                                                  "${mcqQuestionList[index].optionA}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontSize: Config
                                                                          .font_size_12
                                                                          .sp),
                                                                ))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),*/
                                                  //
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Radio(
                                                              value: MCQs[
                                                                  index + 0],
                                                              groupValue:
                                                                  _value,
                                                              activeColor:
                                                                  Colors.blue,
                                                              // contentPadding: EdgeInsets.zero,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _value =
                                                                      value!;
                                                                });
                                                              },
                                                              // Text("${mcqQuestionList[index].optionA}"),
                                                            ),
                                                          ),
                                                          Container(
                                                              width: 30.w,
                                                              child: Text(
                                                                "${mcqQuestionList[index].optionA}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize: Config
                                                                        .font_size_12
                                                                        .sp),
                                                              ))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Radio(
                                                              value: MCQs[
                                                                  index + 1],
                                                              groupValue:
                                                                  _value,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _value =
                                                                      value!;
                                                                });
                                                              },
                                                              // Text("${mcqQuestionList[index].optionA}"),
                                                            ),
                                                          ),
                                                          Container(
                                                              width: 30.w,
                                                              child: Text(
                                                                "${mcqQuestionList[index].optionB}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  //
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Radio(
                                                              value: MCQs[
                                                                  index + 2],
                                                              groupValue:
                                                                  _value,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _value =
                                                                      value!;
                                                                });
                                                              },
                                                              // Text("${mcqQuestionList[index].optionA}"),
                                                            ),
                                                          ),
                                                          Container(
                                                              width: 30.w,
                                                              child: Text(
                                                                "${mcqQuestionList[index].optionC}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                              ))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Radio(
                                                              value: MCQs[
                                                                  index + 3],
                                                              groupValue:
                                                                  _value,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _value =
                                                                      value!;
                                                                });
                                                              },
                                                              // Text("${mcqQuestionList[index].optionA}"),
                                                            ),
                                                          ),
                                                          Container(
                                                              width: 30.w,
                                                              child: Text(
                                                                "${mcqQuestionList[index].optionD}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  /*Container(
                                  height: 10.h,
                                  child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      ),
                                      itemCount: 4,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return RadioListTile(
                                          title: Container(
                                            width: 10.w,
                                            child: Text(
                                              "${mcqQuestionList[index].optionA}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(fontSize: 11.sp),
                                            ),
                                          ),
                                          groupValue: _selection1,
                                          onChanged: (value) {
                                            print(value);
                                            setState(() {
                                              // selectedRadioValue = value!;
                                              _selection1 = value!;
                                              selectedValues.add(value);
                                              debugPrint(
                                                  "SelectedValue: ${selectedValues}");
                                            });
                                            // Handle radio button selection if needed
                                          },
                                          value: "123",
                                        );
                                      }),
                                ),*/
                                                ],
                                              ),
                                            ),
                                          );
                                  }),
                        ),
                        // SizedBox(
                        //   height: 35.h,
                        // )
                      ],
                    ),
        ));
  }
}

class QuestionList extends StatefulWidget {
  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final List<Map<String, dynamic>> questions = [
    {
      "questId": "24",
      "mcqId": "4",
      "question":
          "A soil has a liquid limit of 45% and lies above the A-line when plotted on a plasticity chart. The group, symbol of the soil as per Soil Classification is",
      "optionA": "CH",
      "optionB": "CI",
      "optionC": "CL",
      "optionD": "MI",
      "correctOption": "b",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "25",
      "mcqId": "4",
      "question":
          "A high efficiency pump is required for low discharge, high head and low maintenance cost. Delivery of water need not be continuous. The pump need not run at high speed. Which one of the following is the correct choice ?",
      "optionA": "Centrifugal pump",
      "optionB": "Reciprocating pump",
      "optionC": "Air lift pump",
      "optionD": "Hydraulic ram",
      "correctOption": "b",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "26",
      "mcqId": "4",
      "question":
          "For total reaction time of 2.5 seconds, coefficient of friction 0.35, design speed 80 km/h, what is the stopping sight distance on a highway ?",
      "optionA": "127 m",
      "optionB": "132 m",
      "optionC": "76 m",
      "optionD": "56 m",
      "correctOption": "a",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "27",
      "mcqId": "4",
      "question": "What is the use of a station pointer ?",
      "optionA": "For making soundings in water bodies",
      "optionB": "For plotting of soundings in harbour area",
      "optionC": "For marking sunken shipping hazards",
      "optionD": "For making tidal observations",
      "correctOption": "b",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "28",
      "mcqId": "4",
      "question":
          "Which type of light energy is effectively absorbed by CO2Â in the lower boundary of the troposphere ?",
      "optionA": "X - rays",
      "optionB": "UV - rays",
      "optionC": "Visible light",
      "optionD": "Infra-red rays",
      "correctOption": "d",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "29",
      "mcqId": "4",
      "question": "Distemper is used to coat",
      "optionA": "external concrete surfaces",
      "optionB": "interior surfaces not exposed to weather",
      "optionC": "woodwork",
      "optionD": "compound walls",
      "correctOption": "b",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "30",
      "mcqId": "4",
      "question":
          "A reinforced concrete slab is 75 mm thick. The maximum size of reinforcement bar that can be used is",
      "optionA": "12 mm diameter",
      "optionB": "10 mm diameter",
      "optionC": "8 mm diameter",
      "optionD": "6 mm diameter",
      "correctOption": "c",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "31",
      "mcqId": "4",
      "question":
          "Purlins are provided, in industrial buildings, over roof trusses to carry dead loads, live loads and wind loads. As per IS code, what are they assumed to be ?",
      "optionA": "Simply supported",
      "optionB": "Cantilever",
      "optionC": "Continuous",
      "optionD": "Fixed",
      "correctOption": "c",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "32",
      "mcqId": "4",
      "question":
          "Ratio of bearing capacity of double Under Reamed (U.R.) pile to that of single U.R. pile is nearly",
      "optionA": "2        ",
      "optionB": "1   1/2  ",
      "optionC": "1   1/5  ",
      "optionD": "1   7/10 ",
      "correctOption": "b",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "33",
      "mcqId": "4",
      "question":
          "To generate 10, 000 hp under a head of 81 m while working at a speed of 500 rpirt, the turbine of choice would be",
      "optionA": "Pelton",
      "optionB": "Kaplan",
      "optionC": "Bulb",
      "optionD": "Francis",
      "correctOption": "a",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "34",
      "mcqId": "4",
      "question":
          "What is the effective height of a free-standing masonry wall for the purpose of computing slenderness ratio ?",
      "optionA": "0.5 L",
      "optionB": "1.0 L",
      "optionC": "2.0 L",
      "optionD": "2.5 L",
      "correctOption": "c",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "35",
      "mcqId": "4",
      "question":
          "The maximum energy stored at elastic limit of a material is called",
      "optionA": "resilience",
      "optionB": "proof resilience",
      "optionC": "modulus of resilience",
      "optionD": "bulk resilience",
      "correctOption": "b",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "36",
      "mcqId": "4",
      "question":
          "If the pressure carried by a CBR specimen at 2.5 mm penetration is 3.5 N/mm2, the CBR of the soil is",
      "optionA": "1/10 ",
      "optionB": "7/20 ",
      "optionC": "1/2  ",
      "optionD": "7/10 ",
      "correctOption": "c",
      "addedOn": "2023-11-07"
    },
    {
      "questId": "37",
      "mcqId": "4",
      "question": "Activated sludge is the",
      "optionA": "resultant sludge removable from the aeration unit",
      "optionB": "sludge settled in the humus tank",
      "optionC":
          "sludge in the secondary tank post-aeration rich in microbial mass",
      "optionD":
          "sludge in the secondary tank post aeration, rich in nutrients.",
      "correctOption": "c",
      "addedOn": "2023-11-07"
    },
    // Add more questions here
  ];
  final List<Map<String, dynamic>> questions1 = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return QuestionCard(
          question: questions[index]['question'],
          options: [
            questions[index]['optionA'],
            questions[index]['optionB'],
            questions[index]['optionC'],
            questions[index]['optionD'],
          ],
          correctOption: questions[index]['correctOption'],
        );
      },
    );
  }
}

class QuestionCard extends StatefulWidget {
  final String question;
  final List<String> options;
  final String correctOption;

  QuestionCard(
      {required this.question,
      required this.options,
      required this.correctOption});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String _selection1 = '';
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 10.h,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      // color: Colors.amber,
                      child: RadioListTile(
                        title: Container(
                          width: 10.w,
                          child: Text(
                            "CL",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ),
                        groupValue: _selection1,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            // selectedRadioValue = value!;
                            _selection1 = value!;
                            selectedValues.add(value);
                            debugPrint("SelectedValue: ${selectedValues}");
                          });
                          // Handle radio button selection if needed
                        },
                        value: "123",
                      ),
                    );
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 7, right: 6),
            //   child: GridView.builder(
            //     itemCount: 2,
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       // crossAxisSpacing: 0,
            //       // mainAxisSpacing: 0
            //     ),
            //     itemBuilder: (BuildContext context, int index) {
            //       return Padding(
            //         padding: const EdgeInsets.only(top: 4, right: 2, left: 2),
            //         child: InkWell(
            //           child: Container(
            //             // width: 31.4.w,
            //             // height: 11.h,
            //             decoration: BoxDecoration(
            //               border: Border.all(
            //                   width: 0.1, color: Config.mainBorderColor),
            //               borderRadius: BorderRadius.circular(5),
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.only(
            //                 top: 5,
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: widget.options
            //                     .map(
            //                       (option) => RadioListTile(
            //                         title: Container(
            //                           width: 30.w,
            //                           child: Text(
            //                             option,
            //                             overflow: TextOverflow.ellipsis,
            //                             maxLines: 3,
            //                             style: TextStyle(fontSize: 11.sp),
            //                           ),
            //                         ),
            //                         groupValue: _selection1,
            //                         onChanged: (value) {
            //                           print(value);
            //                           setState(() {
            //                             // selectedRadioValue = value!;
            //                             _selection1 = value!;
            //                             selectedValues.add(value);
            //                             debugPrint(
            //                                 "SelectedValue: ${selectedValues}");
            //                           });
            //                           // Handle radio button selection if needed
            //                         },
            //                         value: option,
            //                       ),
            //                     )
            //                     .toList(),
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            SizedBox(height: 10.0),
            // Text('Correct Option: ${widget.correctOption}'),
          ],
        ),
      ),
    );
  }
}
