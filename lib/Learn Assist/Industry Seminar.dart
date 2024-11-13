import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:careercoach/Widgets/App_Bar_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Models/learnAssistModel.dart';
import '../Widgets/pagination.dart';
import 'Industry Seminar play.dart';

class IndustrySeminars extends StatefulWidget {
  const IndustrySeminars({Key? key}) : super(key: key);

  @override
  State<IndustrySeminars> createState() => _IndustrySeminarsState();
}

class _IndustrySeminarsState extends State<IndustrySeminars> {

  int selectedPage = 1;

  String? Img;
  // String? Timg;
  String? Pic;
  List? Details;
  List<ExternalTrainingVideosModel> trainingVideosList = [];


  numberOfPages1() {
    double pgNum = trainingVideosList.length/5;
    return pgNum.ceil();
  }

  Future getTrainingVideosDetails(from) async{

    final response = await http.get(Uri.parse('${Config.baseURL}listindustryseminars/$from/5'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["industryseminars"];
      setState(() {
        trainingVideosList = jsonData.map<ExternalTrainingVideosModel>((data) =>ExternalTrainingVideosModel.fromJson(data)).toList() ?? [];
        // getQuestionPaperDetails(0);
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
    }else{
      debugPrint('get call error');
    }
    debugPrint("trainingVideosList : $trainingVideosList");
    // debugPrint("Service Details : $serviceDetails");

  }


  pageList(page) {
    switch(page){
      case 1:
        getTrainingVideosDetails(0);
        break;
      case 2:
        getTrainingVideosDetails(5);
        break;
      case 3:
        getTrainingVideosDetails(10);
        break;
      case 4:
        getTrainingVideosDetails(15);
        break;
      case 5:
        getTrainingVideosDetails(20);
        break;
      case 6:
        getTrainingVideosDetails(25);
        break;
      case 7:
        getTrainingVideosDetails(30);
        break;
      case 8:
        getTrainingVideosDetails(35);
        break;
      case 9:
        getTrainingVideosDetails(40);
        break;
      case 10:
        getTrainingVideosDetails(45);
        break;
      case 11:
        getTrainingVideosDetails(50);
        break;
      case 12:
        getTrainingVideosDetails(55);
        break;
      case 13:
        getTrainingVideosDetails(60);
        break;
      case 14:
        getTrainingVideosDetails(65);
        break;
      case 15:
        getTrainingVideosDetails(70);
        break;
      case 16:
        getTrainingVideosDetails(75);
        break;
      case 17:
        getTrainingVideosDetails(80);
        break;
      case 18:
        getTrainingVideosDetails(85);
        break;
      case 19:
        getTrainingVideosDetails(90);
        break;
      case 20:
        getTrainingVideosDetails(95);
        break;
      default:
        getTrainingVideosDetails(100);
    }
  }


  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  void initState() {
    loadJson1();
    getTrainingVideosDetails(0);
    super.initState();
  }




  Future loadJson1() async {
    String jsonString =
    await rootBundle.loadString('assets/files/externalTraining.json');
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
    return (trainingVideosList.isEmpty) ?
    Center(
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
    Scaffold(
      backgroundColor: Config.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: const App_Bar_widget(title: 'Industry Seminars',),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w),
          child: (trainingVideosList.isEmpty) ?
          Center(
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
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: 'Industry Seminars ',
                        style: TextStyle(
                            fontSize: Config.font_size_12.sp,
                            fontWeight: FontWeight.bold,
                            color: Config.primaryTextColor
                        ),
                      ),
                      TextSpan(text: 'contains all the collated videos '
                          'from e-content and other important university '
                          'syllabi …',
                        style: TextStyle(
                            fontSize: Config.font_size_12.sp,
                            fontWeight: FontWeight.normal,
                            color: Config.primaryTextColor
                        ),
                      ),
                    ]
                ),),
              ),
              SizedBox(height: 2.h,),
              Padding(
                padding: EdgeInsets.only(bottom: 1.h, left: 1.w, right: 1.w),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: trainingVideosList?.length ?? 0,
                    itemBuilder: (context, index)
                    {
                      return Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> IndustrySeminarsPlay(index1: index)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(width: 1,color: Color(0XFFF1F1F1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h, left: 2.w, bottom: 1.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 60.w,
                                        child: Text(trainingVideosList?[index].videoName.toString() ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: Config.font_size_12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Config.primaryTextColor
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2.h,),
                                      Row(
                                        children: [
                                          Text("Date: ${trainingVideosList?[index].addedOn.toString()}" ?? '',
                                            style: TextStyle(
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Color(0xff999999)
                                            ),
                                          ),
                                          SizedBox(width: 15.w,),
                                          Text("Duration: ${trainingVideosList?[index].videoDuration.toString()}" ?? '',
                                            style: TextStyle(
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Color(0xff999999)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // width: 25.w,
                                  child: Image.network("${Config.imageURL}${trainingVideosList?[index].videoThumbnail.toString()}",
                                    fit: BoxFit.fill,
                                    width: 25.w,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
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
            pageList(page);
            setState(() {
              selectedPage = page;
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
            color: selectedPage==1 ? Colors.grey : Color(0xff000000),
          ),
          activeTextStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
          activeBtnStyle: ButtonStyle(
            visualDensity:
            VisualDensity(horizontal: -4),
            backgroundColor:
            MaterialStateProperty.all(
                const Color(0xff8cb93d)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(7),
                // side: const BorderSide(
                //  // color: Color(0xfff1f1f1),
                //   width: 1,
                // ),
              ),
            ),
            padding: MaterialStateProperty.all(
                const EdgeInsets.all(12)),
            // shadowColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff1f1f1),
            // ),
          ),
          inactiveBtnStyle: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.all(20)),
            visualDensity:
            const VisualDensity(horizontal: 0),
            elevation:
            MaterialStateProperty.all(0),
            // backgroundColor:
            // MaterialStateProperty.all(
            //   const Color(0xfff9f9fb),
            // ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(15),
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
