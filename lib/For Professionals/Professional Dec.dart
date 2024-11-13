import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Widgets/App_Bar_Widget.dart';

class ProfessionalDec extends StatefulWidget {
  final String content;
  final String title;
  const ProfessionalDec({Key? key, required this.content, required this.title})
      : super(key: key);

  @override
  State<ProfessionalDec> createState() => _ProfessionalDecState();
}

class _ProfessionalDecState extends State<ProfessionalDec> {
  String? heading;
  String? mainheading;
  String? mainheading1;
  String? logo1;
  String? firstpara1;
  String? secondpara1;

  ParaSplit(data) {
    var para = data;
    // var parts = para.split("\r\n\r\n") || para.split("\r\n");
    var parts = para.split("\r\n\r\n");
    // debugPrint("Length : ${parts.length}");
    return parts;
  }

  @override
  void initState() {
    super.initState();
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/ProfessionalDec.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      heading = jsonMap["head"];
      mainheading1 = jsonMap["mainhead1"];
      mainheading = jsonMap["mainhead"];
      logo1 = jsonMap["logoo"];
      firstpara1 = jsonMap["firstpara"];
      secondpara1 = jsonMap["secondpara"];
    });
  }

  @override
  Widget build(BuildContext context) {
    List value = ParaSplit(widget.content);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: const App_Bar_widget2(
          title: "For Professionals\n(Career Enhancing guide)",
        ),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (widget.content == null)
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
                    width: 100.w,
                    height: 3.5.h,
                    decoration:
                        const BoxDecoration(color: Config.mainBorderColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 3.w, right: 3.w),
                          child: Text(
                            '  For Professionals / ${widget.title}',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: Config.pathColor,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w500),
                          ),
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
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return (value.isEmpty)
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value[index].toString() ?? '',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          SizedBox(height: 1.5.h),
                                          (index < value.length)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: Container(
                                                    color:
                                                        Config.containerColor,
                                                    height: 20.h,
                                                    width: 90.w,
                                                    child: Center(
                                                      child: Image.asset(
                                                        'assets/images/cad.jpg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          SizedBox(height: 1.5.h),
                                        ],
                                      ),
                                    );
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
