import 'dart:convert';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Models/headerModel.dart';
import 'Models/softwareInUseModel.dart';
import 'SqlLiteDB/db_helper.dart';
import 'Widgets/App_Bar_Widget.dart';
import 'package:http/http.dart' as http;
import 'Widgets/pagination.dart';
import 'config.dart';

class SoftwareInUse extends StatefulWidget {
  const SoftwareInUse({Key? key}) : super(key: key);

  @override
  State<SoftwareInUse> createState() => _SoftwareInUseState();
}

class _SoftwareInUseState extends State<SoftwareInUse>
    with SingleTickerProviderStateMixin {
  List? data1;
  String? head;
  String? sub;
  String? imagee;
  String? logo;
  List? pages;
  List? dataa;
  String? _value1;
  String? _value2;
  String? drophead;
  String? activePage;
  bool changeButtonColor = true;
  int widgetType = 1;
  TabController? _controller;
  PageController? _pageController;
  List<BranchDropdownModel> branchDropdown = [];
  List<BranchDropdownModel> commandsBranchDropdown = [];
  List<SelectSoftwareDropdownModel> selectSoftwareDropdown = [];
  List<SelectSoftwareDropdownModel> selectCommandDropdown = [];
  List<SelectSoftwareDropdownModel> selectSoftwareDropdown1 = [];
  List commandList = [];
  List<CommandsListModel> softwareList = [];
  List<CommandsListModel> commandsList = [];
  List<CommandsListModel> softwareList1 = [];
  List<headerModel> headerList = [];
  bool tileExpanded = false;
  int selectedTile = -1;
  int selectedPage = 1;
  String? selectedValue;
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  int? selectedId;
  int? selected = -1;
  bool value = true;
  String alpha = 'A';

  _expansion(bool expanding, int index) {
    if (expanding) {
      selected = -1;
      debugPrint("expansion value: " + index.toString());
      // getCmdDetails2(data1?[index]["Topic"].toString());
      setState(() {
        // const Duration(seconds:  20000);
        selected = index;
      });
    } else {
      setState(() {
        selected = -1;
      });
    }
  }

  saveToRecent() async {
    // If no internet, insert data into the local database
    // Insert data into the local database
    await DatabaseHelper.addData({
      'VIEWED_TAB': "Software In Use And Commands",
    });
    List<Map<String, dynamic>>? localData = await DatabaseHelper.getAllData();
    print(localData);
    debugPrint("printing::1234::: $localData");
  }

  @override
  void initState() {
    getDetails();
    saveToRecent();
    // getCmdDetails();
    HeaderList();
    // getDetails2(data1?[index]["Topic"].toString());
    super.initState();
    _pageController = PageController();
    _controller = TabController(length: 2, vsync: this);
    _controller?.addListener(_handleTabSelection);
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
      debugPrint(
          'printing header List, ${headerList[6].headerName}, ${headerList[7].headerName}');
    } else {
      debugPrint('get call error');
    }
  }

  void _handleTabSelection() {
    setState(() {
      selected = -1;
    });
  }

  Future getDetails() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listcategory'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];
      // selectedValue1==null;
      // debugPrint("null:: ${selectedValue1}");
      // debugPrint("null:123: ${selectedValue}");

      setState(() {
        branchDropdown = jsonData
                .map<BranchDropdownModel>(
                    (data) => BranchDropdownModel.fromJson(data))
                .toList() ??
            [];
      });
      getData(0);
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json Model, $BranchDropdownModel');
    } else {
      debugPrint('getDetails get call error');
    }
    //debugPrint("Fresher2Industry123 : $branchDropdown");
    // debugPrint("Service Details : $serviceDetails");
  }

  Future getDetails1(val) async {
    debugPrint("printing Seelcted Value : $selectedValue");
    final response =
        await http.get(Uri.parse('${Config.baseURL}listsoftwares/$val'));
    // selectedValue1 == null;
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["listsoftwares"];
      setState(() {
        selectSoftwareDropdown = jsonData
                .map<SelectSoftwareDropdownModel>(
                    (data) => SelectSoftwareDropdownModel.fromJson(data))
                .toList() ??
            [];
        // selectedValue1 == null;
        // selectedValue1 == null;
      });
      getData(0);
      debugPrint('GetCall Success');
      debugPrint('printing json data, where selected value, $jsonData');
      debugPrint('printing json Model, $SelectSoftwareDropdownModel');
    } else {
      debugPrint('getDetails1 get call error');
    }
  }

  Future getCmdDetails() async {
    final response = await http.get(Uri.parse('${Config.baseURL}listcategory'));
    // final serviceResponse = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)["categories"];
      // selectedValue1==null;
      // debugPrint("null:: ${selectedValue1}");
      // debugPrint("null:123: ${selectedValue}");

      setState(() {
        commandsBranchDropdown = jsonData
                .map<BranchDropdownModel>(
                    (data) => BranchDropdownModel.fromJson(data))
                .toList() ??
            [];
      });
      debugPrint('GetCall Success');
      debugPrint('printing json data, $jsonData');
      debugPrint('printing json Model, $BranchDropdownModel');
    } else {
      debugPrint('getCmdDetails get call error');
    }
    //debugPrint("Fresher2Industry123 : $branchDropdown");
    // debugPrint("Service Details : $serviceDetails");
  }

  final _headerStyle = const TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

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

  // Future getCmdDetails1() async{
  //   debugPrint('COming to Get cmd Details pg with ${alpha}');
  //
  //   final response = await http.get(Uri.parse('${Config.baseURL}showcommandsearch/1/1/${alpha}'));
  //   if(response.statusCode == 200){
  //     debugPrint('COming to Get cmd Details Success with ${alpha}');
  //     // selected = -1;
  //     var jsonData = jsonDecode(response.body)["listcommands"];
  //     setState(() {
  //       // commandList = jsonData;
  //       commandsList1 = jsonData.map<CommandsListModel>((data) =>CommandsListModel.fromJson(data)).toList() ?? [];
  //       alpha = '';
  //     });
  //     // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
  //     // debugPrint('printing jsondata of commands, $jsonData');
  //     debugPrint('printing jsondata of commands, ${commandsList1[0].swCode}');
  //     // debugPrint('printing commandListttt of commands, ${jsonDecode(commandsList1)}');
  //     // debugPrint('printing commandListttt of commands, ${commandsList1?[0]["codeDescription"]}');
  //     // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
  //   }else{
  //     debugPrint('getCmdDetails2 get call error');
  //   }
  //
  // }

  Future getDetails3(val) async {
    debugPrint("1234321-----${val}");
    selectedValue1 == null;
    if (val == null) {
      return val = 1;
    }
    debugPrint("printing Seelcted Value1 : $selectedValue1");
    softwareList.clear();
    final response =
        await http.get(Uri.parse('${Config.baseURL}showswdetails/$val'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body)["getrecord"];
      CommandsListModel software = CommandsListModel.fromJson(jsonData);
      setState(() {
        softwareList.add(software);
        //
      });
    } else {
      debugPrint('get call error');
    }
  }

  final Map<String, List<CommandsListModel>> Aalist = {};

  Future getData(from) async {
    String jsonString =
        await rootBundle.loadString('assets/files/Software_in_use.json');
    debugPrint("Checking json : $jsonString");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    debugPrint("Checking map : $jsonMap");
    setState(() {
      data1 = jsonMap["data"];
      head = jsonMap['main'];
      sub = jsonMap["sub"];
      imagee = jsonMap["Immage"];
      logo = jsonMap["logoo"];
      pages = jsonMap["paages"];
      dataa = jsonMap["abt"];
    });
    debugPrint("printing Values ->> $data1");
  }

  getPageData(from) {
    var count = 7 + from;
    for (var i = from; i < count; i++) {
      if (i < 7) {
        debugPrint('came i<7!!!');
        return Accordion(
          maxOpenSections: 1,
          headerBackgroundColorOpened: Colors.white,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: false,
              rightIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.black),
              headerBackgroundColor: Colors.white,
              headerBackgroundColorOpened: Colors.white,
              header: Text('A', style: _headerStyle),
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
                                padding: const EdgeInsets.only(
                                    left: 12, right: 8, top: 8, bottom: 8),
                                child: Container(
                                  width: 10.w,
                                  child: Text(
                                      commandsList1[indexes].swCode.toString()),
                                )),
                            // SizedBox(width: 3.w,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 60.w,
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: commandsList1[indexes]
                                            .codeDescription ??
                                        '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ])),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }),
              // content: Text(_loremIpsum, style: _contentStyle),
              contentHorizontalPadding: 20,
              contentBorderWidth: 1,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
          ],
        );
      } else if (i > 7) {
        debugPrint('came i>7!!!');
        Accordion(
          maxOpenSections: 1,
          headerBackgroundColorOpened: Colors.white,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: false,
              rightIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.black),
              headerBackgroundColor: Colors.white,
              headerBackgroundColorOpened: Colors.white,
              header: Text('I', style: _headerStyle),
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
                                padding: const EdgeInsets.only(
                                    left: 12, right: 8, top: 8, bottom: 8),
                                child: Container(
                                  width: 10.w,
                                  child: Text(
                                      commandsList1[indexes].swCode.toString()),
                                )),
                            // SizedBox(width: 3.w,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 60.w,
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: commandsList1[indexes]
                                            .codeDescription ??
                                        '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ])),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }),
              // content: Text(_loremIpsum, style: _contentStyle),
              contentHorizontalPadding: 20,
              contentBorderWidth: 1,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
          ],
        );
      } else {
        return print("Hello");
      }
    }
  }

  Future getCmdDetails1(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/A'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList1 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails2(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/B'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList2 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList2}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails3(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/C'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList3 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails4(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/D'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList4 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails5(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/E'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList5 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails6(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/F'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList6 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails7(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/G'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList7 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails8(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/H'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList8 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails9(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/I'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList9 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands9, ${commandsList9}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails10(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/J'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList10 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList2}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails11(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/K'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList11 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails12(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/L'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList12 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails13(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/M'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList13 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails14(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/N'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList14 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails15(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/O'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList15 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails16(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/P'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList16 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails17(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/Q'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList17 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails18(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/R'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList18 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails19(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/S'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList19 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails20(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/T'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList20 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails21(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/U'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList21 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails22(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/V'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList22 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList2}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails23(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/W'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList23 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails24(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/X'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList24 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails25(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/Y'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList25 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  Future getCmdDetails26(val, value1) async {
    final response = await http.get(Uri.parse(
        '${Config.baseURL}showcommandsearch/${selectedValue}/${selectedValue1}/Z'));
    if (response.statusCode == 200) {
      // selected = -1;
      var jsonData = jsonDecode(response.body)["listcommands"];
      setState(() {
        // commandList = jsonData;
        commandsList26 = jsonData
                .map<CommandsListModel>(
                    (data) => CommandsListModel.fromJson(data))
                .toList() ??
            [];
      });
      // commandList.sort((a,b){return a.swCode.toString().compareTo(b.swCode.toString());});
      debugPrint('printing jsondata of commands, $jsonData');
      debugPrint('printing commandListttt of commands, ${commandsList1}');
      // debugPrint('printing commands + ${commandList[0].swCode.toString().substring(0,1)}');
    } else {
      debugPrint('getCmdDetails2 get call error');
    }
  }

  pageList(page) {
    switch (page) {
      case 1:
        getPageData(0);
        break;
      case 2:
        getPageData(7);
        break;
      case 3:
        getPageData(14);
        break;
      case 4:
        getPageData(21);
        break;
      case 5:
        getPageData(28);
        break;
      default:
        getPageData(35);
    }
  }

  numOfPages() {
    double num = 26 / 7;
    return num.ceil();
  }

  pagination() {
    return PaginationWidget(
      numOfPages: numOfPages(),
      selectedPage: selectedPage,
      pagesVisible: 3,
      spacing: 0,
      onPageChanged: (page) {
        pageList(page);
        setState(() {
          selectedPage = page;
        });
      },
      nextIcon: Icon(
        Icons.arrow_forward_ios,
        size: 12,
        color: selectedPage == numOfPages()
            ? Colors.grey
            : const Color(0xff000000),
      ),
      previousIcon: Icon(
        Icons.arrow_back_ios,
        size: 12,
        color: selectedPage == 1 ? Colors.grey : const Color(0xff000000),
      ),
      activeTextStyle: const TextStyle(
        color: Color(0xffffffff),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      activeBtnStyle: ButtonStyle(
        visualDensity: const VisualDensity(horizontal: -4),
        backgroundColor: MaterialStateProperty.all(const Color(0xff8cb93d)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: Color(0xfff1f1f1),
              width: 2,
            ),
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
        shadowColor: MaterialStateProperty.all(
          const Color(0xfff1f1f1),
        ),
      ),
      inactiveBtnStyle: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        visualDensity: const VisualDensity(horizontal: 0),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          const Color(0xfff9f9fb),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.h),
          child: const App_Bar_widget(title: 'Software in Use and \nCommands'),
        ),
        backgroundColor: Config.whiteColor,
        body: SafeArea(
          child: ListView(
            children: [
              // _controller?.index == 0 ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Branch dropdown Container
                  Padding(
                    padding:
                        EdgeInsets.only(top: 2.2.h, left: 4.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: 50.w,
                          child: Text(
                            'Engineering Branch*',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                              color: const Color(0XFF1F1F39),
                            ),
                          ),
                        ),
                        (branchDropdown == null ||
                                branchDropdown == '' ||
                                branchDropdown.length == 0)
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
                                      radius: 10,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )
                            : DropdownButton2(
                                dropdownElevation: 5,
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                selectedItemHighlightColor: Colors.lightGreen,
                                underline: Container(),
                                items: branchDropdown
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item.id,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              "${item.cname}" ?? "",
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
                                    selectedValue1 = null;
                                    selectedValue = value as String;
                                    selectSoftwareDropdown = [];
                                    softwareList = [];
                                  });
                                  // selectedValue1 == null;
                                  getDetails1(selectedValue);
                                },
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                iconSize: 30,
                                iconEnabledColor: Colors.black,
                                buttonHeight: 3.9.h,
                                buttonWidth: 40.w,
                                buttonPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: const Color(0XFFF1F1F1)),
                                  color: Colors.white,
                                ),
                                buttonElevation: 0,
                                itemHeight: 30,
                                itemPadding: const EdgeInsets.only(
                                    left: 1, right: 1, top: 0, bottom: 0),
                                dropdownWidth: 40.w,
                                dropdownMaxHeight: 100.h,
                                dropdownPadding: null,
                                //EdgeInsets.all(1),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                  color: Colors.grey.shade100,
                                ),
                                offset: const Offset(0, 0),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  // Select Software dropdown container
                  Padding(
                    padding:
                        EdgeInsets.only(top: 2.2.h, left: 4.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: 50.w,
                          child: Text(
                            'Select Software*',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                              color: const Color(0XFF1F1F39),
                            ),
                          ),
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
                          items: selectSoftwareDropdown.isNotEmpty
                              ? selectSoftwareDropdown
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.postId,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            item.postTitle ?? "",
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
                                  .toList()
                              : [],
                          value: selectedValue1,
                          onChanged: (value1) {
                            setState(() {
                              selectedValue1 = value1.toString();
                            });
                            getDetails3(selectedValue1);
                            getCmdDetails1(selectedValue, selectedValue1);
                            getCmdDetails2(selectedValue, selectedValue1);
                            getCmdDetails3(selectedValue, selectedValue1);
                            getCmdDetails4(selectedValue, selectedValue1);
                            getCmdDetails5(selectedValue, selectedValue1);
                            getCmdDetails6(selectedValue, selectedValue1);
                            getCmdDetails7(selectedValue, selectedValue1);
                            getCmdDetails8(selectedValue, selectedValue1);
                            getCmdDetails9(selectedValue, selectedValue1);
                            getCmdDetails10(selectedValue, selectedValue1);
                            getCmdDetails11(selectedValue, selectedValue1);
                            getCmdDetails12(selectedValue, selectedValue1);
                            getCmdDetails13(selectedValue, selectedValue1);
                            getCmdDetails14(selectedValue, selectedValue1);
                            getCmdDetails15(selectedValue, selectedValue1);
                            getCmdDetails16(selectedValue, selectedValue1);
                            getCmdDetails17(selectedValue, selectedValue1);
                            getCmdDetails18(selectedValue, selectedValue1);
                            getCmdDetails19(selectedValue, selectedValue1);
                            getCmdDetails20(selectedValue, selectedValue1);
                            getCmdDetails21(selectedValue, selectedValue1);
                            getCmdDetails22(selectedValue, selectedValue1);
                            getCmdDetails23(selectedValue, selectedValue1);
                            getCmdDetails24(selectedValue, selectedValue1);
                            getCmdDetails25(selectedValue, selectedValue1);
                            getCmdDetails26(selectedValue, selectedValue1);
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          iconSize: 30,
                          iconEnabledColor: Colors.black,
                          buttonHeight: 3.9.h,
                          buttonWidth: 40.w,
                          buttonPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: const Color(0XFFF1F1F1)),
                            color: Colors.white,
                          ),
                          buttonElevation: 0,
                          itemHeight: 30,
                          itemPadding: const EdgeInsets.only(
                              left: 1, right: 1, top: 0, bottom: 0),
                          dropdownWidth: 40.w,
                          dropdownMaxHeight: 100.h,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                            color: Colors.grey.shade100,
                          ),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  // Divider
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w),
                    child: const Divider(
                      thickness: 1,
                      color: Config.mainBorderColor,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                ],
              ),
              DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                          indicatorPadding:
                              const EdgeInsets.only(left: 0.5, right: 0.5),
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
                              height: 3.9.h,
                              width: 45.86.w,
                              //margin: EdgeInsets.only(left: 30, right: 30),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  color: _controller?.index == 0
                                      ? Config.containerGreenColor
                                      : Config.mainBorderColor),
                              child: Tab(
                                key: UniqueKey(),
                                child: headerList.isEmpty
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
                                              radius: 10,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(
                                        headerList[6].headerName ?? '',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                        ),
                                      ),
                              ),
                            ),
                            Container(
                              height: 3.9.h,
                              width: 45.86.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8)),
                                  color: _controller?.index == 1
                                      ? Config.containerGreenColor
                                      : Config.mainBorderColor),
                              child: Tab(
                                // key: UniqueKey(),
                                child: headerList.isEmpty
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
                                              radius: 10,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(
                                        headerList[7].headerName ?? '',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          //color: _controller.index == 1 ? Config
                                        ),
                                      ),
                              ),
                            ),
                          ]),
                    ),
                    //const Divider(thickness: 6, color: Config.containerGreenColor,),
                    Container(
                      margin: EdgeInsets.only(left: 4.w, right: 4.w),
                      height: 0.5.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                        color: Config.containerGreenColor,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _controller,
                        // children: <Widget>[
                        //   aboutSoftware(context),
                        //   listOfCommands(context),
                        // ],
                        children: [
                          Container(
                              child: (softwareList.isEmpty
                                  ? Center(
                                      child: Container(
                                        width: 80.w,
                                        height: 50.h,
                                        child: Center(
                                          child: Text(
                                            'Please select Branch and Software to get SOFTWARE DATA',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade200),
                                          ),
                                        ),
                                      ),
                                    )
                                  : (selectSoftwareDropdown.length == 0)
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
                                                  color:
                                                      Config.primaryTextColor,
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
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemCount: softwareList.length,
                                          itemBuilder: (context, index) {
                                            return softwareList.length == 0
                                                ? const CircularProgressIndicator()
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.all(4.w),
                                                    child: Column(
                                                      children: [
                                                        //Software
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 24.w,
                                                              child: Text(
                                                                'Software:',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11.sp),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 10.w),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: Text(
                                                                  softwareList[
                                                                              0]
                                                                          .postTitle ??
                                                                      ''),
                                                            ),
                                                          ],
                                                        ),
                                                        //Released by
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 24.w,
                                                              child: Text(
                                                                'Released by:',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11.sp),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                    text: softwareList[index]
                                                                            .releasedBy ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //Licenses
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 24.w,
                                                              child: Text(
                                                                'Licenses available (Free/Paid) :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11.sp),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                    text: softwareList[index]
                                                                            .releasedBy ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //Year of release
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 24.w,
                                                              child: Text(
                                                                'Year of Release:',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11.sp),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                    text: softwareList[index]
                                                                            .releaseYear ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //software use
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 24.w,
                                                              child: Text(
                                                                'Software Use:',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11.sp),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: Text(
                                                                  softwareList[
                                                                              index]
                                                                          .softwareUse ??
                                                                      '',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                        //Description
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 24.w,
                                                              child: Text(
                                                                'Description:',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11.sp),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: Container(
                                                                width: 50.w,
                                                                child: Text(
                                                                    softwareList[index]
                                                                            .postContent ??
                                                                        '',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 5,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //Link
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 24.w,
                                                              child: Text(
                                                                'Visit:',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11.sp),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  String? url = softwareList[
                                                                          index]
                                                                      .downloadLink
                                                                      .toString();

                                                                  void _launchURL(
                                                                      
                                                                          url) async {
                                                                    if (await canLaunch(
                                                                        url)) {
                                                                      await launch(
                                                                          url);
                                                                    } else {
                                                                      throw 'Could not launch $url';
                                                                    }
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 50.w,
                                                                  child:
                                                                      RichText(
                                                                    text: TextSpan(
                                                                        text: softwareList[index].downloadLink ??
                                                                            '',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.blueAccent,
                                                                            decoration: TextDecoration.underline)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                          },
                                        ))),
                          Accordion(
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
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('A', style: _headerStyle),
                                content: (commandsList1.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList1.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return (commandsList1.length == 0)
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList1[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList1[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //2
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('B', style: _headerStyle),
                                content: (commandsList2.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList2.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList2.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList2[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList2[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //3
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('C', style: _headerStyle),
                                content: (commandsList3.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList3.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList3.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList3[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList3[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //4
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('D', style: _headerStyle),
                                content: (commandsList4.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList4.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return Column(
                                            children: [
                                              // const Divider(thickness: 1, color: Config.mainBorderColor),
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12,
                                                              right: 8,
                                                              top: 8,
                                                              bottom: 8),
                                                      child: Container(
                                                        width: 10.w,
                                                        child: Text(
                                                            commandsList4[
                                                                    indexes]
                                                                .swCode
                                                                .toString()),
                                                      )),
                                                  // SizedBox(width: 3.w,),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: 60.w,
                                                      child: RichText(
                                                          text: TextSpan(
                                                              children: [
                                                            TextSpan(
                                                              text: commandsList4[
                                                                          indexes]
                                                                      .codeDescription ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )
                                                          ])),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //5
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('E', style: _headerStyle),
                                content: (commandsList5.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList5.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList5.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList5[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList5[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                              ),
                              //6
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('F', style: _headerStyle),
                                content: (commandsList6.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList6.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList6.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList6[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList6[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                              ),
                              //7
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('G', style: _headerStyle),
                                content: (commandsList7.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList7.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList7.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList7[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList7[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //8
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('H', style: _headerStyle),
                                content: (commandsList8.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList8.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList8.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList8[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList8[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                              ),
                              //9
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
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
                                content: (commandsList9.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList9.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList9.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList9[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList9[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //10
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('J', style: _headerStyle),
                                content: (commandsList10.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList10.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList10.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList10[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList10[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //11
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('K', style: _headerStyle),
                                content: (commandsList11.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList11.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList11.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList11[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList11[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //12
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('L', style: _headerStyle),
                                content: (commandsList12.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList12.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList12.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              : Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList12[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList12[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //13
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('M', style: _headerStyle),
                                content: (commandsList13.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList13.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList13.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList13[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList13[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //14
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('N', style: _headerStyle),
                                content: (commandsList14.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList14.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList14.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList14[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList14[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //15
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('O', style: _headerStyle),
                                content: (commandsList15.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList15.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList15.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList15[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList15[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //16
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('P', style: _headerStyle),
                                content: (commandsList16.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList16.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList16.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList16[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList16[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                              ),
                              //17
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('Q', style: _headerStyle),
                                content: (commandsList17.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList17.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList17.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList17[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList17[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //18
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('R', style: _headerStyle),
                                content: (commandsList18.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList18.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList18.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList18[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList18[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //19
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('S', style: _headerStyle),
                                content: (commandsList19.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList19.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList19.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList19[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList19[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //20
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('T', style: _headerStyle),
                                content: (commandsList20.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList20.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList20.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              : Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList20[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList20[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //21
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('U', style: _headerStyle),
                                content: (commandsList21.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList21.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList21.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList21[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList21[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //22
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('V', style: _headerStyle),
                                content: (commandsList22.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList22.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList22.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList22[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList22[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //23
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('W', style: _headerStyle),
                                content: (commandsList23.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList23.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList23.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList23[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList23[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //24
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('X', style: _headerStyle),
                                content: (commandsList24.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList24.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList24.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList24[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList24[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //25
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('Y', style: _headerStyle),
                                content: (commandsList25.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList25.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList25.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList25[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList25[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                              //26
                              AccordionSection(
                                contentBorderColor: Colors.transparent,
                                contentBackgroundColor: Colors.grey.shade200,
                                isOpen: false,
                                rightIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black),
                                headerBackgroundColor: Colors.grey.shade100,
                                headerBackgroundColorOpened:
                                    Colors.grey.shade200,
                                header: Text('Z', style: _headerStyle),
                                content: (commandsList26.length == 0)
                                    ? Container(
                                        child: Text(
                                          'NO DATA TO DISPLAY',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: commandsList26.length ?? 0,
                                        itemBuilder: (context, indexes) {
                                          return commandsList26.isEmpty
                                              ? Text(
                                                  '\n\nNO DATA TO DISPLAY',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black),
                                                )
                                              :
                                              // commandList.length==0 ? CircularProgressIndicator() :
                                              Column(
                                                  children: [
                                                    // const Divider(thickness: 1, color: Config.mainBorderColor),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 8,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Container(
                                                              width: 10.w,
                                                              child: Text(
                                                                  commandsList26[
                                                                          indexes]
                                                                      .swCode
                                                                      .toString()),
                                                            )),
                                                        // SizedBox(width: 3.w,),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 60.w,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: commandsList26[indexes]
                                                                            .codeDescription ??
                                                                        '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ])),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                        }),
                                // content: Text(_loremIpsum, style: _contentStyle),
                                contentHorizontalPadding: 20,
                                contentBorderWidth: 1,
                                // onOpenSection: () => print('onOpenSection ...'),
                                // onCloseSection: () => print('onCloseSection ...'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //   child: _controller?.index == 0 ? null : null,
        //   // pagination(),
        // ),
      ),
    );
  }

  aboutSoftware(context) {
    return (softwareList.isEmpty)
        ? Center(
            child: Container(
              width: 80.w,
              child: Text(
                'Please select Branch and Software to get SOFTWARE DATA',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade200),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: softwareList.length,
            itemBuilder: (context, index) {
              return softwareList.length == 0
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        children: [
                          //Software
                          Row(
                            children: [
                              Container(
                                width: 24.w,
                                child: Text(
                                  'Software:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(softwareList[0].postTitle ?? ''),
                              ),
                            ],
                          ),
                          //Released by
                          Row(
                            children: [
                              Container(
                                width: 24.w,
                                child: Text(
                                  'Released by:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: RichText(
                                  text: TextSpan(
                                      text:
                                          softwareList[index].releasedBy ?? '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp)),
                                ),
                              ),
                            ],
                          ),
                          //Licenses
                          Row(
                            children: [
                              Container(
                                width: 24.w,
                                child: Text(
                                  'Licenses available (Free/Paid) :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: RichText(
                                  text: TextSpan(
                                      text:
                                          softwareList[index].releasedBy ?? '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp)),
                                ),
                              ),
                            ],
                          ),
                          //Year of release
                          Row(
                            children: [
                              Container(
                                width: 24.w,
                                child: Text(
                                  'Year of Release:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: RichText(
                                  text: TextSpan(
                                      text:
                                          softwareList[index].releaseYear ?? '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp)),
                                ),
                              ),
                            ],
                          ),
                          //software use
                          Row(
                            children: [
                              Container(
                                width: 24.w,
                                child: Text(
                                  'Software Use:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                    softwareList[index].softwareUse ?? '',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10.sp)),
                              ),
                            ],
                          ),
                          //Description
                          Row(
                            children: [
                              Container(
                                width: 24.w,
                                child: Text(
                                  'Description:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  width: 50.w,
                                  child: Text(
                                      softwareList[index].postContent ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp)),
                                ),
                              ),
                            ],
                          ),
                          //Link
                          Row(
                            children: [
                              Container(
                                width: 24.w,
                                child: Text(
                                  'Visit:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: InkWell(
                                  onTap: () {
                                    launch(softwareList[index]
                                        .downloadLink
                                        .toString());
                                  },
                                  child: Container(
                                    width: 50.w,
                                    child: RichText(
                                      text: TextSpan(
                                          text: softwareList[index]
                                                  .downloadLink ??
                                              '',
                                          style: const TextStyle(
                                              color: Colors.blueAccent,
                                              decoration:
                                                  TextDecoration.underline)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
            },
          );
  }

  listOfCommands(context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: data1?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              width: 91.73.w,
              // height: 7.h,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Config.mainBorderColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: pageList(selectedPage)),
            ),
          ],
        );
      },
    );
  }
// listOfCommands(context){
//
//     return  ListView.builder(
//       shrinkWrap: true,
//       physics: const ScrollPhysics(),
//       itemCount: data1?.length ?? 0,
//       itemBuilder: (context, index) {
//         return
//           Column(
//           children: [
//             Container(
//               width: 91.73.w,
//               // height: 7.h,
//               margin: const EdgeInsets.all(5),
//               padding: const EdgeInsets.all(1),
//               decoration: BoxDecoration(
//                 border: Border.all(width: 1,color: Config.mainBorderColor),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Theme(
//                 data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//                 child: ExpansionTile(
//                   key: Key(index.toString()),
//                     backgroundColor: Config.containerColor,
//                     collapsedBackgroundColor: Config.whiteColor,
//                   initiallyExpanded : index == selected,
//                   onExpansionChanged: (bool expanding) => _expansion(expanding, index),
//                   iconColor: Colors.black,
//                     title: Text(data1?[index]["Topic"] ?? '',
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Config.primaryTextColor
//                       ),
//                     ),
//                   // onExpansionChanged: ((newState) {
//                   //   if (newState)
//                   //     setState(() {
//                   //       Duration(seconds: 20000);
//                   //       selected = index;
//                   //     });
//                   //   else
//                   //     setState(() {
//                   //       selected = -1;
//                   //     });
//                   //   setState(() {
//                   //       tileExpanded = selected as bool;
//                   //       getDetails2(data1?[index]["Topic"].toString());
//                   //       commandList.clear();
//                   //     });
//                   // }),
//                     // onExpansionChanged: (newState) {
//                     //   if (newState) {
//                     //     setState(() {
//                     //       selectedTile = index;
//                     //       getDetails2(data1?[index]["Topic"].toString());
//                     //         commandList.clear();
//                     //     });
//                     //   }
//                     //   else {
//                     //     setState(() {
//                     //       selectedTile = -1;
//                     //       getDetails2(data1?[index]["Topic"].toString());
//                     //         commandList.clear();
//                     //     });
//                     //   }
//                     //
//                     //   // setState(() {
//                     //   //   // tileExpanded != expanded;
//                     //   //   getDetails2(data1?[index]["Topic"].toString());
//                     //   //   commandList.clear();
//                     //   // });
//                     // },
//
//                     children: [commandsList.length==0 ?
//                     const Text('No data to show') :
//                     ListView.builder(
//                           shrinkWrap: true,
//                           physics: const ScrollPhysics(),
//                           itemCount: commandsList.length ?? 0,
//                           itemBuilder: (context, indexes) {
//                             return
//                               // commandList.length==0 ? CircularProgressIndicator() :
//                               Column(
//                               children: [
//                                 // const Divider(thickness: 1, color: Config.mainBorderColor),
//                                 Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
//                                       child: Container(
//                                         width: 10.w,
//                                           child: Text(commandsList[indexes].swCode.toString()),
//                                       )
//                                     ),
//                                     // SizedBox(width: 3.w,),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         width: 70.w,
//                                         child: RichText(text: TextSpan(children: [
//                                           TextSpan(
//                                             text: commandsList[indexes].codeDescription ?? '',
//                                             style: const TextStyle(
//                                               color: Colors.black,
//                                             ),
//                                           )
//                                         ]
//                                         )
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             );
//                           }
//                       ),
//                     // ListView.builder(
//                     //       shrinkWrap: true,
//                     //       physics: const ScrollPhysics(),
//                     //       itemCount: commandsList.length ?? 0,
//                     //       itemBuilder: (context, indexes) {
//                     //         return
//                     //
//                     //           // commandList.length==0 ? CircularProgressIndicator() :
//                     //           Column(
//                     //           children: [
//                     //             // const Divider(thickness: 1, color: Config.mainBorderColor),
//                     //             Row(
//                     //               children: [
//                     //                 Padding(
//                     //                   padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
//                     //                   child: Container(
//                     //                     width: 10.w,
//                     //                       child: Text(commandsList[index].swCode.toString()),
//                     //                   )
//                     //                 ),
//                     //                 // SizedBox(width: 3.w,),
//                     //                 Padding(
//                     //                   padding: const EdgeInsets.all(8.0),
//                     //                   child: Container(
//                     //                     width: 70.w,
//                     //                     child: RichText(text: TextSpan(children: [
//                     //                       TextSpan(
//                     //                         text: commandsList[index].codeDescription ?? '',
//                     //                         style: const TextStyle(
//                     //                           color: Colors.black,
//                     //                         ),
//                     //                       )
//                     //                     ]
//                     //                     )
//                     //                     ),
//                     //                   ),
//                     //                 )
//                     //               ],
//                     //             ),
//                     //           ],
//                     //         );
//                     //       }
//                     //   ),
//                     ],
//                   ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
// }

  // Widget _buildPanel() {
  //   return ExpansionPanelList(
  //     expansionCallback: (int index, bool isExpanded) {
  //       setState(() {
  //         for(int i = 0; i<commandList.length; i++){
  //           commandList[i].isExpanded = false;
  //         }
  //
  //         commandList[index].isExpanded = !isExpanded;
  //       });
  //     },
  //     children: commandList.map<ExpansionPanel>((CommandsListModel) {
  //       return ExpansionPanel(
  //         canTapOnHeader: true,
  //         headerBuilder: (BuildContext context, bool isExpanded) {
  //           return ListTile(
  //             title: Text(CommandsListModel[0]),
  //           );
  //         },
  //         body: ListTile(
  //             title: Text(CommandsListModel[0]),
  //             subtitle:
  //             const Text('To delete this panel, tap the trash can icon'),
  //             trailing: const Icon(Icons.delete),
  //             onTap: () {
  //               setState(() {
  //                 commandList.removeWhere((CommandsListModel currentItem) => CommandsListModel() == currentItem);
  //               });
  //             }),
  //         isExpanded: commandList.isExpanded,
  //       );
  //     }).toList(),
  //   );
  // }

}

// stores ExpansionPanel state information
// class Item {
//   Item({
//     required this.expandedValue,
//     required this.headerValue,
//     this.isExpanded = false,
//   });
//
//   String expandedValue;
//   String headerValue;
//   bool isExpanded;
// }
//
// List<Item> generateItems(int numberOfItems) {
//   return List<Item>.generate(numberOfItems, (int index) {
//     return Item(
//       headerValue: 'Panel $index',
//       expandedValue: 'This is item number $index',
//     );
//   });
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   final List<Item> _data = generateItems(8);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         child: _buildPanel(),
//       ),
//     );
//   }
//
//   Widget _buildPanel() {
//     return ExpansionPanelList(
//       expansionCallback: (int index, bool isExpanded) {
//         setState(() {
//           for(int i = 0; i<_data.length; i++){
//             _data[i].isExpanded = false;
//           }
//
//           _data[index].isExpanded = !isExpanded;
//         });
//       },
//       children: _data.map<ExpansionPanel>((Item item) {
//         return ExpansionPanel(
//           canTapOnHeader: true,
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return ListTile(
//               title: Text(item.headerValue),
//             );
//           },
//           body: ListTile(
//               title: Text(item.expandedValue),
//               subtitle:
//               const Text('To delete this panel, tap the trash can icon'),
//               trailing: const Icon(Icons.delete),
//               onTap: () {
//                 setState(() {
//                   _data.removeWhere((Item currentItem) => item == currentItem);
//                 });
//               }),
//           isExpanded: item.isExpanded,
//         );
//       }).toList(),
//     );
//   }
// }
