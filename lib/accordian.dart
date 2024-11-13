import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'Config.dart';
import 'Models/softwareInUseModel.dart';

/// Main example page
class AccordionPage extends StatefulWidget //__
    {AccordionPage({Key? key}) : super(key: key);
  @override
  State<AccordionPage> createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  final _headerStyle = const TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

  final _contentStyleHeader = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700);

  final _contentStyle = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);

  final _loremIpsum =
  '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a
       1st century BC text by the Roman statesman and philosopher Cicero, with words altered,
        added, and removed to make it nonsensical and improper Latin.''';

  List<CommandsListModel> commandsList = [];
  List<CommandsListModel> commandsList1 = [];
  List<CommandsListModel> commandsList2 = [];
  List<CommandsListModel> commandsList3 = [];
  List<CommandsListModel> commandsList4 = [];
  List<CommandsListModel> commandsList5 = [];
  List<CommandsListModel> commandsList6 = [];
  List<CommandsListModel> commandsList7 = [];
  List<CommandsListModel> commandsList8 = [];
  List<CommandsListModel> commandsList9 = [];
  List<CommandsListModel> commandsList10 = [];
  List<CommandsListModel> commandsList11 = [];
  List<CommandsListModel> commandsList12 = [];
  List<CommandsListModel> commandsList13 = [];
  List<CommandsListModel> commandsList14 = [];
  List<CommandsListModel> commandsList15 = [];
  List<CommandsListModel> commandsList16 = [];
  List<CommandsListModel> commandsList17 = [];
  List<CommandsListModel> commandsList18 = [];
  List<CommandsListModel> commandsList19 = [];
  List<CommandsListModel> commandsList20 = [];
  List<CommandsListModel> commandsList21 = [];
  List<CommandsListModel> commandsList22 = [];
  List<CommandsListModel> commandsList23 = [];
  List<CommandsListModel> commandsList24 = [];
  List<CommandsListModel> commandsList25 = [];
  List<CommandsListModel> commandsList26 = [];
  String alpha = 'A';
  List? data1;

  Future getData(from) async{
    String jsonString = await rootBundle.loadString('assets/files/Software_in_use.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      data1 = jsonMap["data"];
      // head = jsonMap['main'];
      // sub = jsonMap["sub"];
      // imagee = jsonMap["Immage"];
      // logo = jsonMap["logoo"];
      // pages = jsonMap["paages"];
      // dataa = jsonMap["abt"];

    });
    debugPrint("printing Values ->> $data1");
  }

  @override
  void initState() {
    // TODO: implement initState
    getCmdDetails1();
    getCmdDetails2();
    getCmdDetails3();
    getCmdDetails4();
    getCmdDetails5();
    getCmdDetails6();
    getCmdDetails7();
    getCmdDetails8();
    getCmdDetails9();
    getCmdDetails10();
    getCmdDetails11();
    getCmdDetails12();
    getCmdDetails13();
    getCmdDetails14();
    getCmdDetails15();
    getCmdDetails16();
    getCmdDetails17();
    getCmdDetails18();
    getCmdDetails19();
    getCmdDetails20();
    getCmdDetails21();
    getCmdDetails22();
    getCmdDetails23();
    getCmdDetails24();
    getCmdDetails25();
    getCmdDetails26();
    super.initState();
  }

  Future getCmdDetails1() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/A'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList1 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails2() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/B'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList2 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList2}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails3() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/C'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList3 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails4() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/D'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList4 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails5() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/E'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList5 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails6() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/F'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList6 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails7() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/G'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList7 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails8() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/H'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList8 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }
  }
  Future getCmdDetails9() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/I'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList9 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands9, ${commandsList9}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails10() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/J'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList10 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList2}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails11() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/K'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList11 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails12() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/L'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList12 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails13() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/M'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList13 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails14() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/N'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList14 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails15() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/O'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList15 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails16() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/P'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList16 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }
  }
  Future getCmdDetails17() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/Q'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList17 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails18() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/R'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList18 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails19() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/S'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList19 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails20() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/T'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList20 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }
  }
  Future getCmdDetails21() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/U'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList21 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails22() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/V'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList22 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList2}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails23() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/W'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList23 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails24() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/X'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList24 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails25() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/Y'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList25 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }
  Future getCmdDetails26() async{

    final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/Z'));
    if(response.statusCode == 200){
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList26 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    }else{
      debugPrint('getCmdDetails2 get call error');
    }

  }

  @override
  build(context) => Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      backgroundColor: Config.containerGreenColor,
      title: const Text('CAREER COACH'),
    ),
    body: Accordion(
      maxOpenSections: 1,
      headerBackgroundColorOpened: Colors.white,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: [
        //1
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: InkWell(
            // onTap: () {
            //   setState((){
            //     alpha = data1?[0]["Topic"];
            //     debugPrint("going with aphabet: ${alpha}");
            //     getCmdDetails1();
            //   });
            // },
            child: Container(
                child: Text('A', style: _headerStyle)),
          ),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList1.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList1[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList1[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //2
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('B', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList2.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList2[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList2[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //3
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('C', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList3.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList3[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList3[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //4
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('D', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList4.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  commandsList4.isEmpty ? Text('\n\nNO DATA TO DISPLAY', style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black
                  ),) :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList4[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList4[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //5
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('E', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList5.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList5[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList5[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //6
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('F', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList6.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList6[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList6[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //7
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('G', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList7.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList7[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList7[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //8
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('H', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList8.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList8[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList8[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //9
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: InkWell(
            // onTap: () {
            //   setState((){
            //     alpha = data1?[0]["Topic"];
            //     debugPrint("going with aphabet: ${alpha}");
            //     getCmdDetails1();
            //   });
            // },
            child: Container(
                child: Text('I', style: _headerStyle)),
          ),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList9.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList9[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList9[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //10
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('J', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList10.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList10[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList10[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //11
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('K', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList11.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList11[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList11[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //12
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('L', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList12.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  commandsList12.isEmpty ? Text('\n\nNO DATA TO DISPLAY', style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black
                  ),) :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList12[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList12[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //13
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('M', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList13.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList13[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList13[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //14
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('N', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList14.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList14[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList14[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //15
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('O', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList15.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList15[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList15[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //16
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('P', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList16.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList16[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList16[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //17
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('Q', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList17.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList17[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList17[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //18
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('R', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList18.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList18[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList18[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //19
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('S', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList19.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList19[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList19[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //20
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('T', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList20.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  commandsList20.isEmpty ? Text('\n\nNO DATA TO DISPLAY', style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black
                  ),) :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList20[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList20[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //21
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('U', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList21.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList21[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList21[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //22
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('V', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList22.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList22[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList22[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //23
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('W', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList23.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList23[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList23[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //24
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('X', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList24.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList24[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList24[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //25
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('Y', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList25.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList25[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList25[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        //26
        AccordionSection(
          isOpen: false,
          rightIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: Text('Z', style: _headerStyle),
          content: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: commandsList26.length ?? 0,
              itemBuilder: (context, indexes) {
                return
                  // commandList.length==0 ? CircularProgressIndicator() :
                  Column(
                    children: [
                      // const Divider(thickness: 1, color: Config.mainBorderColor),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                              child: Container(
                                width: 10.w,
                                child: Text(commandsList26[indexes].swCode.toString()),
                              )
                          ),
                          // SizedBox(width: 3.w,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60.w,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                  text: commandsList26[indexes].codeDescription ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                              )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
              }
          ),
          // content: Text(_loremIpsum, style: _contentStyle),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
      ],
    ),
  );
} //__