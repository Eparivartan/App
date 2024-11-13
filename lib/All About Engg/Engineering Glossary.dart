




import 'dart:async';
import 'dart:convert';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Config.dart';
import '../Models/allAboutEngineeringModel.dart';
import '../Models/headerModel.dart';
import '../Models/softwareInUseModel.dart';
import '../Widgets/App_Bar_Widget.dart';
import 'Engineering glossary decription.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class EngineeringGlossary extends StatefulWidget {
  const EngineeringGlossary({Key? key}) : super(key: key);

  @override
  State<EngineeringGlossary> createState() => _EngineeringGlossaryState();
}

class _EngineeringGlossaryState extends State<EngineeringGlossary> {
  List? data;
  String? head;
  String? sub;
  String? imagee;
  String? logo;
  String? discreption;
  List? expntile;
  List? text;
  String? _value;
  String? drophead;
  List<BranchDropdownModel> branchDropdown = [];
  List<EngineeringGlossaryModel> enggGlossary = [];
  List<EngineeringGlossaryModel> enggGlossaryA = [];
  List engineeringGlossaryAlphabetWiseList = [];
  String? enggGlossA = "A";
  List<headerModel> headerList = [];

  late TabController _controller;

  @override
  void initState() {
    getData();
    getDetails();
    getDetails1();
    HeaderList();
    super.initState();
  }

  //POST CALL

