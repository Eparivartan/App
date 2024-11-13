import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/datepick.dart';
import 'package:legala/constants/drawer.dart';
import 'package:legala/constants/filterconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/screens/tenant/createtenant.dart';
import 'package:legala/screens/tenant/viewtenantprofile.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart'; // Import app bar constant

class TenantList extends StatefulWidget {
  const TenantList({super.key});

  @override
  State<TenantList> createState() => _TenantListState();
}

class _TenantListState extends State<TenantList> {
  List<bool> switchValues = List.generate(15, (index) => false);

  DateTime? selectedDate;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedDate = args.value;
    });
  }

  void _showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [DatePickerDemo()],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.searchfield,
      appBar: CustomAppBar(), // Call your reusable CustomAppBar here
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              FilterConstant(),
              SizedBox(height: 10),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Properties',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.secondaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateTenant()),
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: ColorConstants.primaryColor,
                            size: 20,
                          ),
                          Text(
                            'Add Tenant',
                            style: GoogleFonts.urbanist(
                                color: ColorConstants.primaryColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 12,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewTenantProfile()),
                      );
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: ColorConstants.whiteColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CircleAvatar(
                                    radius:
                                        24, // Adjust the size of the profile picture
                                    backgroundImage: AssetImage(
                                        'assets/icons/profile.png'), // Replace with your profile image
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Vijaymalya',
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.urbanist(
                                                color: ColorConstants
                                                    .secondaryColor,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '₹' + '50,000' + '/-',
                                              textAlign: TextAlign.right,
                                              style: GoogleFonts.urbanist(
                                                  color: ColorConstants
                                                      .secondaryColor,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '2BHK',
                                        style: GoogleFonts.urbanist(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ColorConstants.lighttext),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Hyderabad',
                                            style: GoogleFonts.urbanist(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstants.lighttext),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF2F4FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Icon(
                                                  Icons.phone,
                                                  color: Color(0xff526bf1),
                                                  size: 2.5.h,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Divider(
                              color: ColorConstants.lighttext,
                              thickness: 0.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Due Date: 26Aug,2024',
                                  style: GoogleFonts.urbanist(
                                      color: switchValues[index] == false
                                          ? ColorConstants.textcolor
                                          : ColorConstants.dueconstantcolor,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.scale(
                                      scale:
                                          0.8, // Adjust the scale to control the size
                                      child: CupertinoSwitch(
                                        value: switchValues[index],
                                        onChanged: (value) {
                                          setState(() {
                                            switchValues[index] = value;
                                            print(value.toString());
                                          });
                                        },
                                        thumbColor: ColorConstants.whiteColor,
                                        activeColor: Color(
                                            0xff68CC58), // Thumb color when active
                                        trackColor: Color(
                                            0xffF0F0F2), // Track color when inactive
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      switchValues[index] == false
                                          ? 'Make as paid'
                                          : 'Paid',
                                      style: GoogleFonts.urbanist(
                                          color: ColorConstants.lighttext,
                                          fontSize: 5.sp,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
