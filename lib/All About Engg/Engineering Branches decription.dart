import 'dart:convert';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../Config.dart';
import '../Home Page.dart';
import '../Models/myActivityModel.dart';

class EngineeringBranchesDec extends StatefulWidget {
  final String title;
  final String content1;
  final String branch;
  final String root1;
  final String root2;
  final String index;
  const EngineeringBranchesDec(
      {Key? key,
      required this.title,
      required this.content1,
      required this.branch,
      required this.root1,
      required this.root2,
      required this.index})
      : super(key: key);

  @override
  State<EngineeringBranchesDec> createState() => _EngineeringBranchesDecState();
}

class _EngineeringBranchesDecState extends State<EngineeringBranchesDec>
    with SingleTickerProviderStateMixin {
  String? heading0;
  String? heading1;
  String? mainheading;
  String? logo1;
  String? firstpara1;
  String? secondpara1;
  String? userId;
  var jsonData;
  List<MyActivityModel> FavoriteList = [];
  var rootData;
  bool colorBool = false;

  ParaSplit(data) {
    var para = data;
    var parts = para.split("\r\n\r\n");
    // debugPrint("Length : ${parts.length}");
    return parts;
  }

  //GET CALL >>>>>>>>>

  Future GetCallDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString('userId') ?? '';
    debugPrint("came with UserId to EnggBranchesDec : $userId");

    final response =
        await http.get(Uri.parse('${Config.baseURL}myfavourites/$userId'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body)["myfavourites"];
      setState(() {
        FavoriteList = jsonData
                .map<MyActivityModel>((data) => MyActivityModel.fromJson(data))
                .toList() ??
            [];
        // getQuestionPaperDetails(0);
      });
      // rootData= jsonDecode(jsonData[1]["favPath"]);
      debugPrint("GetCall Details +(<-->)+ ${jsonData}");
      // debugPrint("GetCall Details +(<-->)+ ${rootData}");
      // debugPrint("GetCall Details +(<-->)+ ${rootData["ROOT1"]}");
      // debugPrint("GETCALL==> Details :: ++ ${(jsonData[0]["favPath"])}");
    } else {
      debugPrint('get call error');
    }
  }

  //POST CALL>>>>>>>>>>>>>>>>

  Future<void> postFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPreferencesHelper.useridkey);
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postmyfavourite/endpoint.php');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': userId,
          'PATH': jsonEncode({
            'ROOT1': widget.root1,
            'ROOT2': widget.root2,
            'INDEX': widget.index,
            'MODULE_NAME': widget.title,
          }),
        },
      );

      if (response.statusCode == 200) {
        colorBool = true;
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Success!!",
                  ),
                  content: const Text("Added to Favorite's successfully!!"),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Config.careerCoachButtonColor),
                      //return false when click on "NO"
                      child: const Text('OK'),
                    ),
                  ],
                ));
        print('Response data: ${response.body}');
      } else {
        print('Error - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending POST request: $error');
    }
  }

  @override
  void initState() {
    debugPrint("came with### ${widget.root1}");
    debugPrint("came with### ${widget.root2}");
    debugPrint("came with### ${widget.index}");
    GetCallDetails();
    getData();
    super.initState();
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/EnggBranchesDec.json');
    //debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      heading0 = jsonMap['head0'];
      heading1 = jsonMap["head1"];
      mainheading = jsonMap["mainhead"];
      logo1 = jsonMap["logoo"];
      firstpara1 = jsonMap["firstpara"];
      secondpara1 = jsonMap["secondpara"];
    });
  }

  @override
  Widget build(BuildContext context) {
    List value = ParaSplit(widget.content1);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Config.containerColor,
        leadingWidth: 85,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: InkWell(
            child: Image.asset(
              'assets/images/logo.png',
              height: 6.1.h,
              width: 22.6.w,
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
        ),
        actions: [
          Center(
            child: Text(
              widget.branch ?? '',
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: Config.primaryTextColor),
            ),
          ),
          // (FavoriteList[0].favPath["MODULE_NAME"] == {widget.title}) ?
          InkWell(
            onTap: () {
              debugPrint("Tapped On PostFav Call");
              postFavourite();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 17),
              child: InkWell(
                child: Icon(
                  Icons.star_outline_rounded,
                  color: (colorBool == false) ? Colors.black : Config.goldColor,
                ),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     debugPrint("Tapped On PostFav Call");
          //     postFavourite();
          //   },
          //   child: const Padding(
          //     padding: EdgeInsets.only(left: 10,right: 17),
          //     child: InkWell(
          //       child: Icon(Icons.star_outline_rounded,
          //         color: Config.goldColor,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (mainheading == null)
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
                      radius: 15,
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
                    decoration: const BoxDecoration(color: Color(0xffF1F1F1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 3.w, right: 3.w),
                          child: Text(
                            '  All About Engineering / ${widget.branch} / ${widget.title} ',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                                color: Config.pathColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.w, left: 4.w, right: 3.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.w),
                        Text(
                          widget.title ?? '',
                          textAlign: TextAlign.justify,
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
                              return (value.isEmpty)
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            radius: 15,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          value[index].toString() ?? '',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                        SizedBox(height: 1.5.h),
                                        (index < value.length - 1)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Container(
                                                  color: Config.containerColor,
                                                  height: 20.h,
                                                  width: 90.w,
                                                  child: Center(
                                                    child: Image.asset(
                                                      'assets/images/cad.jpg',
                                                      fit: BoxFit.fill,
                                                    ),
                                                    // Text("Ad Space",textAlign: TextAlign.center,
                                                    //   style: TextStyle(
                                                    //     fontWeight: FontWeight.bold,
                                                    //     color: Color(0xffE8E4F0),
                                                    //   ),
                                                    // ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
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
