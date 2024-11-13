import 'dart:convert';

import 'package:careercoach/Home%20Page.dart';
import 'package:careercoach/sharepreferences/sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Config.dart';
import '../../Widgets/App_Bar_Widget.dart';
import 'package:http/http.dart' as http;

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  @override
  String? Useridnum;
  bool colorBool = false;

  Future<void> _loadUserId() async {
    Useridnum = (await SharedPreferencesHelper.getUserId()) ?? "Not set";

    setState(() {
      print(Useridnum.toString() +
          '-------------------------------->>>>>>>>>>>>>');
    });
  }
  //POST CALL>>>>>>>>>>>>>>>>

  Future<void> postFavourite() async {
    debugPrint("CAME TO PostTrail call");
    final url = Uri.parse('${Config.baseURL}home/postmyfavourite/endpoint.php');

    try {
      final response = await http.post(
        url,
        body: {
          'USER_ID': Useridnum.toString(),
          'PATH': jsonEncode({
            'ROOT1': "Subscription",
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

  final List<String> items = ['AutoCAD 2D', 'AutoCAD 3D', 'Revit 2D'];
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child:AppBar(
      elevation: 0,
      backgroundColor: Config.containerColor,
      leadingWidth: 85,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: InkWell(
          child: Image.asset('assets/images/pg12-1.png',height: 6.1.h,width: 22.6.w,),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()));
          },),
          
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Text('Subscriptions',
                style:TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Config.primaryTextColor
                ))),
          ),
          SizedBox(
            width: 1.w,
          ),
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
                      color: (colorBool == false)
                          ? Colors.black
                          : Config.goldColor,
                    ),
                  ),
                ),
              ),
      ],
    ),
      ),
      backgroundColor: Config.whiteColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(0xffffffff),
                border: Border.all(width: 1, color: Color(0xffEBEBEB)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 15),
                      child: Text(
                        'My Subscriptions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                      itemCount: items.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index],
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  decoration: TextDecoration.underline,
                                  color: Config.blue,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
