// import 'dart:convert';
// import 'package:careercoach/Learn%20Assist/Guest%20Lectures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import 'Config.dart';
// import 'Widgets/App_Bar_Widget.dart';
// class UnitConverter extends StatefulWidget {
//   @override
//   _UnitConverterState createState() => _UnitConverterState();
// }
//
// class _UnitConverterState extends State<UnitConverter> {
//
//   final TextStyle labelStyle = TextStyle(
//       fontSize: 16.0,color: Colors.black
//   );
//   final TextStyle resultSyle = TextStyle(
//     color: Colors.black,
//     fontSize: 25.0,
//     fontWeight: FontWeight.w700,
//   );
//
//   final List<String> _mesaures = [
//     'Meters',
//     'Kilometers',
//     'Grams',
//     'Kilograms',
//     'Feet',
//     'Miles',
//     'Pounds',
//     'Ounces'
//   ];
//
//   late double _value;
//   String _fromMesaures = 'Meters';
//   String _toMesaures = 'Kilometers';
//   String _results = "";
//
//   final Map<String, int> _mesauresMap = {
//     'Meters': 0,
//     'Kilometers': 1,
//     'Grams': 2,
//     'Kilograms': 3,
//     'Feet': 4,
//     'Miles': 5,
//     'Pounds': 6,
//     'Ounces': 7,
//   };
//
//   dynamic _formulas = {
//     '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
//     '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
//     '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
//     '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
//     '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
//     '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
//     '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
//     '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0XFF8CB93D),
//           title: Text('Unit Converter',
//             style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(15.0),
//             child: Column(
//               children: [
//                 TextField(
//                   decoration: const InputDecoration(
//                     labelText: 'Enter the Value',
//                     counterText: '',
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Color(0XFF8CB93D)),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Color(0XFF8CB93D)),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       _value = double.parse(value);
//                     });
//                   },
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(height: 25.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'From',
//                           style: labelStyle,
//                         ),
//                         DropdownButton(
//                           items: _mesaures
//                               .map((String value) => DropdownMenuItem<String>(
//                             child: Text(value),
//                             value: value,
//                           ))
//                               .toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               _fromMesaures = value!;
//                             });
//                           },
//                           value: _fromMesaures,
//                         )
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('To', style: labelStyle),
//                         DropdownButton(
//                           items: _mesaures
//                               .map((String value) => DropdownMenuItem<String>(
//                             child: Text(value),
//                             value: value,
//                           ))
//                               .toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               _toMesaures = value!;
//                             });
//                           },
//                           value: _toMesaures,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 MaterialButton(
//                   minWidth: double.infinity,
//                   onPressed: _convert,
//                   child: Text(
//                     'Convert',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   color: Color(0XFF8CB93D),
//                 ),
//                 SizedBox(height: 25.0),
//                 Text(
//                   _results,
//                   style: resultSyle,
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _convert() {
//     print('Button Clicked');
//     print(_value);
//
//     if (_value != 0 && _fromMesaures.isNotEmpty && _toMesaures.isNotEmpty) {
//       int? from = _mesauresMap[_fromMesaures];
//       int? to = _mesauresMap[_toMesaures];
//
//       var multiplier = _formulas[from.toString()][to];
//
//       setState(() {
//         _results =
//         "$_value $_fromMesaures = ${_value * multiplier} $_toMesaures";
//       });
//     } else {
//       setState(() {
//         _results = "Please enter a non zero value";
//       });
//     }
//   }
// }

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Config.dart';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  final TextEditingController inputController = TextEditingController();

  double? userInput;
  String? _startMeasures;
  String? _convertMeasures;
  String? _convertMeasures1;
  String? _convertMeasures2;
  String? resultMessage;

  final Map<String, List<String>> relatedUnits = {
    'Grams': ['Kilograms(kg)', 'Pounds(lbs)', 'Ounces'],
    'Kilograms(kg)': ['Grams', 'Pounds(lbs)', 'Ounces'],
    'Pounds(lbs)': ['Grams', 'Kilograms(kg)', 'Ounces'],
    'Ounces': ['Grams', 'Kilograms(kg)', 'Pounds(lbs'],
    'Feet': ['Meters', 'Kilometers', 'Miles'],
    'Meters': ['Feet', 'Kilometers', 'Miles'],
    'Kilometers': ['Feet', 'Meters', 'Miles'],
    'Miles': ['Feet', 'Meters', 'Kilometers'],
    'Celsius': ['Fahrenheit', 'Kelvin'],
    'Fahrenheit': ['Celsius', 'Kelvin'],
    'Kelvin': ['Celsius', 'Fahrenheit'],
    // 'Watts': ['Kilowatts', 'Horsepower', 'BTUs per hour'],
    // 'Kilowatts': ['Watts', 'Horsepower', 'BTUs per hour'],
    // 'Horsepower': ['Watts', 'Kilowatts', 'BTUs per hour'],
    // 'BTUs per hour': ['Watts', 'Kilowatts', 'Horsepower'],
  };

  StatefulWidget buildToDropdown() {
    TextStyle greenTextStyle = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: Colors.green, // Set the color to green
    );
    if (_startMeasures == null) {
      return DropdownButton2(
        dropdownElevation: 5,
        isExpanded: true,
        hint: Text(
          ' Choose a Unit ',
          style: TextStyle(
            fontSize: Config.font_size_12.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        selectedItemHighlightColor: Colors.lightGreen,
        underline: Container(),
        items: measures.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: EdgeInsets.only(left: 1.w),
              child: Text(
                "${value}" ?? "",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: Config.font_size_12.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }).toList(),
        value: _convertMeasures,
        onChanged: (value) {
          setState(() {
            _convertMeasures = value;
            resultMessage = '';
          });
        },
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        iconSize: 30,
        iconEnabledColor: Colors.black,
        buttonHeight: 4.h,
        buttonWidth: 40.w,
        buttonPadding: const EdgeInsets.only(left: 10, right: 10),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Config.mainBorderColor),
          color: Colors.white,
        ),
        buttonElevation: 0,
        itemHeight: 30,
        itemPadding:
            const EdgeInsets.only(left: 1, right: 1, top: 0, bottom: 0),
        dropdownWidth: 68.5.w,
        dropdownMaxHeight: 100.h,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.grey.shade100,
        ),
        offset: const Offset(0, 0),
      );
    } else if (relatedUnits.containsKey(_startMeasures)) {
      return DropdownButton2(
        dropdownElevation: 5,
        isExpanded: true,
        hint: Text(
          ' Choose a Unit ',
          style: TextStyle(
            fontSize: Config.font_size_12.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        selectedItemHighlightColor: Colors.lightGreen,
        underline: Container(),
        items: relatedUnits[_startMeasures]!.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        value: _convertMeasures,
        onChanged: (value) {
          setState(() {
            _convertMeasures = value;
            resultMessage = '';
          });
        },
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        iconSize: 30,
        iconEnabledColor: Colors.black,
        buttonHeight: 4.h,
        buttonWidth: 40.w,
        buttonPadding: const EdgeInsets.only(left: 10, right: 10),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Config.mainBorderColor),
          color: Colors.white,
        ),
        buttonElevation: 0,
        itemHeight: 30,
        itemPadding:
            const EdgeInsets.only(left: 1, right: 1, top: 0, bottom: 0),
        dropdownWidth: 68.5.w,
        dropdownMaxHeight: 100.h,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.grey.shade100,
        ),
        offset: const Offset(0, 0),
      );
    } else {
      return DropdownButton2(
        dropdownElevation: 5,
        isExpanded: true,
        hint: Text(
          ' Choose a Unit ',
          style: TextStyle(
            fontSize: Config.font_size_12.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        selectedItemHighlightColor: Colors.lightGreen,
        underline: Container(),
        items: measures.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        value: _convertMeasures,
        onChanged: (value) {
          setState(() {
            _convertMeasures = value;
            resultMessage = '';
          });
        },
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        iconSize: 30,
        iconEnabledColor: Colors.black,
        buttonHeight: 4.h,
        buttonWidth: 40.w,
        buttonPadding: const EdgeInsets.only(left: 10, right: 10),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Config.mainBorderColor),
          color: Colors.white,
        ),
        buttonElevation: 0,
        itemHeight: 30,
        itemPadding:
            const EdgeInsets.only(left: 1, right: 1, top: 0, bottom: 0),
        dropdownWidth: 68.5.w,
        dropdownMaxHeight: 100.h,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.grey.shade100,
        ),
        offset: const Offset(0, 0),
      );
      // return DropdownButton<String>(
      //   value: _convertMeasures,
      //   isExpanded: true,
      //   dropdownColor: Colors.white,
      //   style: TextStyle(
      //       fontSize: 12.sp, fontWeight: FontWeight.w700, color: Colors.black),
      //   hint: Text(
      //     'Choose a Unit',
      //     style: TextStyle(color: Colors.black54, fontSize: 12.sp),
      //   ),
      //   items: measures.map((value) {
      //     return DropdownMenuItem(value: value, child: Text(value));
      //   }).toList(),
      //   onChanged: (value) {
      //     setState(() {
      //       _convertMeasures = value;
      //       resultMessage = null;
      //     });
      //   },
      // );
    }
  }

  final List<String> measures = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms(kg)',
    'Miles',
    'Feet',
    'Pounds(lbs)',
    'Ounces',
    'Celsius',
    'Fahrenheit',
    'Kelvin',
    // 'Watts',
    // 'Kilowatts',
    // 'Horsepower',
    // 'BTUs per hour',
  ];

  final Map<String, int> measuresmap = {
    'Meters': 0,
    'Kilometers': 1,
    'Grams': 2,
    'Kilograms(kg)': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds(lbs)': 6,
    'Ounces': 7,
    'Celsius': 8,
    'Fahrenheit': 9,
    'Kelvin': 10,
    // 'Watts': 11,
    // 'Kilowatts': 12,
    // 'Horsepower': 13,
    // 'BTUs per hour': 14,
  };

  dynamic formulas = {
    '0': [1, 0.001, 0, 0, 3.280, 0.0006213, 0, 0, 0, 0, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0, 6213, 0, 0, 0, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220, 0.03, 0, 0, 0, 0],
    '3': [0, 0, 1000, 1, 0, 0, 2.2046, 35.274, 0, 0, 0, 0],
    '4': [0.0348, 0.00030, 0, 0, 1, 0.000189, 0, 0, 0, 0, 0, 0],
    '5': [1609.34, 1.60934, 0, 5280, 1, 0, 0, 0, 0, 0, 0, 0],
    '6': [0, 0, 453.592, 0.4535, 0, 0, 1, 16, 0, 0, 0, 0],
    '7': [0, 0, 28.3495, 0.02834, 3.28084, 0, 0.1, 0, 0, 0, 0, 0],
    '8': [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    '9': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    '10': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],

    'Watts-Kilowatts': 0.001,
    'Watts-Horsepower': 0.00134,
    'Watts-BTUs per hour': 3.4121,
    'Kilowatts-Watts': 1000,
    'Kilowatts-Horsepower': 1.3410,
    'Kilowatts-BTUs per hour': 3412.14,
    'Horsepower-Watts': 745.7,
    'Horsepower-Kilowatts': 0.7457,
    'Horsepower-BTUs per hour': 2544.43,
    'BTUs per hour-Watts': 0.2931,
    'BTUs per hour-Kilowatts': 0.0002931,
    'BTUs per hour-Horsepower': 0.0003725,

    // Power
    '11': [1, 0.001, 0.00134, 3.4121],
    '12': [1000, 1, 1.3410, 3412.14],
    '13': [745.7, 0.7457, 1, 2544.43],
    '14': [0.2931, 0.0002931, 0.0003725, 1],
    '11-13': [745.7, 0.7457, 1, 2544.43],
    '11-14': [0.2931, 0.0002931, 0.0003725, 1],
    '12-13': [745.7, 0.7457, 1, 2544.43],
    '12-14': [0.2931, 0.0002931, 0.0003725, 1],
    '13-11': [0.00134, 0.00000134, 1, 3.4121],
    '13-12': [0.00134, 0.00000134, 1, 3.4121],
    '14-11': [3.4121, 0.0034121, 4.0083, 1],
    '14-12': [3412.14, 3.41214, 4008.3, 1],
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Config.careerCoachButtonColor,
          title: Text(
            'Unit Converter',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Container(
                height: 50.h,
                width: 80.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Config.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 1.h),
                    // ENTER VALUE
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: TextFormField(
                        controller: inputController,
                        onChanged: (value) {
                          userInput = double.tryParse(value) ?? 0;
                        },
                        style: TextStyle(
                            fontSize: Config.font_size_12.sp,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          hintText: 'Enter Your Value',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    // from
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'From',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    // SizedBox(height: 1.h),
                    // first value to convert DropDown
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              dropdownElevation: 5,
                              isExpanded: true,
                              hint: Text(
                                ' Choose a Unit ',
                                style: TextStyle(
                                  fontSize: Config.font_size_12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              selectedItemHighlightColor: Colors.lightGreen,
                              underline: Container(),
                              items: measures.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _startMeasures,
                              onChanged: (value) {
                                setState(() {
                                  _startMeasures = value;
                                  _convertMeasures = null;
                                  resultMessage = '';
                                });
                              },
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              iconSize: 30,
                              iconEnabledColor: Colors.black,
                              buttonHeight: 4.h,
                              buttonWidth: 40.w,
                              buttonPadding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border:
                                    Border.all(color: const Color(0XFFF1F1F1)),
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
                            // DropdownButton(
                            //   value: _startMeasures,
                            //   isExpanded: true,
                            //   dropdownColor: Colors.white,
                            //   style: TextStyle(
                            //       fontSize: 12.sp,
                            //       fontWeight: FontWeight.w700,
                            //       color: Colors.black),
                            //   hint: Center(
                            //     child: Padding(
                            //       padding: EdgeInsets.symmetric(horizontal: 10),
                            //       child: Text(
                            //         'Choose a Unit',
                            //         style: TextStyle(
                            //             color: Colors.black54, fontSize: 12.sp),
                            //       ),
                            //     ),
                            //   ),
                            //   items: measures.map((value) {
                            //     return DropdownMenuItem(
                            //       value: value,
                            //       child: Text(value),
                            //     );
                            //   }).toList(),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _startMeasures = value;
                            //       _convertMeasures = null;
                            //     });
                            //   },
                            // ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    //to
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'To',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                    ),
                    // SizedBox(height: 1.h),
                    //second value to convert DropDown
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: DropdownButtonHideUnderline(
                            child: buildToDropdown(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_startMeasures == null ||
                              _convertMeasures == null ||
                              userInput == 0) return;
                          convert(
                              userInput!, _startMeasures!, _convertMeasures!);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Config.careerCoachButtonColor),
                        child: Text(
                          'Convert',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child: Container(
                        height: 8.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Center(
                          child: SizedBox(
                            width: 34.w,
                            child: Text(
                              resultMessage ?? '',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//
//   void converts(double value, String from, String to) {
//     if ((from == 'Celsius' && to == 'Fahrenheit') ||
//         (from == 'Fahrenheit' && to == 'Celsius')) {
//       double result;
//       if (from == 'Celsius') {
//         result = (value * 9 / 5) + 32;
//       } else {
//         result = (value - 32) * 5 / 9;
//       }
//       setState(() {
//         resultMessage = '$value $from are ${result.toStringAsFixed(2)} $to';
//       });
//     } else if ((from == 'Celsius' && to == 'Kelvin') ||
//         (from == 'Kelvin' && to == 'Celsius')) {
//       double result;
//       if (from == 'Celsius') {
//         result = value + 273.15;
//       } else {
//         result = value - 273.15;
//       }
//       setState(() {
//         resultMessage = '$value $from are ${result.toStringAsFixed(2)} $to';
//       });
//     } else {
//       String conversionKey = '$from-$to';
//
//       if (formulas.containsKey(conversionKey)) {
//         double conversionFactor = formulas[conversionKey]!;
//
//         if (conversionFactor == 0) {
//           setState(() {
//             resultMessage = 'Cannot perform this conversion. Result is zero.';
//           });
//         }
//         else {
//           double result = value * conversionFactor;
//           setState(() {
//             resultMessage = '$value $from are ${result.toString()} $to';
//           });
//         }
//       } else {
//         setState(() {
//           resultMessage =
//               'Cannot perform this conversion. Conversion factor not available.';
//         });
//       }
//     }
//   }
// }

  void convert(double value, String from, String to) {
    setState(() {
      resultMessage = null; // Clear the old result
    });

    int? nFrom = measuresmap[from];
    int? nTo = measuresmap[to];

    if (nFrom == null || nTo == null) {
      setState(() {
        resultMessage = 'Cannot perform this conversion. Invalid units.';
      });
    } else {
      if (from == to) {
        setState(() {
          resultMessage = 'No need to convert. The units are the same.';
        });
      } else if ((from == 'Celsius' && to == 'Fahrenheit') ||
          (from == 'Fahrenheit' && to == 'Celsius')) {
        // Temperature conversion between Celsius and Fahrenheit
        double result;
        if (from == 'Celsius') {
          result = (value * 9 / 5) + 32;
        } else {
          result = (value - 32) * 5 / 9;
        }
        setState(() {
          resultMessage = '$value $from are ${result.toStringAsFixed(2)} $to';
        });
      } else if ((from == 'Celsius' && to == 'Kelvin') ||
          (from == 'Kelvin' && to == 'Celsius')) {
        // Temperature conversion between Celsius and Kelvin
        double result;
        if (from == 'Celsius') {
          result = value + 273.15;
        } else {
          result = value - 273.15;
        }
        setState(() {
          resultMessage = '$value $from are ${result.toStringAsFixed(2)} $to';
        });
      } else if ((from == 'Fahrenheit' && to == 'Kelvin') ||
          (from == 'Kelvin' && to == 'Fahrenheit')) {
        // Temperature conversion between Fahrenheit and Kelvin
        double result;
        if (from == 'Fahrenheit') {
          result = (value + 459.67) * 5 / 9; // Fahrenheit to Kelvin
        } else {
          result = value * 9 / 5 - 459.67; // Kelvin to Fahrenheit
        }
        setState(() {
          resultMessage = '$value $from are ${result.toStringAsFixed(2)} $to';
        });
      } else if ((nFrom >= 11 && nFrom <= 16) && (nTo >= 11 && nTo <= 16)) {
        // Time unit conversion
        List<double>? fromFactors = formulas[nFrom.toString()];
        List<double>? toFactors = formulas[nTo.toString()];
        if (fromFactors != null && toFactors != null) {
          double result = value * (fromFactors[nTo] / toFactors[nFrom]);
          setState(() {
            resultMessage = '$value $from are ${result.toStringAsFixed(2)} $to';
          });
        } else {
          setState(() {
            resultMessage =
                'Cannot perform this time unit conversion. Conversion factors not available.';
          });
        }
      } else if ((nFrom == measuresmap['Meter'] &&
              nTo == measuresmap['Inch']) ||
          (nFrom == measuresmap['Inch'] && nTo == measuresmap['Meter'])) {
        // Length conversion between Meter and Inch
        double conversionFactor = formulas['Meter-Inch']!;
        double result = value * conversionFactor;
        setState(() {
          resultMessage = '$value $from are ${result.toString()} $to';
        });
      } else if ((nFrom == measuresmap['Kilogram'] &&
              nTo == measuresmap['Pound']) ||
          (nFrom == measuresmap['Pound'] && nTo == measuresmap['Kilogram'])) {
        // Weight conversion between Kilogram and Pound
        double conversionFactor = formulas['Kilogram-Pound']!;
        double result = value * conversionFactor;
        setState(() {
          resultMessage = '$value $from are ${result.toString()} $to';
        });
      } else {
        // Other unit conversions (including power units).
        var multi = formulas[nFrom.toString()]?[nTo];
        if (multi == null) {
          setState(() {
            resultMessage =
                'Cannot perform this conversion. Conversion factor not available.';
          });
        } else {
          var result = value * multi;
          if (result == 0) {
            setState(() {
              resultMessage = 'Cannot perform this conversion. Result is zero.';
            });
          } else {
            setState(() {
              resultMessage = '$value $from are ${result.toString()} $to';
            });
          }
        }
      }
    }
  }
}
