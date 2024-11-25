
import 'dart:convert';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/models/getunitmodel.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';

class RentalUnitsPage extends StatefulWidget {
  @override
  _RentalUnitsPageState createState() => _RentalUnitsPageState();
}

class _RentalUnitsPageState extends State<RentalUnitsPage> {
  Future<Getunits> fetchUnits() async {
     final token = Provider.of<TokenProvider>(context, listen: false)
        .accessToken; 
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/units'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.toString());

    if (response.statusCode == 200) {
      return Getunits.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load units');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<Getunits>(
        future: fetchUnits(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.allunits!.isEmpty) {
            return Center(child: Text('No units found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.allunits!.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var unit = snapshot.data!.allunits![index];
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
                                    Text(unit.unitName ?? "Emoty Units",
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
                                    Text('${unit.unitSize ?? 'emptyUnit'} sq ft',
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
                                     Text('${unit.bedrooms ?? 'emptybedrooms'}', style: GoogleFonts.urbanist(
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
                                     Text('${unit.bathrooms ?? 'Empty Bathrooms'}', style: GoogleFonts.urbanist(
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
                             Text('Rent Type - ${unit.rentType ?? 'No RentType'}', style: GoogleFonts.urbanist(
                                            color: ColorConstants.lighttext,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                             Text('Rent - ₹${unit.rentAmount ?? 'No Rent Amount'}', style: GoogleFonts.urbanist(
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
                                               Text('Deposit Amount - ₹${unit.depositAmount ?? 'Deposit Amount'}', style: GoogleFonts.urbanist(
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
              },
            );
          }
        },
      );;
  }
}