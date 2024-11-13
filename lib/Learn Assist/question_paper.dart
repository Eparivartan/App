import 'dart:convert';
import 'package:careercoach/Learn%20Assist/questionPaperPDFViewer.dart';
import 'package:careercoach/Widgets/App_Bar_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../Config.dart';
import '../Models/learnAssistModel.dart';
import '../Widgets/pagination.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

class Question_Paper extends StatefulWidget {
  const Question_Paper({Key? key}) : super(key: key);

  @override
  State<Question_Paper> createState() => _Question_PaperState();
}

class _Question_PaperState extends State<Question_Paper> {
  int selectedPage = 1;
  List<ListquestionpapersModel> questionPapers = [];
  double? _progress;

  Future getQuestionPaperDetails(from) async {
    final response = await http
        .get(Uri.parse('${Config.baseURL}listquestionpapers/$from/5'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["questionpapers"];
      setState(() {
        questionPapers = jsonData
                .map<ListquestionpapersModel>(
                    (data) => ListquestionpapersModel.fromJson(data))
                .toList() ??
            [];
        // getQuestionPaperDetails(0);
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
    } else {
      debugPrint('get call error');
    }
    debugPrint("Fresher2Industry123 : $questionPapers");
    debugPrint("Fresher2Industry123 : ${questionPapers[0].addedOn}");
    debugPrint("Fresher2Industry123 : ${questionPapers[0].examDescription}");
    debugPrint("Fresher2Industry123 : ${questionPapers[0].examName}");
    debugPrint("Fresher2Industry123 : ${questionPapers[0].qpStatus}");
    debugPrint("Fresher2Industry123 : ${questionPapers[0].questionPaper}");
    // debugPrint("Service Details : $serviceDetails");
  }

  Future<void> downloadFile(String url, String fileName) async {
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir:
          '/storage/emulated/0/Download/', // Specify the directory where you want to save the file
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  // late PdfControllerPinch _pdfControllerPinch;

  // Future<void> downloadFile(String url, String fileName) async {
  //   var response = await http.get(Uri.parse(url));
  //   var bytes = response.bodyBytes;
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   debugPrint("Printing::## $dir");
  //   File file = File('$dir/$fileName');
  //   debugPrint("Printing::## $file");
  //   await file.writeAsBytes(bytes);
  // }

  pageList(page) {
    switch (page) {
      case 1:
        getQuestionPaperDetails(0);
        break;
      case 2:
        getQuestionPaperDetails(5);
        break;
      case 3:
        getQuestionPaperDetails(10);
        break;
      case 4:
        getQuestionPaperDetails(15);
        break;
      case 5:
        getQuestionPaperDetails(20);
        break;
      case 6:
        getQuestionPaperDetails(25);
        break;
      case 7:
        getQuestionPaperDetails(30);
        break;
      case 8:
        getQuestionPaperDetails(35);
        break;
      case 9:
        getQuestionPaperDetails(40);
        break;
      case 10:
        getQuestionPaperDetails(45);
        break;
      case 11:
        getQuestionPaperDetails(50);
        break;
      case 12:
        getQuestionPaperDetails(55);
        break;
      case 13:
        getQuestionPaperDetails(60);
        break;
      case 14:
        getQuestionPaperDetails(65);
        break;
      case 15:
        getQuestionPaperDetails(70);
        break;
      case 16:
        getQuestionPaperDetails(75);
        break;
      case 17:
        getQuestionPaperDetails(80);
        break;
      case 18:
        getQuestionPaperDetails(85);
        break;
      case 19:
        getQuestionPaperDetails(90);
        break;
      case 20:
        getQuestionPaperDetails(95);
        break;
      default:
        getQuestionPaperDetails(100);
    }
  }

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  String? Img;
  // String? Timg;
  String? Pic;
  List? Details;

  numberOfPages1() {
    double pgNum = questionPapers.length / 5;
    return pgNum.ceil();
  }

  @override
  void initState() {
    getQuestionPaperDetails(0);
    loadJson();
    super.initState();
  }

  Future loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/question_paper.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      Img = jsonMap['img'];
      // Timg = jsonMap['timg'];
      Pic = jsonMap['pic'];
      Details = jsonMap['details'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget(
          title: 'Question Paper',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w),
          child: (questionPapers.isEmpty)
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
                    Container(
                        width: 90.w,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "This section Question Papers ",
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Config.primaryTextColor)),
                            TextSpan(
                              text: "contains all the "
                                  "collated papers/content from various companies "
                                  "interviews and Internship questions..",
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Config.primaryTextColor),
                            ),
                          ]),
                        )),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: questionPapers?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 0.5.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1, color: Color(0XFFF1F1F1)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 1.h,
                                    left: 2.w,
                                    right: 2.w,
                                    bottom: 1.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          questionPapers?[index]
                                                  .examName
                                                  .toString() ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Config.primaryTextColor),
                                        ),
                                        SizedBox(
                                          height: 0.3.h,
                                        ),
                                        Container(
                                          width: 80.w,
                                          child: Text(
                                            questionPapers?[index]
                                                    .examDescription
                                                    .toString() ??
                                                '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Config.primaryTextColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    /*TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (_) => const PDFViewerFromUrl(
                                      url: 'http://africau.edu/images/default/sample.pdf',
                                    ),
                                  ),
                                ),
                                child: const Text('View PDF'),  //627532
                              ),*/
                                    InkWell(
                                      onTap: () {
                                        debugPrint("Tapped on download");
                                        String urlLink =
                                            "${Config.imageURL}${questionPapers?[index].questionPaper.toString()}";
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QuestionPaperPdfViewer(
                                                        url: urlLink)));
                                        debugPrint("Tapped on download");
                                        // String url = "${Config.imageURL }${questionPapers?[index].questionPaper.toString()}";
                                        // String fileName = '${questionPapers?[index].questionPaper.toString()}${TimeOfDay.now()}';
                                        // downloadFile(url, fileName);
                                      },
                                      child: Container(
                                        height: 3.h,
                                        width: 5.w,
                                        child: Image.asset(
                                          'assets/images/pdficon.png',
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: PaginationWidget(
          numOfPages: numberOfPages1(),
          selectedPage: selectedPage,
          pagesVisible: 3,
          spacing: 0,
          onPageChanged: (page) {
            debugPrint("Sending page $page");
            pageList(page);
            setState(() {
              selectedPage = (page);
            });
          },
          nextIcon: Icon(
            Icons.arrow_forward_ios,
            size: 12,
            color: selectedPage == numberOfPages1()
                ? Colors.grey
                : Color(0xff000000),
          ),
          previousIcon: Icon(
            Icons.arrow_back_ios,
            size: 12,
            color: selectedPage == 1 ? Colors.grey : Color(0xff000000),
          ),
          activeTextStyle: TextStyle(
            color: const Color(0xffffffff),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
          activeBtnStyle: ButtonStyle(
            visualDensity: const VisualDensity(horizontal: -4),
            backgroundColor: MaterialStateProperty.all(const Color(0xff8cb93d)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            shadowColor: MaterialStateProperty.all(
              const Color(0xfff1f1f1),
            ),
          ),
          inactiveBtnStyle: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            visualDensity: const VisualDensity(horizontal: 0),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xfff9f9fb),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(
                  color: Color(0xffffffff),
                  width: 10,
                ),
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
    );
  }
}

// class PDFViewerFromUrl extends StatelessWidget {
//   const PDFViewerFromUrl({Key? key, required this.url}) : super(key: key);
//
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('PDF From Url'),
//         ),
//         body: Container(
//           child: PDF.fromUrl(url,
//             placeholder: (double progress) => Center(child: Text('$progress %')),
//             errorWidget: (dynamic error) => Center(child: Text(error.toString())),
//           ),
//         )
//     );
//   }
// }
