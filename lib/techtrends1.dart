import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Config.dart';
import 'Widgets/App_Bar_Widget.dart';

class TopicTitle extends StatefulWidget {
  final String content;
  final String title;
  final String topic;
  const TopicTitle({Key? key, required this.content, required this.title, required this.topic}) : super(key: key);

  @override
  State<TopicTitle> createState() => _TopicTitleState();
}

class _TopicTitleState extends State<TopicTitle> {


  ParaSplit(data){
    var para = data;
    var parts = para.split("\r\n\r\n");
    // debugPrint("Length : ${parts.length}");
    return parts;
  }

  @override
  Widget build(BuildContext context) {
    List value = ParaSplit(widget.content);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: App_Bar_widget2(title: 'Technology Trends'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: 100.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: Color(0xfff1f1f1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
                  //   child: Text('Technology Trends / ${widget.topic} / ${widget.title}',
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(
                  //       height: 1.25,
                  //       fontSize: 8.sp,
                  //       color: Config.pathColor,
                  //       fontWeight: FontWeight.w500
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Technology Trends',
                            style: TextStyle(
                                height: 1.25,
                                fontSize: 8.sp,
                                color: Config.pathColor,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: '/ ${widget.topic} /',
                            style: TextStyle(
                                height: 1.25,
                                fontSize: 8.sp,
                                color: Config.pathColor,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: widget.title,
                            style: TextStyle(
                                height: 1.25,
                                fontSize: 8.sp,
                                color: Config.pathColor,
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ]
                      ),
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Text(widget.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  SizedBox(height: 1.2.h,),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return (value.isEmpty) ? const Center(child: CircularProgressIndicator()) :
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value[index].toString() ?? '',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12.sp
                                ),
                              ),
                              SizedBox(height: 1.5.h),
                              (index<value.length)?
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Container(
                                  color: Config.containerColor,
                                  height: 20.h,
                                  width: 90.w,
                                  child: Center(
                                    child: Image.asset('assets/images/cad.jpg',fit: BoxFit.fill,),
                                  ),
                                ),
                              ) : Container(),
                              SizedBox(height: 1.5.h),
                            ],
                          ),
                        );
                      }),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
