// // import 'package:flutter/material.dart';
// // import 'package:sizer/sizer.dart';
// // import '../Config.dart';
// //
// //
// //
// // class NotificationPDF extends StatefulWidget {
// //   final String? documentpath;
// //   NotificationPDF({Key? key, this.documentpath}) : super(key: key);
// //
// //
// //
// //   @override
// //   State<NotificationPDF> createState() => _NotificationPDFState();
// // }
// // enum DocShown { sample, tutorial, hello, password }
// // class _NotificationPDFState extends State<NotificationPDF> {
// //
// //
// //
// //   late PdfControllerPinch _pdfControllerPinch;
// //
// //
// //
// //
// //
// //   @override
// //   void initState() {
// //     _pdfControllerPinch = PdfControllerPinch(
// //       document: PdfDocument.openAsset('assets/hello.pdf'),
// //       // document: PdfDocument.openData(
// //       //   OpenFile.get(
// //       //       Config.baseUrl +'/Uploads/DocumentNotification/${widget.documentpath}',
// //       //       headers: {"content-type": "application/x-www-form-urlencoded; charset=UTF-8",
// //       //         'cookie': "ASP.NET_SessionId=eucfvxnvwolqrcpidnnlj2tx; trustedsite_visit=1; mp_d7f79c10b89f9fa3026f2fb08d3cf36d_mixpanel=%7B%22distinct_id%22%3A%20%22%24device%3A18a63f803933b5-08d4626f7973b1-26031f51-e1000-18a63f803943b5%22%2C%22%24device_id%22%3A%20%2218a63f803933b5-08d4626f7973b1-26031f51-e1000-18a63f803943b5%22%2C%22%24initial_referrer%22%3A%20%22%24direct%22%2C%22%24initial_referring_domain%22%3A%20%22%24direct%22%2C%22%24search_engine%22%3A%20%22google%22%7D; .ASPXAUTH=B2ECB927DCB7F2D533D027B398C94EBB8E10EF091264427143C76E30F6AEAFB27B3758CDBC7B4C84A073263DB32269443BD450291CE00FAD0C93118016F4175FCD047E94737A388DC91EBAA262E90BABB4109B52DA3EB7E555CD34F6701D97BA1B6E42C1986CBE60BFA041995EEDB56C15400C4A8E2C7C02622D2CDF13A5144D7DBDC7586A4EF9AB5C4224FE9B862E8155A54E325F95ECB6F1D96FFB154A84C925DC7F8EBAA0D872F05A38FD47E47C5AEFD277054DD9C93D63D3E13F58B7C45F14164726A745CEB6BDA87B118ABFA6419E5AAAFEA7FEC7B6966F41739FEB56BAFCFEC9A3C4190FEEF46D80DFE92E7401523E1224173712D0FC68DEC069FB3A440200BCC11B34C496AC17D1DD1484FE0F86283D764FAAF622573EDD75A065708412C89CEAE16EAA2BE23A035C5385A7D157D14AEC40D8E1961BFD719553F82C38AD01449FD5E5C393AB94A6EEC376A4C0113CE1AAD6CF3A2079D0BA7F8DDADC1903E42B9048E61B0C2C75E39CB4E73408"}
// //       //
// //       //
// //       //
// //       //   ),
// //       // ),
// //       initialPage: _initialPage,
// //     );
// //     super.initState();
// //   }
// //
// //
// //
// //
// //
// //   @override
// //   void dispose() {
// //     _pdfControllerPinch.dispose();
// //     super.dispose();
// //   }
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xff7B7B7B),
// //       body: Stack(
// //         children: [
// //           Container(
// //             // height: 1000,
// //               child: PdfViewPinch(
// //                 builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
// //                   options: const DefaultBuilderOptions(),
// //                 ),
// //                 controller: _pdfControllerPinch,
// //
// //               )
// //           ),
// //
// //
// //
// //           Positioned(
// //               top:50.sp,
// //               left:240.sp,
// //               child:InkWell(
// //                   onTap: ()
// //                   {
// //                     Navigator.pop(context);
// //
// //
// //
// //                   },
// //                   child:Container(
// //                       height: 6.h,
// //                       width: 20.w,
// //                       decoration: const BoxDecoration(
// //                         borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
// //                         color:Config.Red,
// //                       ),
// //
// //
// //
// //                       child: const Center(child: Text('Close',style:TextStyle(fontSize: 15,color: Colors.white)))
// //                   )
// //
// //
// //
// //               )
// //           )],
// //       ),
// //     );
// //   }
// //
// //
// //
// //
// //
// // }
//
//
// import 'package:flutter/material.dart';
//
// class QuestionPaperPDFViewer extends StatefulWidget {
//   const QuestionPaperPDFViewer({Key? key}) : super(key: key);
//
//   @override
//   State<QuestionPaperPDFViewer> createState() => _QuestionPaperPDFViewerState();
// }
//
// class _QuestionPaperPDFViewerState extends State<QuestionPaperPDFViewer> {
//
//   PDF(
//   swipeHorizontal: true,
//   ).cachedFromUrl('http://africau.edu/images/default/sample.pdf'),
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//             child: SfPdfViewer.network('https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')
//         )
//       ),
//     );
//   }
// }

import 'package:careercoach/Learn%20Assist/question_paper.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:careercoach/Config.dart';

class QuestionPaperPdfViewer extends StatefulWidget {
  String url;
  QuestionPaperPdfViewer({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<QuestionPaperPdfViewer> createState() => _QuestionPaperPdfViewerState();
}

class _QuestionPaperPdfViewerState extends State<QuestionPaperPdfViewer> {
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
                MaterialPageRoute(builder: (context) => Question_Paper()));
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
