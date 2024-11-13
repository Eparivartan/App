import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/drawer.dart';
import 'package:legala/constants/filterconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/screens/properties/createpropertiess.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
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
                    'Properties',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.secondaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: (){
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateProperties()),
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
                            'Create Property',
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
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                        decoration: BoxDecoration(
                            color: ColorConstants.whiteColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        5.0), // Rounded corners
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.blue,
                                      child: Center(
                                        child: Image.asset(
                                          ImageConstants.PROPERTYIMG,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Vasudha Avenue',
                                        style: GoogleFonts.urbanist(
                                            color:
                                                ColorConstants.secondaryColor,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        'Hyderabad, Telangana',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '3000 sq ft',
                                            style: GoogleFonts.urbanist(
                                                color: ColorConstants.lighttext,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            'Villa',
                                            style: GoogleFonts.urbanist(
                                                color: ColorConstants
                                                    .secondaryColor,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: ColorConstants.bordercolor,
                              thickness: 1,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Units: 10',
                                      style: GoogleFonts.urbanist(
                                          color: ColorConstants.textcolor,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                     Text(
                                      'Available Units: 05',
                                      style: GoogleFonts.urbanist(
                                          color: ColorConstants.primaryColor,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    
                                  ],
                                ),
                                Spacer(),

                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Color(0xffedf5ec),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Image.asset(ImageConstants.EDIT,height: 20,),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                 Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Color(0xffe6e6e6),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Image.asset(ImageConstants.DELETE,height: 20,),
                                ),


                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
