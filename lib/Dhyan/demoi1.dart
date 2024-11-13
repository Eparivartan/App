import 'package:careercoach/Config.dart';
import 'package:careercoach/Widgets/App_Bar_Widget.dart';
import 'package:careercoach/Widgets/pagination.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'dart:convert';

import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<dynamic> dhyanVideosList = [];
  bool isLoading = true;
  int selectedPage = 1;
  final int totalPages = 20;
  String? selectedVideoId;
  String? selectedVedioName;
  String? selectedVedioDate;
  String? selectedVedioDuration;
  bool showSelectedVideo = false;
  numberOfPages1() {
    double pgNum = dhyanVideosList.length / 5;
    return pgNum.ceil();
  }

  @override
  void initState() {
    super.initState();
    pageList(selectedPage);
  }

  Future<void> getDhyanVideosListDetails(int from) async {
    try {
      final response = await http.get(
          Uri.parse('https://psmprojects.net/cadworld/listdemovideos/$from/5'));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)["demovideos"];
        setState(() {
          dhyanVideosList = jsonData;
          isLoading = false;
        });
      } else {
        debugPrint('Failed to load videos: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching videos: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void pageList(int page) {
    getDhyanVideosListDetails((page - 1) * 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget(
          title: 'External Training\nVideos',
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                                selectedVedioName.toString(),
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
                                  "Date:" + selectedVedioDate.toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff999999),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  "Duration:" + selectedVedioDuration.toString(),
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
                Expanded(
                  child: ListView.builder(
                    itemCount: dhyanVideosList.length,
                    itemBuilder: (context, index) {
                      final video = dhyanVideosList[index];
                      return Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedVideoId = video['videoEmbed'];
                              selectedVedioName =
                                  video['videoName'] ?? ''.toString();
                              selectedVedioDate =
                                  "${video['addedOn']}" ?? ''.toString();
                              selectedVedioDuration =
                                  " ${video['videoDuration']}" ?? ''.toString();
                              showSelectedVideo = true;
                              print(selectedVideoId.toString());
                              print(selectedVedioName.toString());
                              print(selectedVedioDate.toString());
                              print(selectedVedioDuration.toString());
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 1, color: Color(0XFFF1F1F1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0, left: 16.0, bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(
                                          video['videoName'] ?? '',
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
                                            "Date: ${video['addedOn']}" ?? '',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff999999),
                                            ),
                                          ),
                                          SizedBox(width: 16.0),
                                          Text(
                                            "Duration: ${video['videoDuration']}" ??
                                                '',
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
                                ),
                                Container(
                                  child: Image.network(
                                    "${Config.imageURL}" +
                                        (video['videoThumbnail'] ?? ''),
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Pagination buttons
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
