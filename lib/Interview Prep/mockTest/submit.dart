import 'dart:convert';

import 'package:careercoach/Models/interviewPrepModel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../Config.dart';
import '../../Widgets/App_Bar_Widget.dart';
import '../mockTest.dart';

class Submit extends StatefulWidget {
  final List<McqQuestionsModel> totalList;
  final Map<int, dynamic> optionMap;
  final Map<int, dynamic> answers;
  final String? id;

  const Submit(
      {Key? key,
      required this.answers,
      required this.totalList,
      required this.id,
      required this.optionMap})
      : super(key: key);

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  List<McqQuestionsModel> mcqQuestionList = [];
  List options = [];

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
      for (var i = 0; i < (mcqQuestionList.length); i++) {
        options.add(mcqQuestionList[i].correctOption);
        // return options;
      }
      debugPrint('printing json Model, $McqQuestionsModel');
      debugPrint('printing-----options LIST, ${options}');
      getAnswered();
    } else {
      debugPrint('getDetails get call error');
    }
  }

  List answered = [];
  getAnswered() {
    for (var i = 0; i < mcqQuestionList.length; i++) {
      answered.add(widget.optionMap.entries.elementAt(i).value);
    }
    debugPrint("Printing the value of answered: $answered");
    getScore();
  }

  List score = [];
  getScore() {
    for (var i = 0; i < mcqQuestionList.length; i++) {
      (options[i].toString() == answered[i]) ? score.add(answered[i]) : null;
    }
    debugPrint("Score: $score");
    debugPrint("Score: ${score.length}");
    if (score.length / mcqQuestionList.length > 0.8) {
      congratulationsPopup();
    } else if (score.length / mcqQuestionList.length > 0.5) {
      canDoBetterPopup();
    } else if (score.length / mcqQuestionList.length > 0) {
      workHardPopup();
    }
  }

  congratulationsPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Color(0xff6fd68f),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Congratulations!!'),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            content: Container(
              height: 15.h,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color(0xffa5fcbf),
                      ),
                      height: 5.h,
                      width: 90.w,
                      child: Center(
                        child: Text(
                          'Score: ${score.length} (out of ${mcqQuestionList.length})',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "See Test Results",
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: [
              /* ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.containerGreenColor),
                child: const Text('No'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.containerGreenColor),
                // onPressed: () {
                //   SystemNavigator.pop(animated: true);
                // },
                child: const Text('Yes'),
              ),*/
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  canDoBetterPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Color(0xfffdc686),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Can Do Better!!'),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            content: Container(
              height: 15.h,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      ),
                      height: 5.h,
                      width: 90.w,
                      child: Center(
                        child: Text(
                          'Score: ${score.length} (out of ${mcqQuestionList.length})',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "See Test Results",
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: [
              /* ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.containerGreenColor),
                child: const Text('No'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.containerGreenColor),
                // onPressed: () {
                //   SystemNavigator.pop(animated: true);
                // },
                child: const Text('Yes'),
              ),*/
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  workHardPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Color(0xffb72121),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Needs HardWork!!'),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            content: Container(
              height: 15.h,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color(0xffeababa),
                      ),
                      height: 5.h,
                      width: 90.w,
                      child: Center(
                        child: Text(
                          'Score: ${score.length} (out of ${mcqQuestionList.length})',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "See Test Results",
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: [
              /* ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.containerGreenColor),
                child: const Text('No'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Config.containerGreenColor),
                // onPressed: () {
                //   SystemNavigator.pop(animated: true);
                // },
                child: const Text('Yes'),
              ),*/
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  // NavToMockTest() {
  //   Navigator.of(context)
  //       .pushReplacement(MaterialPageRoute(builder: (context) => MockTest()));
  // }

  Future<bool> showExitPopup() async {
    return await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MockTest()));
  }

  @override
  void initState() {
    getMcqTest();
    debugPrint("Printing answers map: ${widget.answers}");
    debugPrint("Printing answers map: ${widget.totalList}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: const App_Bar_widget(title: 'MCQ'),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(3.w),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  'Submitted Answers'.toUpperCase(),
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: widget.totalList.length ?? 0,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.grey.shade400,
                              ),
                              child: Text(
                                "${index + 1}. ${widget.totalList[index].question}",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 0.3.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.grey.shade200,
                              ),
                              child: Text(
                                "ANS. ${widget.answers.entries.elementAt(index).value}",
                                // "\n${widget.answers.entries.map((entry) => '${entry.key} ${widget.answers.entries.elementAt(index).value}').join('\n')}'",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            // Container(
                            //   child: Text(
                            //     "${widget.totalList[index].correctOption}",
                            //     style: TextStyle(
                            //         fontSize: 12.sp, color: Colors.black),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }),
                //
                // Text("${widget.totalList[1].question}"),
                SizedBox(height: 10),

                // Display the content of the answers map
                // Text(
                //   '\n${widget.answers.entries.map((entry) => 'Question no -> ${entry.key},\n Option  -> ${entry.value}').join('\n')}',
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
