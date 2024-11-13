import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/drawer.dart';
import 'package:legala/constants/filterconstant.dart';
import 'package:legala/constants/imageconstant.dart';
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
                            EdgeInsets.symmetric(vertical: 12,horizontal: 14),
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
                                      width: 100,
                                      height: 100,
                                      color: Colors.blue,
                                      child: Center(
                                        child: Image.asset(
                                          ImageConstants.PROPERTYIMG,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text('201',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.blackcolor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text('Vasudha Avenue',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text('1200 sq ft',
                                        style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Color(0xffedf5ec),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Image.asset(
                                            ImageConstants.EDIT,
                                            height: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Color(0xffe6e6e6),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Image.asset(
                                            ImageConstants.DELETE,
                                            height: 20,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              color: ColorConstants.textcolor,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Row(
                              children: [

                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Color(0xfff4f4f4),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Image.asset(ImageConstants.BEDROOM,height: 20,),
                                     SizedBox(width: 2.w),
                                     Text('02', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600))

                                    ],
                                  ),
                                ),
                                SizedBox(width: 2.w,),
                                 Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Color(0xfff4f4f4),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Image.asset(ImageConstants.KITCHEN,height: 20,),
                                     SizedBox(width: 2.w),
                                     Text('02', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600))

                                    ],
                                  ),
                                ),
                                SizedBox(width: 2.w,),
                                 Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Color(0xfff4f4f4),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Image.asset(ImageConstants.BATHROOOMS,height: 20,),
                                     SizedBox(width: 2.w),
                                     Text('02', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600))

                                    ],
                                  ),
                                ),
                                SizedBox(width: 2.w,),
                                
                                
                              ],
                            ),
                            SizedBox(height: 1.h,),
                             Text('Rent Type - Monthly', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                             Text('Rent - ₹50000', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                              Text('Rent Duration - 7 Years', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                               Text('Deposit Amount - ₹500000', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                             Text('Yearly Tax - ₹3000', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Container(
                                              width: 200,
                                              child: Divider(
                                                thickness: 1,
                                                color: ColorConstants.bordercolor,
                                              ),
                                            ),
                                            

                                            Text('Current Tenant', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                            SizedBox(
                                              height: 20,
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
