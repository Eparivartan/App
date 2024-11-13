import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';

class EngineeringGlossaryDec extends StatefulWidget {
  final String content;
  final String title;
  const EngineeringGlossaryDec({Key? key, required this.content, required this.title}) : super(key: key);

  @override
  State<EngineeringGlossaryDec> createState() => _EngineeringGlossaryDecState();
}

class _EngineeringGlossaryDecState extends State<EngineeringGlossaryDec> with SingleTickerProviderStateMixin{

  String? heading0;
  String? heading1;
  String? mainheading;
  String? logo1;
  String? firstpara1;
  String? secondpara1;


  @override
  void initState(){
    getData();
    super.initState();
  }

  Future getData() async{
    String jsonString = await rootBundle.loadString('assets/files/EnggGlossaryDec.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      heading0 = jsonMap['head0'];
      heading1 = jsonMap["head1"];
      mainheading = jsonMap["mainhead"];
      logo1 = jsonMap["logoo"];
      firstpara1 = jsonMap["firstpara"];
      secondpara1 = jsonMap["secondpara"];
    });
  }

  ParaSplit(data){
    var para = data;
    var parts = para.split("\r\n\r\n");
    // debugPrint("Length : ${parts.length}");
    return parts;
  }



  @override

  Widget build(BuildContext context) {
    List value = ParaSplit(widget.content);

    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget(title: 'Engineering Glossary'),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (mainheading == null)? const Center(child: CircularProgressIndicator()):
        ListView(
          children: [
            Container(
              width: 100.w,
              height: 3.5.h,
              decoration: const BoxDecoration(
                  color: Color(0xffF1F1F1)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  ${content}  ${title}
                  Padding(
                    padding: EdgeInsets.only(left: 3.w, right: 4.w),
                    child: Text('  All About Engineering / Engineering Glossary / ${widget.title} ',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w600,
                          color: Config.pathColor
                      ),),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0, left: 4.w, right: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.w),
                  Text(widget.title ?? '',textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return (value.isEmpty) ? const Center(child: CircularProgressIndicator()) :
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(value[index].toString() ?? '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12.sp
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            (index<value.length-1)?
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                color: Config.containerColor,
                                height: 20.h,
                                width: 90.w,
                                child: Center(
                                  child: Image.asset('assets/images/cad.jpg',fit: BoxFit.fill,),
                                  // Text("Ad Space",textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Color(0xffE8E4F0),
                                  //   ),
                                  // ),
                                ),
                              ),
                            ) : Container(),
                            SizedBox(height: 1.5.h),
                          ],
                        );
                      }),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
