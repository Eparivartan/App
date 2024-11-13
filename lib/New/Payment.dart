// import 'package:careercoach/New/payment%20gateway.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../Config.dart';
// import '../Widgets/App_Bar_Widget.dart';
// import '../paymentScreen.dart';
//
// class Payment extends StatefulWidget {
//   const Payment({Key? key}) : super(key: key);
//
//   @override
//   State<Payment> createState() => _PaymentState();
// }
//
// class _PaymentState extends State<Payment> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(6.h),
//           child: App_Bar_widget(
//             title: 'AutoCAD 2D',
//           )),
//       body: SafeArea(
//         child: ListView(
//           children: <Widget>[
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Color(0XFFFFE59B),
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10))),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'AutoCAD 2D',
//                                 style: TextStyle(
//                                     fontSize: 11.sp,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Container(
//                                 width: 70.w,
//                                 child: Text(
//                                   'To unlock the full course content subscribe'
//                                   ' to this course now!',
//                                   style: TextStyle(
//                                       fontSize: 11.sp,
//                                       fontWeight: FontWeight.normal),
//                                 ),
//                               )
//                             ],
//                           ),
//                           Stack(children: [
//                             Image.asset(
//                               "assets/images/paymentbanner.png",
//                               width: 75,
//                               height: 75,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(top: 28.0, left: 12),
//                               child: Text(
//                                 '₹499/-',
//                                 style: TextStyle(
//                                   fontSize: 11.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             )
//                           ]),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0, right: 8),
//                   child: Container(
//                     decoration:
//                         const BoxDecoration(color: Config.containerColor),
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(left: 12, right: 12, top: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           RichText(
//                               text: TextSpan(children: [
//                             TextSpan(
//                               text: 'Course by: ',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 11.sp,
//                                   color: Config.primaryTextColor),
//                             ),
//                             TextSpan(
//                                 text: 'ABC Limited',
//                                 style: TextStyle(
//                                     fontSize: 11.sp,
//                                     color: Config.primaryTextColor))
//                           ])),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           RichText(
//                               text: TextSpan(children: [
//                             TextSpan(
//                               text: 'Bill to: ',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 11.sp,
//                                   color: Config.primaryTextColor),
//                             ),
//                             TextSpan(
//                                 text: 'John Doe',
//                                 style: TextStyle(
//                                     fontSize: 11.sp,
//                                     color: Config.primaryTextColor))
//                           ])),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           DottedLine(
//                             dashLength: 2,
//                             dashGapLength: 2,
//                             lineThickness: 1,
//                             dashColor: Color(0XFFE2E2E2),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Charges:',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 11.sp,
//                                     color: Config.primaryTextColor),
//                               ),
//                               Text('₹499/-')
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Discount Code:',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 11.sp,
//                                     color: Config.primaryTextColor),
//                               ),
//                               Text('₹49/-')
//                             ],
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Container(
//                             width: 40.5.w,
//                             height: 3.34.h,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     width: 1, color: Color(0XFFEBEBEB))),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text('CA23PEC15'),
//                                 Icon(
//                                   Icons.cancel,
//                                   color: Color(0XFFCCCCCC),
//                                   size: 15,
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           DottedLine(
//                             dashLength: 2,
//                             dashGapLength: 2,
//                             lineThickness: 1,
//                             dashColor: Color(0XFFE2E2E2),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Net Payable Amount:',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 11.sp,
//                                     color: Config.primaryTextColor),
//                               ),
//                               Text(
//                                 '₹450/-',
//                                 style: TextStyle(fontSize: 11.sp),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 100,
//                           ),
//                           // Container(
//                           //   child: TextButton(
//                           //     onPressed: (){},
//                           //     child: Text('Confirm'),
//                           //   ),
//                           // )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                   width: 200,
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         new BoxShadow(
//                           color: Color(0XFF00000029),
//                           blurRadius: 10.0,
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(7),
//                       border: Border.all(color: Color(0XFF999999), width: 1)),
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(
//                           builder: (context) => PaymentCashFree()));
//                     },
//                     child: Text(
//                       'Confirm & Pay ₹450/->>',
//                       style: TextStyle(
//                           fontSize: 12.sp, color: Config.primaryTextColor),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
