import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:careercoach/Widgets/App_Bar_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

import '../Config.dart';
import '../Models/learnAssistModel.dart';
import '../Widgets/pagination.dart';

class IndustrySeminarsPlay extends StatefulWidget {
  int index1;
  IndustrySeminarsPlay({Key? key, required this.index1}) : super(key: key);

  @override
  State<IndustrySeminarsPlay> createState() => _IndustrySeminarsPlayState();
}

class _IndustrySeminarsPlayState extends State<IndustrySeminarsPlay> {

  int selectedPage = 1;

  String? Img;
  // String? Timg;
  String? selectedVideoId;
  String? selectedVideoName;
  String? selectedVideoStatus;
  String? selectedVideoDuratrion;
  bool showSelectedVideo = false;
  String? Pic;
  List? Details;
  List<ExternalTrainingVideosModel> trainingVideosList = [];
  bool? isVideoPlaying;
  bool alwaysShowProgressBar = true;
  int mode = 1;
  var indexNew;



  @override
  void initState() {
    loadJson1();
    getTrainingVideosDetails(0);
    debugPrint("printing the initstate");
    debugPrint("Came with index the initstate === ${widget.index1}");
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //     '${Config.imageURL}${trainingVideosList[0].videoThumbnail.toString()}',
    //     // 'https://youtu.be/LdRdc7JWo3M?si=FxLb3bQEy9FZgUoh'
    //   ),
    // );
    //
    // _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
    // VideoFunc();

    /*controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network('https://youtu.be/LdRdc7JWo3M?si=FxLb3bQEy9FZgUoh'),
    )..initialise().then((value) {
      setState(() {
        debugPrint("printing the initstate <- Setstate");
        isVideoPlaying = controller.isVideoPlaying;
      });
    });*/
    // controller.addListener(_listner);
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



  numberOfPages1() {
    double pgNum = trainingVideosList.length/5;
    return pgNum.ceil();
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
    return Scaffold(
      backgroundColor: Config.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget(title: 'Industry Seminars',),
      ),
      body:  Column(
        children: [
          if (showSelectedVideo && selectedVideoId != null)
            Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Color(0xffF1F1F1)),
                        height: 200,
                        child: VimeoPlayer(
                          key: ValueKey(
                              selectedVideoId), // Ensures player updates when selectedVideoId changes
                          videoId: selectedVideoId!,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                selectedVideoName.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  "Date:" + selectedVideoStatus.toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff999999),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  "Duration:" + selectedVideoDuratrion.toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff999999),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h, left: 4.w, right: 4.w),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: trainingVideosList?.length ?? 0,
                itemBuilder: (context, index) {
                  return (widget.index1 == index || indexNew == index)
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: InkWell(
                            onTap: () {
                              // initState();
                              debugPrint(
                                  "Tapped on container went with Mode--> $mode and with index--> $indexNew");
                              setState(() {
                                print(
                                    "${trainingVideosList?[index].videoEmbed.toString()}");
                                selectedVideoId =
                                    "${trainingVideosList?[index].videoEmbed.toString()}";
                                showSelectedVideo = true;
                                selectedVideoName =
                                    "${trainingVideosList?[index].videoName.toString()}";
                                selectedVideoStatus =
                                    "${trainingVideosList?[index].videoStatus.toString()}";
                                selectedVideoDuratrion =
                                    "${trainingVideosList?[index].videoDuration.toString()}";

                                print(selectedVideoId.toString());
                              });
                              debugPrint(
                                  "Tapped on container went with Mode--> $mode and with index--> $indexNew");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    width: 1, color: Color(0XFFF1F1F1)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 1.h, left: 2.w, bottom: 1.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 60.w,
                                          child: Text(
                                            trainingVideosList?[index]
                                                    .videoName
                                                    .toString() ??
                                                '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Config.primaryTextColor),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Date: ${trainingVideosList?[index].addedOn.toString()}" ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xff999999)),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Text(
                                              "Duration: ${trainingVideosList?[index].videoDuration.toString()}" ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xff999999)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // width: 25.w,
                                    child: Image.network(
                                      "${Config.imageURL}${trainingVideosList?[index].videoThumbnail.toString()}",
                                      fit: BoxFit.fill,
                                      width: 25.w,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                }),
          ),
        ],
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
}
