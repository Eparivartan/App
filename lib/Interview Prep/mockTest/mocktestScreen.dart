import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Config.dart';
import '../../Models/interviewPrepModel.dart';
import '../../Widgets/App_Bar_Widget.dart';
import 'mcqQuestions.dart';
import 'submit.dart';

class MockPageViewBuilder extends StatefulWidget {
  final List<McqTestListModel> totalList;
  final String id;
  final String title;
  const MockPageViewBuilder(
      {Key? key,
      required this.id,
      required this.title,
      required this.totalList})
      : super(key: key);

  @override
  _MockPageViewBuilderState createState() => _MockPageViewBuilderState();
}

class _MockPageViewBuilderState extends State<MockPageViewBuilder> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Map<int, dynamic> answersMap = {};
  Map<int, dynamic> answersMapOption = {};
  List<Map<String, dynamic>> jData = [];
  bool allQuestionsAnswered = false;
  List<McqQuestionsModel> mcqQuestionList = [];
  List MCQs = [];

  @override
  void initState() {
    getMcqTest();
    loadMcqData();
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

  // Load JSON data
  void loadMcqData() async {
    try {
      String jsonContent = await DefaultAssetBundle.of(context).loadString(
        'assets/files/jmcq.json',
      );
      Map<String, dynamic> jsonData = json.decode(jsonContent);
      setState(() {
        jData = List<Map<String, dynamic>>.from(jsonData['mcqj']);
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  // Printing the values in console
  void submitAnswers() {
    print(answersMap);
  }

  void handlingMap(List<String> answers) {
    int questionNumber = _currentPage + 1;
    answersMap[questionNumber] = answers;
    answersMapOption[questionNumber] = answers;
    // Check if all questions are answered
    checkAllQuestionsAnswered();
  }

  void checkAllQuestionsAnswered() {
    setState(() {
      allQuestionsAnswered = answersMap.length == jData.length;
    });
  }

  //handle Multicheckbox answers
  void handleMulticheckboxAnswers(List<String> answers) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: const App_Bar_widget(title: 'MCQ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 90.h,
          child: (mcqQuestionList.isEmpty)
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      height: 10.h,
                      width: 50.w,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "${widget.title}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.sp),
                        ),
                      ),
                    ),
                    Container(
                      height: 50.h,
                      child: PageView.builder(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        itemCount: mcqQuestionList.length,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (context, index) {
                          return McqQuestions(
                            index: index,
                            optionA: mcqQuestionList[index].optionA.toString(),
                            optionB: mcqQuestionList[index].optionB.toString(),
                            optionC: mcqQuestionList[index].optionC.toString(),
                            optionD: mcqQuestionList[index].optionD.toString(),
                            selectedOption: answersMap[index + 1],
                            questionData:
                                mcqQuestionList[index].question.toString(),
                            onOptionSelected: (String? option) {
                              setState(() {
                                answersMap[index + 1] = option;
                                // ignore: avoid_print
                                print(answersMap);
                              });
                            },
                            onOption: (String? value) {
                              setState(() {
                                answersMapOption[index + 1] = value;
                                // ignore: avoid_print
                                print(answersMapOption);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button
              Visibility(
                visible: (_currentPage == 0) ? false : true,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    backgroundColor: Config.careerCoachButtonColor,
                  ),
                  onPressed: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Previous',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),

              // Next button
              Visibility(
                visible:
                    (_currentPage == mcqQuestionList.length - 1) ? false : true,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    backgroundColor: Config.careerCoachButtonColor,
                  ),
                  onPressed: () {
                    if (_currentPage < mcqQuestionList.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      checkAllQuestionsAnswered();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '  Next  ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp),
                    ),
                  ),
                ),
              ),

              //Submit button
              Visibility(
                visible:
                    (_currentPage == mcqQuestionList.length - 1) ? true : false,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    backgroundColor: Config.careerCoachButtonColor,
                  ),
                  onPressed: () {
                    (mcqQuestionList.length == answersMap.length)
                        ?
                        // submitAnswers(
                        //     correctOption: mcqQuestionList[index].correctOption
                        //     );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Submit(
                                id: widget.id,
                                answers: answersMap,
                                optionMap: answersMapOption,
                                totalList: mcqQuestionList,
                              ),
                            ),
                          )
                        : ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var snackBar = SnackBar(
    duration: const Duration(seconds: 3),
    content: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: "Please Answer all the questions to Submit ",
          style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: 'the test!!',
          style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ]),
    ),
    backgroundColor: Colors.white,
  );
}