  Future postTrail1() async {
    debugPrint("CAME TO PostTrail call");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Config.baseURL}home/postquery'));
    request.headers.addAll({
      'Content-Type': 'application/json',
    });
    // final response = await http.post(Uri.parse('${Config.baseURL}home/postquery'), headers: {
    //   "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    // },
    request.fields['data'] = jsonEncode({
      'NAME': 'teja',
      'MAIL_ID': 'teja@gmail.comm',
      'SUBJECT': "HELLO ",
      "Details": 'Lorem Ipsum is simply dummy text of the.'
    }

        //     body: {
        //   'NAME': 'teja',
        //   'MAIL_ID': 'teja@gmail.comm',
        //   'SUBJECT': "HELLO ",
        //   "Details" : 'Lorem Ipsum is simply dummy text of the.'
        // }
        );
    // if (response.statusCode == 200) {
    //   debugPrint('Successfully uploaded');
    //   setState(() {
    //     _imageFile = null;
    //   });
    //   getDetails();
    // } else if (response.statusCode == 401){
    //   // debugPrint('failed');
    //   debugPrint(response.body);
    // }
    //
    // //await FlutterSession().set('email', email);
    // /*try {
    //   if (response.statusCode == 201) {
    //     debugPrint(response.body);
    //     int userId = jsonDecode(response.body)["userId"];
    //     debugPrint("CAME TO SUCCESS: PostTrail");
    //
    //     Timer(
    //       const Duration(seconds: 2),
    //           () => Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) =>  const HomePage(),
    //         ),
    //       ),
    //     );
    //   }
    //   else if(response.statusCode == 401){
    //     debugPrint("CAME TO error pg_nt_fnd: PostTrail");
    //     debugPrint(response.body);
    //     return showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: const Text(
    //             "Failed",
    //           ),
    //           content:  const Text("Your Request was Failed!!"),
    //           actions: <Widget>[
    //             TextButton(
    //               child: const Text("OK"),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //                 Navigator.pushReplacement(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) =>
    //                     const HomePage(),
    //                   ),
    //                 );
    //               },
    //             )
    //           ],
    //         ));
    //   }
    // } */
    // catch (e) {
    //   print(e);
    // }
  }

  Future postTrail23() async {
    debugPrint("CAME TO PostTrail call");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Config.baseURL}home/postquery'));
    request.headers.addAll({
      'Content-Type': 'application/json',
    });
    // final response = await http.post(Uri.parse('${Config.baseURL}home/postquery'), headers: {
    //   "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    // },
    request.fields['data'] = jsonEncode({
      'NAME': 'teja',
      'MAIL_ID': 'teja@gmail.comm',
      'SUBJECT': "HELLO ",
      "Details": 'Lorem Ipsum is simply dummy text of the.'
    }

        //     body: {
        //   'NAME': 'teja',
        //   'MAIL_ID': 'teja@gmail.comm',
        //   'SUBJECT': "HELLO ",
        //   "Details" : 'Lorem Ipsum is simply dummy text of the.'
        // }
        );
    // if (response.statusCode == 200) {
    //   debugPrint('Successfully uploaded');
    //   setState(() {
    //     _imageFile = null;
    //   });
    //   getDetails();
    // } else if (response.statusCode == 401){
    //   // debugPrint('failed');
    //   debugPrint(response.body);
    // }
    //
    // //await FlutterSession().set('email', email);
    // /*try {
    //   if (response.statusCode == 201) {
    //     debugPrint(response.body);
    //     int userId = jsonDecode(response.body)["userId"];
    //     debugPrint("CAME TO SUCCESS: PostTrail");
    //
    //     Timer(
    //       const Duration(seconds: 2),
    //           () => Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) =>  const HomePage(),
    //         ),
    //       ),
    //     );
    //   }
    //   else if(response.statusCode == 401){
    //     debugPrint("CAME TO error pg_nt_fnd: PostTrail");
    //     debugPrint(response.body);
    //     return showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: const Text(
    //             "Failed",
    //           ),
    //           content:  const Text("Your Request was Failed!!"),
    //           actions: <Widget>[
    //             TextButton(
    //               child: const Text("OK"),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //                 Navigator.pushReplacement(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) =>
    //                     const HomePage(),
    //                   ),
    //                 );
    //               },
    //             )
    //           ],
    //         ));
    //   }
    // } */
    // catch (e) {
    //   print(e);
    // }
  }

  List<EngineeringGlossaryModel> enggGlossary1 = [];
  List<EngineeringGlossaryModel> enggGlossary2 = [];
  List<EngineeringGlossaryModel> enggGlossary3 = [];
  List<EngineeringGlossaryModel> enggGlossary4 = [];
  List<EngineeringGlossaryModel> enggGlossary5 = [];
  List<EngineeringGlossaryModel> enggGlossary6 = [];
  List<EngineeringGlossaryModel> enggGlossary7 = [];
  List<EngineeringGlossaryModel> enggGlossary8 = [];
  List<EngineeringGlossaryModel> enggGlossary9 = [];
  List<EngineeringGlossaryModel> enggGlossary10 = [];
  List<EngineeringGlossaryModel> enggGlossary11 = [];
  List<EngineeringGlossaryModel> enggGlossary12 = [];
  List<EngineeringGlossaryModel> enggGlossary13 = [];
  List<EngineeringGlossaryModel> enggGlossary14 = [];
  List<EngineeringGlossaryModel> enggGlossary15 = [];
  List<EngineeringGlossaryModel> enggGlossary16 = [];
  List<EngineeringGlossaryModel> enggGlossary17 = [];
  List<EngineeringGlossaryModel> enggGlossary18 = [];
  List<EngineeringGlossaryModel> enggGlossary19 = [];
  List<EngineeringGlossaryModel> enggGlossary20 = [];
  List<EngineeringGlossaryModel> enggGlossary21 = [];
  List<EngineeringGlossaryModel> enggGlossary22 = [];
  List<EngineeringGlossaryModel> enggGlossary23 = [];
  List<EngineeringGlossaryModel> enggGlossary24 = [];
  List<EngineeringGlossaryModel> enggGlossary25 = [];
  List<EngineeringGlossaryModel> enggGlossary26 = [];

  //PT_PlFl_cll ------ ${Config.baseURL}home/postquery/endpoint.php

  /////////////////////////

  Future getenggGlossary1() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/A'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary1 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary2() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/B'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary2 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary2}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary3() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/C'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary3 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary4() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/D'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary4 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary5() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/E'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary5 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary6() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/F'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary6 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary7() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/G'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary7 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary8() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/H'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary8 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary9() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/I'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary9 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands9, ${enggGlossary9}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary10() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/J'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary10 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary2}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary11() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/K'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary11 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary12() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/L'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary12 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary13() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/M'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary13 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary14() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/N'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary14 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary15() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/O'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary15 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary16() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/P'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary16 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary17() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/Q'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary17 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary18() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/R'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary18 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary19() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/S'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary19 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary20() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/T'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary20 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary21() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/U'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary21 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary22() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/V'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary22 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary2}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary23() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/W'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary23 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary24() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/X'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary24 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary25() async {
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/Y'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary25 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  Future getenggGlossary26() async {
    // debugPrint("------------${getDropdownValue()}------------");
    final response = await http.get(
        Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/Z'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        // commandList = jsonData;
        enggGlossary26 = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${enggGlossary1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getenggGlossary2 get call error');
    }
  }

  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  Future HeaderList() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listheaders'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];

      setState(() {
        headerList = jsonData
                .map<headerModel>((data) => headerModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data headers, $jsonData');
      debugPrint('printing header List, ${headerList[6].headerName}');
    } else {
      debugPrint('get call error');
    }
  }

  // Future getCmdDetails1() async{
  //
  //   final response = await http.get(Uri.parse('${Config.baseURL}listengglossary/${getDropdownValue()}/A'));
  //   if(response.statusCode == 200){
  //     // selected = -1;
  //     var jsonData = jsonDecode(response.body)["listcommands"];
  //     setState(() {
  //       // commandList = jsonData;
  //       commandsList1 = jsonData.map<EngineeringGlossaryModel>((data) =>EngineeringGlossaryModel.fromJson(data)).toList() ?? [];
  //     });
  //     // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
  //     debugPrint('printing jsondata of commands, $jsonData');
  //     debugPrint('printing commandListttt of commands, ${commandsList1}');
  //     // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
  //   }else{
  //     debugPrint('getCmdDetails2 get call error');
  //   }
  //
  // }

  pageList(page) {
    switch (page) {
      case 1:
        engineeringGlossaryAlphabetWise(0);
        break;
      case 2:
        engineeringGlossaryAlphabetWise(5);
        break;
      case 3:
        engineeringGlossaryAlphabetWise(10);
        break;
      case 4:
        engineeringGlossaryAlphabetWise(15);
        break;
      case 5:
        engineeringGlossaryAlphabetWise(20);
        break;
      case 6:
        engineeringGlossaryAlphabetWise(25);
        break;
      default:
        engineeringGlossaryAlphabetWise(30);
    }
  }

  numberOfPages() {
    double pgNum = 26 / 7;
    return pgNum.ceil();
  }

  Future getDetails() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listcategory'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];
      setState(() {
        branchDropdown = jsonData
                .map<BranchDropdownModel>(
                    (data) => BranchDropdownModel.fromJson(data))
                .toList() ??
            [];
      });
    } else {
      debugPrint('get call error');
    }
  }

  Future getDetails1() async {
    final response =
        await http.get(Uri.parse('${Config.baseURL}listengglossary/2/0/5'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["engineeringglossary"];
      setState(() {
        enggGlossary = jsonData
                .map<EngineeringGlossaryModel>(
                    (data) => EngineeringGlossaryModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint("printing getDetails1------>> ${enggGlossary}");
    } else {
      debugPrint('get call error');
    }
  }

  engineeringGlossaryAlphabetWise(from) async {
    engineeringGlossaryAlphabetWiseList.clear();
    final response =
        await http.get(Uri.parse('assets/files/EnggGlossary.json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body)["tile"];
      var glossary = jsonData;
      setState(() {
        engineeringGlossaryAlphabetWiseList.add(glossary);
      });
    } else {
      debugPrint('getDetailsJob get call error');
    }
  }

  Future getData() async {
    String jsonString =
        await rootBundle.loadString('assets/files/EnggGlossary.json');
    //debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    //debugPrint("Checking map : $jsonMap");
    setState(() {
      head = jsonMap['main'];
      sub = jsonMap["sub"];
      imagee = jsonMap["Immage"];
      logo = jsonMap["logoo"];
      discreption = jsonMap["heading"];
      expntile = jsonMap["Tile"];
      text = jsonMap["textin"];
      drophead = jsonMap["dropHeadd"];
    });
  }

  getDropdownValue() {
    int val;
    if (selectedValue == 'Mechanical') {
      return val = 1;
    } else if (selectedValue == 'Architecture') {
      return val = 2;
    } else if (selectedValue == 'Civil') {
      return val = 3;
    }
  }

  final _headerStyle = const TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

  final List<String> items = [
    'Architecture',
    'Civil',
    'Mechanical',
    'All',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget(title: head ?? ''),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: (expntile == null)
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
              ))
            : ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.w),
                        headerList.isEmpty
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
                            : Text(
                                headerList.isNotEmpty
                                    ? (headerList[9].headerContent ?? '')
                                    : '',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),
                        SizedBox(
                          height: 2.h,
                        ),
                        //Branch DropDown
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              drophead ?? '',
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                            DropdownButton2(
                              dropdownElevation: 5,
                              isExpanded: true,
                              hint: const Text(
                                'Select',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              selectedItemHighlightColor: Colors.lightGreen,
                              underline: Container(),
                              items: branchDropdown
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.cname,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            item.cname ?? "",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                  getDropdownValue();
                                  getenggGlossary1();
                                  getenggGlossary2();
                                  getenggGlossary3();
                                  getenggGlossary4();
                                  getenggGlossary5();
                                  getenggGlossary6();
                                  getenggGlossary7();
                                  getenggGlossary8();
                                  getenggGlossary9();
                                  getenggGlossary10();
                                  getenggGlossary11();
                                  getenggGlossary12();
                                  getenggGlossary13();
                                  getenggGlossary14();
                                  getenggGlossary15();
                                  getenggGlossary16();
                                  getenggGlossary17();
                                  getenggGlossary18();
                                  getenggGlossary19();
                                  getenggGlossary20();
                                  getenggGlossary21();
                                  getenggGlossary22();
                                  getenggGlossary23();
                                  getenggGlossary24();
                                  getenggGlossary25();
                                  getenggGlossary26();
                                });
                              },
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              iconSize: 30,
                              iconEnabledColor: Colors.black,
                              //barrierColor: Colors.green.withOpacity(0.2),
                              // iconDisabledColor: Colors.grey,
                              buttonHeight: 4.h,
                              buttonWidth: 65.06.w,
                              buttonPadding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Color(0XFFF1F1F1)),
                                color: Colors.white,
                              ),
                              buttonElevation: 0,
                              itemHeight: 30,
                              itemPadding: const EdgeInsets.only(
                                  left: 1, right: 1, top: 0, bottom: 0),
                              dropdownWidth: 65.06.w,
                              dropdownMaxHeight: 100.h,
                              dropdownPadding: null,
                              //EdgeInsets.all(1),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Colors.grey.shade100,
                              ),
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.w),
                        const Divider(thickness: 1),
                        Accordion(
                          disableScrolling: true,
                          maxOpenSections: 1,
                          headerBackgroundColorOpened: Colors.white,
                          scaleWhenAnimating: true,
                          openAndCloseAnimation: true,
                          headerPadding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15),
                          sectionOpeningHapticFeedback:
                              SectionHapticFeedback.heavy,
                          sectionClosingHapticFeedback:
                              SectionHapticFeedback.light,
                          children: [
                            //1
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('A', style: _headerStyle),
                              content: (enggGlossary1.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary1.length ?? 0,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary1[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary1[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary1[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //2
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('B', style: _headerStyle),
                              content: (enggGlossary2.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary2.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary2[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary2[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary2[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //3
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('C', style: _headerStyle),
                              content: (enggGlossary3.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary3.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary3[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary3[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary3[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //4
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('D', style: _headerStyle),
                              content: (enggGlossary4.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary4.length,
                                          itemBuilder: (context, index) {
                                            return (enggGlossary4.length == 0)
                                                ? Text(
                                                    '\n\n\n\nNO DATA TO DISPLAY',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: Colors.black),
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        child: Text(
                                                          enggGlossary4[index]
                                                                  .postTitle ??
                                                              'NO DATA TO DISPLAY',
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              height: 2,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        ),
                                                        onTap: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EngineeringGlossaryDec(
                                                                            content:
                                                                                enggGlossary4[index].postContent ?? '',
                                                                            title:
                                                                                enggGlossary4[index].postTitle ?? '',
                                                                          )));
                                                        },
                                                      ),
                                                    ],
                                                  );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //5
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('E', style: _headerStyle),
                              content: (enggGlossary5.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary5.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary5[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary5[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary5[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //6
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('F', style: _headerStyle),
                              content: (enggGlossary6.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary6.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary6[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary6[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary6[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //7
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('G', style: _headerStyle),
                              content: (enggGlossary7.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary7.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary7[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary7[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary7[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //8
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('H', style: _headerStyle),
                              content: (enggGlossary8.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary8.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary8[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary8[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary8[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //9
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('I', style: _headerStyle),
                              content: (enggGlossary9.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary9.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary9[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary9[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary9[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //10
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('J', style: _headerStyle),
                              content: (enggGlossary10.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary10.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary10[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary10[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary10[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //11
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('K', style: _headerStyle),
                              content: (enggGlossary11.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary11.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary11[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary11[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary11[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //12
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('L', style: _headerStyle),
                              content: (enggGlossary12.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary12.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary12[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary12[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary12[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //13
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('M', style: _headerStyle),
                              content: (enggGlossary13.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary13.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary13[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary13[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary13[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //14
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('N', style: _headerStyle),
                              content: (enggGlossary14.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary14.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary14[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary14[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary14[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //15
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('O', style: _headerStyle),
                              content: (enggGlossary15.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary15.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary15[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary15[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary15[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //16
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('P', style: _headerStyle),
                              content: (enggGlossary16.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary16.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary16[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary16[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary16[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //17
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('Q', style: _headerStyle),
                              content: (enggGlossary17.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary17.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary17[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary17[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary17[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //18
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('R', style: _headerStyle),
                              content: (enggGlossary18.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary18.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary18[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary18[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary18[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //19
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('S', style: _headerStyle),
                              content: (enggGlossary19.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary19.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary19[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary19[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary19[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //20
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('T', style: _headerStyle),
                              content: (enggGlossary20.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary20.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary20[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary20[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary20[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //21
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('U', style: _headerStyle),
                              content: (enggGlossary21.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary21.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary21[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary21[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary21[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //22
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('V', style: _headerStyle),
                              content: (enggGlossary22.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary22.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary22[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary22[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary22[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //23
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('W', style: _headerStyle),
                              content: (enggGlossary23.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary23.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary23[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary23[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary23[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                            //24
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('X', style: _headerStyle),
                              content: (enggGlossary24.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary24.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary24[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary24[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary24[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //25
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('Y', style: _headerStyle),
                              content: (enggGlossary25.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary25.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary25[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary25[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary25[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                            ),
                            //26
                            AccordionSection(
                              isOpen: false,
                              rightIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black),
                              headerBackgroundColor: Colors.grey.shade100,
                              headerBackgroundColorOpened: Colors.white,
                              header: Text('Z', style: _headerStyle),
                              content: (enggGlossary26.length == 0)
                                  ? (Container(
                                      child: Text(
                                        'NO DATA TO DISPLAY',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: enggGlossary26.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    enggGlossary26[index]
                                                            .postTitle ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EngineeringGlossaryDec(
                                                                  content: enggGlossary26[
                                                                              index]
                                                                          .postContent ??
                                                                      '',
                                                                  title: enggGlossary26[
                                                                              index]
                                                                          .postTitle ??
                                                                      '',
                                                                )));
                                                  },
                                                ),
                                              ],
                                            );
                                          })),
                              // content: Text(_loremIpsum, style: _contentStyle),
                              contentHorizontalPadding: 20,
                              contentBorderWidth: 1,
                              // onOpenSection: () => print('onOpenSection ...'),
                              // onCloseSection: () => print('onCloseSection ...'),
                            ),
                          ],
                        ),

                        /*ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: expntile?.length ?? 0,
                      itemBuilder: (context, index){
                        return ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 5),
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              //borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Config.mainBorderColor,width: 1)
                            ),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                backgroundColor: Config.containerColor,
                                collapsedBackgroundColor: Colors.white,
                                title: Text(expntile?[index]["Topic"] ?? '',
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Config.primaryTextColor
                                  ),),
                                iconColor: Colors.black,
                                children: [
                                  const Divider(thickness: 1,color: Config.mainBorderColor,),
                                  Padding(padding: const EdgeInsets.only(top: 0, bottom: 16, left: 8, right: 8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(),
                                          itemCount: enggGlossary.length,
                                          itemBuilder: (context, index){
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Text(enggGlossary[index].postTitle ?? '',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        height: 2,
                                                        fontStyle: FontStyle.italic,
                                                        decoration: TextDecoration.underline),),
                                                  onTap: (){
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(builder: (context) => EngineeringGlossaryDec(
                                                          content: enggGlossary[index].postContent ?? '',
                                                          title: enggGlossary[index].postTitle ?? '',
                                                          )
                                                        )
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          }
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),*/
                      ],
                    ),
                  ),
                ],
              ),
      ),
/*
      bottomNavigationBar: BottomAppBar(
        //pages pagination
        child: PaginationWidget(
          numOfPages: numberOfPages(),
          selectedPage: selectedPage,
          pagesVisible: 3,
          spacing: 0,
          onPageChanged: (page) {
            pageList(page);
            setState(() {
              selectedPage = page;
            });
          },
          nextIcon: const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
          previousIcon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
          activeTextStyle: const TextStyle(
            color: Color(0xffffffff),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          activeBtnStyle: ButtonStyle(
            visualDensity:
            const VisualDensity(horizontal: -4),
            backgroundColor:
            MaterialStateProperty.all(
                const Color(0xff8cb93d)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color(0xfff1f1f1),
                  width: 2,
                ),
              ),
            ),
            padding: MaterialStateProperty.all(
                const EdgeInsets.all(12)),
            shadowColor:
            MaterialStateProperty.all(
              const Color(0xfff1f1f1),
            ),
          ),
          inactiveBtnStyle: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.all(20)),
            visualDensity:
            const VisualDensity(horizontal: 0),
            elevation:
            MaterialStateProperty.all(0),
            backgroundColor:
            MaterialStateProperty.all(
              const Color(0xfff9f9fb),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(15),
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
*/
    );
  }
}
