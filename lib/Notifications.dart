import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'Config.dart';
import 'Models/notificationsModel.dart';
import 'Widgets/App_Bar_Widget.dart';


class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>with TickerProviderStateMixin {
  List? details;
  List? details2;
  int selectedPage = 1;
  TabController? _controller;
  PageController? _pageController;
  List<AnnouncementModel> announcementsData = [];


  void displayAlert3(context, index) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date  &&  Close
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Date
                Text('(${announcementsData[index].addedOn})',
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: Color(0xff999999)),),
                //close button
                InkWell(
                  child: Card(
                      elevation: 0,
                      child: Icon(Icons.close)),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            //
            // SizedBox(height: 2.h,),
            //Title
            Text("${announcementsData[index].announceTitle}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
          content: Container(
            height: 10.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(top: 0,bottom: 8,right: 14),
                child: Text('${announcementsData[index].anDescription}',
                  style: TextStyle(color: Colors.black,
                      height: 1.5,fontWeight: FontWeight.normal,fontSize: 14),),
              ),
            ),
          ),

        ),
  );

  @override
  void initState() {
    AnnouncementsList();
    loadJson();
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _controller = TabController(length: 2, vsync: this);
    _controller?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  AnnouncementsList() async{
    debugPrint("Comming to Announcements get listannouncements");

    final response = await http.get(Uri.parse('${Config.baseURL}listannouncements'));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["announcements"];

      setState(() {
        announcementsData = jsonData.map<AnnouncementModel>((data) =>AnnouncementModel.fromJson(data)).toList() ?? [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data headers-------, $jsonData');
    }else{
      debugPrint('get call error');
    }

  }


  Future loadJson() async{
    String jsonString = await rootBundle.loadString('assets/files/Notification.json');
    debugPrint("Checking map: jsonMap");
    Map<String,dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      details = jsonMap["tab1"];
      details2=jsonMap["tab2"];
    });
  }


  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: App_Bar_widget(title: ''),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 2.h,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TabBar(
                    isScrollable: false,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    controller: _controller,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Config.containerGreenColor,
                    labelColor: Config.whiteColor,
                    labelStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: Config.primaryTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Container(
                        height: 4.h,
                        width: 46.w,
                        //margin: EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                            const BorderRadius.only(topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            color: _controller?.index == 0
                                ? Config.containerGreenColor
                                : Config.mainBorderColor),
                        child: Tab(
                          key: UniqueKey(),
                          child: Text('Notifications',
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 4.h,
                        width: 46.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                            const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            color: _controller?.index == 1
                                ? Config.containerGreenColor
                                : Config.mainBorderColor),
                        child: Tab(
                          // key: UniqueKey(),
                          child: Text(
                            'Announcements',
                            style: TextStyle(
                              fontSize: 11.sp,
                              //color: _controller.index == 1 ? Config
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 3.8.w, right: 3.8.w),
                height: 0.5.h,
                width: 100.w,
                decoration: const BoxDecoration(
                  color: Config.containerGreenColor,
                ),
              ),
              Container(
                height: 80.h,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: [
                    notification(context),
                    announcements(context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  notification(context) {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child:(details==null)? const Center(child: CircularProgressIndicator()) :
      ListView(
        children: [
          Divider(thickness: 1,),
          SizedBox(height:1.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mark All Read',style: TextStyle(decoration: TextDecoration.underline,fontSize: 11.sp,color: Config.primaryTextColor),),

              Text('Clear All',style: TextStyle(decoration: TextDecoration.underline,fontSize: 11.sp,color: Config.primaryTextColor),),
            ],
          ),
          SizedBox(height: 1.h,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: details?.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (
                BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(details?[index]["image"] ?? '',height: 5.h,),
                    Flexible(
                      child: RichText(text: TextSpan(
                          children:<TextSpan> [
                            TextSpan(
                              text: details?[index]["Text"] ?? '',recognizer: TapGestureRecognizer()..onTap = () {
                              displayAlert3(context, index);
                            },style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 11.sp),),
                            TextSpan(
                              text: details?[index]["Text1"] ?? '',
                              style: TextStyle( height: 1.5,color: Colors.blueGrey,fontSize: 11.sp),),
                            TextSpan(text:details?[index]['Text2']??'',
                                style: TextStyle(color: Colors.blueGrey,fontSize: 11.sp,height: 2.3))
                          ]
                      )
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  announcements(context) {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: ListView(
        children: [
          Divider(thickness: 1,),
          SizedBox(height:1.h,),
          //MARK all Read &&& Clear All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mark All Read',style: TextStyle(decoration: TextDecoration.underline,fontSize: 11.sp,color: Config.primaryTextColor),),

              Text('Clear All',style: TextStyle(decoration: TextDecoration.underline,fontSize: 11.sp,color: Config.primaryTextColor),),
            ],
          ),
          SizedBox(height: 1.h,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: announcementsData.length ?? 0,
            physics: ClampingScrollPhysics(),
            itemBuilder: (
                BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(details2?[index]["image"] ?? '',height: 5.h,),
                    SizedBox(width: 3.w,),
                    Flexible(
                      child: RichText(text: TextSpan(
                          children:<TextSpan> [
                            TextSpan(
                              text: "${announcementsData[index].announceTitle}\n" ?? '',
                              recognizer: TapGestureRecognizer()..onTap = () {displayAlert3(context, index);},
                              style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: Config.font_size_12.sp),),
                            TextSpan(
                              text: "${announcementsData[index].anDescription}\n" ?? '',
                              style: TextStyle( color: Colors.black,fontSize: Config.font_size_12.sp),),
                            TextSpan(
                                text:"(${announcementsData[index].addedOn})" ?? '',
                                style: TextStyle(color: Colors.blueGrey,fontSize: Config.font_size_12.sp))
                          ]
                      )
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


