import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';
import '../Widgets/pagination.dart';
import '../Models/learnAssistModel.dart';

class VHM extends StatefulWidget {
  final String Id;
  final String vedioname;
  final String vediodate;
  final String vedioduration;
  int index1;

  VHM({
    Key? key,
    required this.index1,
    required this.Id,
    required this.vedioname,
    required this.vediodate,
    required this.vedioduration,
  }) : super(key: key);

  @override
  _VHMState createState() => _VHMState();
}

class _VHMState extends State<VHM> {
  int selectedPage = 1;
  String? Img;
  String? Pic;
  List? Details;
  List<ExternalTrainingVideosModel> trainingVideosList = [];
  bool alwaysShowProgressBar = true;
  int mode = 1;
  var indexNew;
  int selectedIndex = -1;
  String? selectedVideoId;
  bool showSelectedVideo = false;
  String? initialVideoId;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    initialVideoId = widget.Id.toString();
    loadJson1();
    getTrainingVideosDetails(0);
  }
   Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // Implement your refresh logic here, e.g., fetch new data
    setState(() {
      // Update the state as needed
    });
  }

  Future loadJson1() async {
    String jsonString =
        await rootBundle.loadString('assets/files/externalTraining.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      Img = jsonMap['img'];
      Pic = jsonMap['pic'];
      Details = jsonMap['details'];
    });
  }

  pageList(page) {
    switch (page) {
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

  Future getTrainingVideosDetails(from) async {
    final response =
        await http.get(Uri.parse('${Config.baseURL}listdemovideos/$from/5'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["demovideos"];
      setState(() {
        trainingVideosList = jsonData
            .map<ExternalTrainingVideosModel>(
                (data) => ExternalTrainingVideosModel.fromJson(data))
            .toList();
        if (trainingVideosList.isNotEmpty && selectedIndex == -1) {
          selectedIndex = 0;
          selectedVideoId = trainingVideosList[0].videoEmbed;
        }
      });
    } else {
      debugPrint('get call error');
    }
  }

  numberOfPages1() {
    double pgNum = trainingVideosList.length / 5;
    return pgNum.ceil();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: Config.whiteColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: AppBar(
            elevation: 0,
            backgroundColor: Config.containerColor,
            leadingWidth: 85,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: InkWell(
                child: Image.asset(
                  'assets/images/pg12-1.png',
                  height: 6.1.h,
                  width: 22.6.w,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    'External Training\nVideos',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: Config.primaryTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               
                // Container(
                //   height: 250, // Adjust height as needed
                //   child: VimeoPlayer(
                //     videoId: widget.Id!,
                //   ),
                // ),
           
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: Divider(
                  thickness: 1,
                  color: Color(0xffCCCCCC),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.h, left: 4.w, right: 4.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: trainingVideosList.length,
                    itemBuilder: (context, index) {
                      return (widget.index1 == index || indexNew == index)
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.index1 = -1;
                                    mode = 2;
                                    indexNew = index;
                                    selectedIndex = index;
                                    selectedVideoId = trainingVideosList[index].videoEmbed;
                                    showSelectedVideo = true;
                                  });
                                  _refreshIndicatorKey.currentState?.show();
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
                                                trainingVideosList[index].videoName ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Config.primaryTextColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Date: ${trainingVideosList[index].addedOn}" ?? '',
                                                  style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xff999999),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  "Duration: ${trainingVideosList[index].videoDuration}" ?? '',
                                                  style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xff999999),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Image.network(
                                          "${Config.imageURL}${trainingVideosList[index].videoThumbnail}",
                                          fit: BoxFit.fill,
                                          width: 25.w,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ),
              ),
            ],
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
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff8cb93d)),
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
      ),
    );
  }
}

// class VideoDisplayWidget extends StatelessWidget {
//   final String videoId;

//   VideoDisplayWidget({required this.videoId});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 250,
//       child: VimeoPlayer(
//         videoId: videoId,
//       ),
//     );
//   }
// }
