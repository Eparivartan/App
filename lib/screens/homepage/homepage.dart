// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/datepick.dart';
import 'package:legala/constants/drawer.dart';
import 'package:legala/constants/filterconstant.dart';
// Import app bar constant

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<bool> switchValues = List.generate(15, (index) => false);

  DateTime? selectedDate;


  void _showDatePickerDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Column(
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
      appBar: const CustomAppBar(), // Call your reusable CustomAppBar here
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const FilterConstant(),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Upcoming Dues',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.secondaryColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 12,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showDatePickerDialog(context);
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: ColorConstants.whiteColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
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
                                              '₹50,000/-',
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
                                      const SizedBox(height: 5),
                                      Text(
                                        '2BHK',
                                        style: GoogleFonts.urbanist(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ColorConstants.lighttext),
                                      ),
                                      const SizedBox(height: 5),
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
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: const Color(0xffF2F4FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Icon(
                                                  Icons.phone,
                                                  color: const Color(0xff526bf1),
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
                            const Divider(
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
                                           
                                          });
                                        },
                                        thumbColor: ColorConstants.whiteColor,
                                        activeColor: const Color(
                                            0xff68CC58), // Thumb color when active
                                        trackColor: const Color(
                                            0xffF0F0F2), // Track color when inactive
                                      ),
                                    ),
                                    const SizedBox(height: 4),
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
