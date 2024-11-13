import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/drawer.dart';
import 'package:legala/constants/imageconstant.dart';

class ViewTenantProfile extends StatefulWidget {
  const ViewTenantProfile({super.key});

  @override
  State<ViewTenantProfile> createState() => _ViewTenantProfileState();
}

class _ViewTenantProfileState extends State<ViewTenantProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.searchfield,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tenant Name',
                textAlign: TextAlign.left,
                style: GoogleFonts.urbanist(
                    color: ColorConstants.secondaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 46, // Adjust the width of the square
                      height: 46, // Adjust the height of the square
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/icons/profile.png'), // Your profile image
                          fit: BoxFit.cover, // To cover the entire container
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Tenant Name',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.blackcolor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    'Email - Tenant@gmail.com',
                    style: GoogleFonts.urbanist(
                        color: Color(0xff848FAC),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    'Phone - +91 9246555456',
                    style: GoogleFonts.urbanist(
                        color: Color(0xff848FAC),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    'Family Members - 6 ',
                    style: GoogleFonts.urbanist(
                        color: Color(0xff848FAC),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    'Address - Andhra Pradesh,\n Kakinada,533001',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.urbanist(
                        color: Color(0xff848FAC),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Color(0xffedf5ec),
                            borderRadius: BorderRadius.circular(5)),
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
                            borderRadius: BorderRadius.circular(5)),
                        child: Image.asset(
                          ImageConstants.DELETE,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Information',
                    style: GoogleFonts.urbanist(
                        color: ColorConstants.blackcolor,
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Property Name',
                            style: GoogleFonts.urbanist(
                                color: Color(0xff848FAC),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Vasudha Avenue',
                            style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Unit Name',
                            style: GoogleFonts.urbanist(
                                color: Color(0xff848FAC),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            '201',
                            style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Lease Start Date',
                            style: GoogleFonts.urbanist(
                                color: Color(0xff848FAC),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Jul 21,2020',
                            style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Lease End Date',
                            style: GoogleFonts.urbanist(
                                color: Color(0xff848FAC),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Jul 21,2024',
                            style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Divider(
                    color: Color(0xffC2C2C2),
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Documents',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.urbanist(
                          color: Color(0xff848FAC),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(20)),
              child: CarouselSlider(
                items: [
                  // Add square images
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/icons/profile.png', // Image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/icons/profile.png', // Image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Add more images as needed
                ],
                options: CarouselOptions(
                  height: 200, // Adjust the height as needed
                  aspectRatio: 1, // Square aspect ratio
                  viewportFraction: 0.5, // Show 2 images at a time
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
