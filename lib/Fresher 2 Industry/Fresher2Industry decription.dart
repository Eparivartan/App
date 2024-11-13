import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../Config.dart';
import '../Models/TechnologyFresherProfessionalModel.dart';
import '../Widgets/App_Bar_Widget.dart';

class Fresher2IndustryDec extends StatefulWidget {
  final String content;
  final String title;
  final String type;


    const Fresher2IndustryDec({Key? key, required this.content, required this.title, required this.type }) : super(key: key);

  @override
  State<Fresher2IndustryDec> createState() => _Fresher2IndustryDecState();
}

class _Fresher2IndustryDecState extends State<Fresher2IndustryDec> {

  String? heading;
  String? mainheading;
  String? mainheading1;
  String? logo1;
  String? firstpara1;
  String? secondpara1;
  List<TechnologyFresherProfessionalModel> fresherJobTypes = [];


  ParaSplit(data){
    var para = data;
    var parts = para.split("\r\n\r\n");
    // debugPrint("Length : ${parts.length}");
    return parts;
  }

  @override
  void initState(){
    getDetails();
    super.initState();
  }

  Future getDetails() async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String userId = await prefs.getString('userId') ?? '';

    final response = await http.get(Uri.parse('${Config.baseURL}listjobtypes/0/5'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["listjobtypes"];
      //var jsonData = (jsonDecode(response.body) as List).map((e) => Fresher2IndustryJobTypesModel.fromJson(e)).toList();

      setState(() {
        fresherJobTypes = jsonData.map<TechnologyFresherProfessionalModel>((data) =>TechnologyFresherProfessionalModel.fromJson(data)).toList() ?? [];
        //  var showLoading = false;
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json Model, $TechnologyFresherProfessionalModel');
    }else{
      debugPrint('get call error');
    }
    debugPrint("Fresher2Industry123 : $fresherJobTypes");
    // debugPrint("Service Details : $serviceDetails");
  }

  @override
  Widget build(BuildContext context) {
    List value = ParaSplit(widget.content);
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: const App_Bar_widget2(title: "Fresher 2 Industry\n(Students career builder)"),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (widget.content == null)? const Center(child: CircularProgressIndicator()):
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
                  Padding(
                    padding: EdgeInsets.only(left: 3.w, right: 3.w),
                    child: Text('  Fresher 2 Industry / ${widget.type} / ${widget.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Config.pathColor,
                        fontWeight: FontWeight.w500
                    ),),
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
  }}
