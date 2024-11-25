import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/drawer.dart';
import 'package:legala/constants/filterconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/models/unitview.dart';
import 'package:legala/screens/units/createunit.dart';


class UnitsList extends StatefulWidget {
  const UnitsList({super.key});

  @override
  State<UnitsList> createState() => _UnitsListState();
}

class _UnitsListState extends State<UnitsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.searchfield,
      appBar: CustomAppBar(), // Call your reusable CustomAppBar here
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 4.h,
              ),
              FilterConstant(),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vasudha Avenue',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.secondaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateUnit()),
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
                            'Create Unit',
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
             RentalUnitsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
