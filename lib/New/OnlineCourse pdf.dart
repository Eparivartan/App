import 'package:careercoach/Learn%20Assist/question_paper.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:careercoach/Config.dart';

import 'Online Courses.dart';

class OnlineCoursesPdfViewer extends StatefulWidget {
  String url;
  OnlineCoursesPdfViewer({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<OnlineCoursesPdfViewer> createState() => _OnlineCoursesPdfViewerState();
}

class _OnlineCoursesPdfViewerState extends State<OnlineCoursesPdfViewer> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    debugPrint("Came to QuestionPaperPdfViewerState");
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(widget.url);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF8CB93D),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => OnlineCourses()));
          },
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
                child: Text('PDF VIEWER',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: _isLoading
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loading',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: Colors.black,
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
                : PDFViewer(document: document)),
      ),
    );
  }
}
