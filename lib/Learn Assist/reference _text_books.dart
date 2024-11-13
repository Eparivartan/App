import 'dart:convert';

import 'package:careercoach/Config.dart';
import 'package:careercoach/Widgets/App_Bar_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../Models/learnAssistModel.dart';
import '../Widgets/pagination.dart';

class ReferenceTextBooks extends StatefulWidget {
  const ReferenceTextBooks({Key? key}) : super(key: key);

  @override
  State<ReferenceTextBooks> createState() => _ReferenceTextBooksState();
}

class _ReferenceTextBooksState extends State<ReferenceTextBooks> {
  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  String? Img;

  // String? Timg;
  String? Pic;
  String link = '';
  List? Details;
  List<RefBooksModel> refBooks = [];
  List<String> _urlsToLaunch = [];


  Future getRefBooksDetails(from) async{

    final response = await http.get(Uri.parse('${Config.baseURL}listreferencebooks/$from/5'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["referencebooks"];
      setState(() {
        refBooks = jsonData.map<RefBooksModel>((data) =>RefBooksModel.fromJson(data)).toList() ?? [];

        // getQuestionPaperDetails(0);
      });

      for(var i = 0; i < refBooks.length; i++){
        _urlsToLaunch.add(refBooks[i].buyingLink.toString());
      }
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing _urlsToLaunch, $_urlsToLaunch');
    }else{
      debugPrint('get call error');
    }
    debugPrint("Fresher2Industry123 : $refBooks");
    // debugPrint("Service Details : $serviceDetails");

  }



  @override
  void initState() {
    loadJson();
    getRefBooksDetails(0);
    super.initState();
  }

  pageList(page) {
    switch(page){
      case 1:
        getRefBooksDetails(0);
        break;
      case 2:
        getRefBooksDetails(5);
        break;
      case 3:
        getRefBooksDetails(10);
        break;
      case 4:
        getRefBooksDetails(15);
        break;
      case 5:
        getRefBooksDetails(20);
        break;
      case 6:
        getRefBooksDetails(25);
        break;
      case 7:
        getRefBooksDetails(30);
        break;
      case 8:
        getRefBooksDetails(35);
        break;
      case 9:
        getRefBooksDetails(40);
        break;
      case 10:
        getRefBooksDetails(45);
        break;
      case 11:
        getRefBooksDetails(50);
        break;
      case 12:
        getRefBooksDetails(55);
        break;
      case 13:
        getRefBooksDetails(60);
        break;
      case 14:
        getRefBooksDetails(65);
        break;
      case 15:
        getRefBooksDetails(70);
        break;
      case 16:
        getRefBooksDetails(75);
        break;
      case 17:
        getRefBooksDetails(80);
        break;
      case 18:
        getRefBooksDetails(85);
        break;
      case 19:
        getRefBooksDetails(90);
        break;
      case 20:
        getRefBooksDetails(95);
        break;
      default:
        getRefBooksDetails(100);
    }
  }

  numberOfPages1() {
    double pgNum = refBooks.length/5;
    return pgNum.ceil();
  }

  // BrowseBook(index) {
  //   final Uri _url = Uri.parse("www.google.com");
  //   // final Uri _url = Uri.parse("${Details?[index]["head"].toString()}");
  //   _launchUrl() async {
  //     if (!await launchUrl(_url)) {
  //       throw Exception('Could not launch $_url');
  //     }
  //   }
  //   return _launchUrl();
  // }

  // Uri _url = Uri.parse("${link}");


  Future loadJson() async {
    String jsonString =
        await rootBundle.loadString('assets/files/reference_text_books.json');
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
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(6.h),
      child: App_Bar_widget2(title: 'Reference Text Books',)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w,),
          child: (refBooks.isEmpty)
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
          ) :
          ListView(
            children: [
              Container(
                width: 90.w,
                child: RichText(text: TextSpan(
                  children: [
                    TextSpan(text: 'This Section ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                      color: Config.primaryTextColor
                    )),
                    TextSpan(text: 'This section contains all the '
                        'relevant reference Text books….content from '
                        'various companies interviews and Internship books..',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Config.primaryTextColor
                    ))
                  ]
                ),

                ),
              ),
              SizedBox(height: 1.2.h,),
              Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: refBooks?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 0.5.h),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 1, color: Color(0XFFDDDDDD)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(refBooks?[index].bookName.toString() ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 0.4.h,),
                                  Text(refBooks?[index].bookSynopsis.toString() ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 11.sp
                                  ),),
                                  SizedBox(height: 0.5.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(""),
                                      InkWell(
                                        onTap: () {
                                          debugPrint("tapped");
                                          // link = Uri.parse("${refBooks?[index].buyingLink.toString()}");
                                          // _url = Uri.parse(refBooks[index].buyingLink.toString());
                                          // _launchUrl(index);
                                          // BrowseBook(index);
                                          // _launchURL;
                                          _launchUrl(index);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('Order this book online',
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                decoration: TextDecoration.underline,
                                                color: Color(0XFF1F5FD9),
                                              ),),
                                            Padding(
                                              padding: EdgeInsets.only(left: 2.w),
                                              child: Image.asset('assets/images/DoubleArrowIcon.png',width: 3.w),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h,),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: PaginationWidget(
          numOfPages: 1,
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
            color: selectedPage == numberOfPages1() ? Colors.grey : Color(0xff000000),
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
            backgroundColor:
            MaterialStateProperty.all(
                const Color(0xff8cb93d)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            shadowColor: MaterialStateProperty.all(const Color(0xfff1f1f1),
            ),
          ),
          inactiveBtnStyle: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.all(20)),
            visualDensity:
            const VisualDensity(horizontal: 0),
            elevation:
            MaterialStateProperty.all(0),
            backgroundColor:
            MaterialStateProperty.all(
              const Color(0xfff9f9fb),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(15),
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


  _launchUrl(index) async {
    if (!await launchUrl(Uri.parse(_urlsToLaunch[index]))) {
      throw "Could not open $_urlsToLaunch";
      // await launchUrl(Uri.parse(_urlsToLaunch[index]));
    }
    // else {
    //   throw "Could not open $_urlsToLaunch";
    // }
  }
}
