import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Config.dart';

class McqQuestions extends StatefulWidget {
  final String? selectedOption;
  final String? questionData;
  final ValueChanged<String?> onOptionSelected;
  final ValueChanged<String?> onOption;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final int index;

  const McqQuestions({
    Key? key,
    required this.selectedOption,
    required this.questionData,
    required this.onOptionSelected,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.index,
    required this.onOption,
  }) : super(key: key);

  @override
  _McqQuestionsState createState() => _McqQuestionsState();
}

class _McqQuestionsState extends State<McqQuestions> {
  @override
  void initState() {
    debugPrint(" printing Question Daat: ${widget.questionData}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "${widget.index + 1}. ${widget.questionData}",
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            ),
            buildOption("a", widget.optionA),
            buildOption("b", widget.optionB),
            buildOption("c", widget.optionC),
            buildOption("d", widget.optionD),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String optionNum, String optionText) {
    return GestureDetector(
      onTap: () {
        widget.onOptionSelected(optionText);
        widget.onOption(optionNum);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.only(left: 3.w, top: 1.h, bottom: 1.h),
        decoration: BoxDecoration(
          color: widget.selectedOption == optionText
              ? Config.careerCoachButtonColor
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(
          //   color: widget.selectedOption == optionText
          //       ? Colors.green
          //       : Colors.black,
          // ),
        ),
        child: Text(
          optionText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
