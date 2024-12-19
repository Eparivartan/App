
// ignore_for_file: unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/datepick.dart';
import 'package:legala/constants/drawer.dart';
import 'package:legala/constants/filterconstant.dart';
import 'package:legala/models/dummymodel.dart';
import 'package:legala/screens/tenant/createtenant.dart';
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
                        MaterialPageRoute(builder: (context) => const CreateTenant()),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
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
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),

              const TenazListScreen(),
           
            ],
          ),
        ),
      ),
    );
  }
}
