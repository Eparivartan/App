import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'Config.dart';
import 'Widgets/App_Bar_Widget.dart';

class AutoCadEditor extends StatefulWidget {
  const AutoCadEditor({Key? key}) : super(key: key);

  @override
  State<AutoCadEditor> createState() => _AutoCadEditorState();
}

class _AutoCadEditorState extends State<AutoCadEditor> {
  String? Img;
  String? Nos;
  String? Mail;
  String? Call;
  String? Mailing;

  @override
  void initState() {
    loadJson();
    super.initState();
  }

  Future loadJson() async {
    String jsonString =
    await rootBundle.loadString('assets/files/courses.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      Img = jsonMap['img'];
      Mail = jsonMap['mail'];
      Call = jsonMap['call'];
      Mailing = jsonMap['mailing'];
      Nos = jsonMap['nos'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget(title: 'AutoCAD ViewerEditor'),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shadowColor: Color(0xff000000).withOpacity(.29),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 12, bottom: 20),
                        child: Text(
                          'AutoCAD ViewerEditor',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xfff1f1f1),
                            ),
                          ),
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            'AutoCAD ViewerEditor\n                     API',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          height: 50.h,
                          width: 100.w,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15, width: 15),
              Card(
                elevation: 5,
                shadowColor: Color(0xff000000).withOpacity(.29),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Like what you see? \nFurther training needs? \nreach us below:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(Call ?? '', height: 20, width: 20),
                          Text(Nos ?? ''),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(Mailing ?? '', height: 20, width: 20),
                          Text(Mail ?? ''),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}