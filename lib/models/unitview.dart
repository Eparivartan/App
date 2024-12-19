
// ignore_for_file: deprecated_member_use, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/models/getunitmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RentalUnitsPage extends StatefulWidget {
  const RentalUnitsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RentalUnitsPageState createState() => _RentalUnitsPageState();
}

class _RentalUnitsPageState extends State<RentalUnitsPage> {
  Future<Getunits> fetchUnits() async {
   final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/units'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
     

    if (response.statusCode == 200) {
      return Getunits.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load units');
    }
  }
  String? unitid;

  @override
  Widget build(BuildContext context) {
    return  RefreshIndicator(
      onRefresh: fetchUnits,
      child: FutureBuilder<Getunits>(
          future: fetchUnits(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.allunits!.isEmpty) {
              return const Center(child: Text('No units found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.allunits!.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var unit = snapshot.data!.allunits![index];
                  return GestureDetector(
                    onTap: (){
                     
                    },
                    child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 12,horizontal: 14),
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
                                borderRadius:
                                    BorderRadius.circular(5.0), // Rounded corners
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.blue,
                                  child: Center(
                                    child: unit.thumbnail != null &&
                                            unit.thumbnail!.isNotEmpty
                                        ? Image.network(
                                            'https://www.eparivartan.co.in/rentalapp/public/${unit.thumbnail}',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              // Fallback to asset image on error
                                              return Image.asset(
                                                'assets/images/property.png',
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            'assets/images/property.png',
                                            height: 50,
                                            width: 50,
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
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xffedf5ec),
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
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                unitid  = unit.unitId;
                                                  
                                                });
                                                DeleteIndex();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: const Color(0xffe6e6e6),
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: Image.asset(
                                                  ImageConstants.DELETE,
                                                  height: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: ColorConstants.textcolor,
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Row(
                                  children: [
                    
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xfff4f4f4),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         Image.asset(ImageConstants.BEDROOM,height: 20,),
                                         SizedBox(width: 2.w),
                                         Text(unit.bedrooms ?? 'emptybedrooms', style: GoogleFonts.urbanist(
                                                color: ColorConstants.lighttext,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w600))
                    
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 2.w,),
                                     Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xfff4f4f4),
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
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xfff4f4f4),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         Image.asset(ImageConstants.BATHROOOMS,height: 20,),
                                         SizedBox(width: 2.w),
                                         Text(unit.bathrooms ?? 'Empty Bathrooms', style: GoogleFonts.urbanist(
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
                                                const SizedBox(
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
                                                const SizedBox(
                                                  height: 20,
                                                )
                                                
                    
                    
                              ],
                            ),
                          ),
                        ),
                  );
                },
              );
            }
          },
        ),
    );
  }
  
  // ignore: non_constant_identifier_names
  Future<void> DeleteIndex() async{
    final String url = "https://www.eparivartan.co.in/rentalapp/public/user/deleteunit/${unitid}";
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
    

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
      
        await fetchUnits();

        // Remove the deleted property from the list
       
      } else {
        
      }
    // ignore: empty_catches
    } catch (error) {
     
    }

  } 
}