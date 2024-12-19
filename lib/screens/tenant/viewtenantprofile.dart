// ignore_for_file: deprecated_member_use, duplicate_ignore, non_constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/appbarconstant.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/drawer.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/models/unitdropdown.dart';
import 'package:legala/screens/tenant/edittenantdetails.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ViewTenantProfile extends StatefulWidget {
  const ViewTenantProfile({super.key});

  @override
  State<ViewTenantProfile> createState() => _ViewTenantProfileState();
}

class _ViewTenantProfileState extends State<ViewTenantProfile> {
  Map<String, dynamic>? tenantRecord;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollViewController = ScrollController();
  String? deleteid;
  // String? tenantdocument;
  bool isLoading = false;
  List<dynamic> list2Documents = [];
  List<dynamic> list1Documents = [];
  List<dynamic> list3Documents = [];

  //startcondition

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200, // Adjust for desired scroll speed
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 200, // Adjust for desired scroll speed
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

//endcondition

  void _scrollendleft() {
    _scrollViewController.animateTo(_scrollViewController.offset - 200,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _scrollendright() {
    _scrollViewController.animateTo(_scrollViewController.offset + 200,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    fetchTenantRecord();
    super.initState();
  }

  Future<void> fetchTenantRecord() async {
    try {
      final tenantid =
          Provider.of<TenantProvider>(context, listen: false).tenantId;
  final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/gettenantrecord/$tenantid'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        if (responseData['data'] != null && responseData['data'].isNotEmpty) {
          setState(() {
            tenantRecord = responseData['data'][0];
          });


          // Guard against null values in documents
          final documents = tenantRecord?['documents'] as Map<String, dynamic>?;

          if (documents != null) {
            // List 1
            if (documents['1'] != null) {
             
              for (var doc in documents['1']) {
                setState(() {
                  list1Documents = List.from(documents['1']);
                });
              }
            }

            // List 2
            if (documents['2'] != null) {
             
              for (var doc in documents['2']) {
                setState(() {
                  list2Documents = List.from(documents['2']);
                });
              }
            }

            // List 3
            if (documents['3'] != null) {
              for (var doc in documents['3']) {
                setState(() {
                  list3Documents = List.from(documents['3']);
                });
              }
            }
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No tenant data available')),
          );
        }
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to fetch data: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.searchfield,
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tenant Details',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.secondaryColor,
                      // ignore: deprecated_member_use
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
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
                        width: 87, // Adjust the width of the square
                        height: 93, // Adjust the height of the square
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                          image: DecorationImage(
                            image: tenantRecord?['Image'] != null
                                ? NetworkImage(
                                    'https://www.eparivartan.co.in/rentalapp/public/${tenantRecord?['Image']}')
                                : const AssetImage('assets/icons/profile.png')
                                    as ImageProvider,
                            fit: BoxFit.cover, // To cover the entire container
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      '${tenantRecord?['tenantFisrtName']}${tenantRecord?['tenantLastName']}',
                      style: GoogleFonts.urbanist(
                          color: ColorConstants.blackcolor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Email - ${tenantRecord?['tenantEmail']}',
                            style: GoogleFonts.urbanist(
                                color: const Color(0xff848FAC),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Phone - +91 ${tenantRecord?['tenantPhone']}',
                            style: GoogleFonts.urbanist(
                                color: const Color(0xff848FAC),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Family Members - ${tenantRecord?['totalMembers']}',
                            style: GoogleFonts.urbanist(
                                color: const Color(0xff848FAC),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Address - ${tenantRecord?['address']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.urbanist(
                                color: const Color(0xff848FAC),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                          

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TenantEditPage(tenantresponse:tenantRecord)),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: const Color(0xffedf5ec),
                                borderRadius: BorderRadius.circular(5)),
                            child: Image.asset(
                              ImageConstants.EDIT,
                              height: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              deleteid = tenantRecord?['tenantId'];
                            });
                            
                            DeleteIndex();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: const Color(0xffe6e6e6),
                                borderRadius: BorderRadius.circular(5)),
                            child: Image.asset(
                              ImageConstants.DELETE,
                              height: 20,
                            ),
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
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: ColorConstants.whiteColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Additional Information',
                        style: GoogleFonts.urbanist(
                            color: ColorConstants.blackcolor,
                            // ignore: deprecated_member_use
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                                      color: const Color(0xff848FAC),
                                      // ignore: deprecated_member_use
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  '${tenantRecord?['propertyName']}',
                                  style: GoogleFonts.urbanist(
                                      color: Colors.black,
                                      // ignore: deprecated_member_use
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
                                      color: const Color(0xff848FAC),
                                      // ignore: deprecated_member_use
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  '${tenantRecord?['unitName']}',
                                  style: GoogleFonts.urbanist(
                                      color: Colors.black,
                                      // ignore: deprecated_member_use
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
                                      color: const Color(0xff848FAC),
                                      // ignore: deprecated_member_use
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  '${tenantRecord?['leasestartdate']}',
                                  style: GoogleFonts.urbanist(
                                      color: Colors.black,
                                      // ignore: deprecated_member_use
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
                                      color: const Color(0xff848FAC),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  '${tenantRecord?['leaseenddate']}',
                                  style: GoogleFonts.urbanist(
                                      color: Colors.black,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    const Divider(
                      color: Color(0xffC2C2C2),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Text(
                          'Documents',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.urbanist(
                              color: const Color(0xff848FAC),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: ListView.builder(
                        itemCount: list1Documents.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var doc = list2Documents[index];
                          return Text(
                            doc['docName'] ?? 'No Name',
                            style: GoogleFonts.urbanist(
                              decoration: TextDecoration
                                  .underline, // Underline the text
                              fontSize: 11
                                  .sp, // Optional: Adjust the font size if needed
                              color: ColorConstants
                                  .secondaryColor, // Optional: Change the text color
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Start Condition',
                            style: GoogleFonts.urbanist(
                                color: ColorConstants.blackcolor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              ImageConstants.LEFTARROW,
                              height: 25,
                              width: 25,
                            ),
                            onPressed: _scrollLeft,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemCount: list2Documents.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var doc = list2Documents[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      width:
                                          129, // Adjust the width of the square
                                      height:
                                          126, // Adjust the height of the square
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            8), // Rounded corners
                                        image: DecorationImage(
                                          image: doc['docPath'] != null
                                              ? NetworkImage(
                                                  'https://www.eparivartan.co.in/rentalapp/public/${doc['docPath']}')
                                              : const AssetImage(
                                                      'assets/icons/profile.png')
                                                  as ImageProvider,
                                          fit: BoxFit
                                              .cover, // To cover the entire container
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Image.asset(
                              ImageConstants.RIGHTARROW,
                              height: 25,
                              width: 25,
                            ),
                            onPressed: _scrollRight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'End Condition',
                            style: GoogleFonts.urbanist(
                                color: ColorConstants.blackcolor,
                                fontSize: 21.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              ImageConstants.LEFTARROW,
                              height: 15,
                              width: 15,
                            ),
                            onPressed: _scrollendleft,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemCount: list3Documents.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var doc = list3Documents[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      width:
                                          129, // Adjust the width of the square
                                      height:
                                          126, // Adjust the height of the square
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            8), // Rounded corners
                                        image: DecorationImage(
                                          image: doc['docPath'] != null
                                              ? NetworkImage(
                                                  'https://www.eparivartan.co.in/rentalapp/public/${doc['docPath']}')
                                              : const AssetImage(
                                                      'assets/icons/profile.png')
                                                  as ImageProvider,
                                          fit: BoxFit
                                              .cover, // To cover the entire container
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Image.asset(
                              ImageConstants.RIGHTARROW,
                              height: 25,
                              width: 25,
                            ),
                            onPressed: _scrollendright,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.5.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> DeleteIndex() async {
    final String url =
        "https://www.eparivartan.co.in/rentalapp/public/user/deletetenant/$deleteid";
    final bearerToken =
        Provider.of<TokenProvider>(context, listen: false).accessToken; //
   

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
      );
  

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        // Remove the deleted property from the list
      } else {
          Fluttertoast.showToast(
      msg: "Failed to delete property: ${response.statusCode}", // Message to display
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast (short or long)
      gravity: ToastGravity.BOTTOM, // Position of the toast (top, center, bottom)
      timeInSecForIosWeb: 1, // iOS/Web toast duration
      backgroundColor: Colors.black, // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Text font size
    );
        
      }
    } catch (error) {
      Fluttertoast.showToast(
      msg: "Failed to delete property: ${error.toString()}", // Message to display
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast (short or long)
      gravity: ToastGravity.BOTTOM, // Position of the toast (top, center, bottom)
      timeInSecForIosWeb: 1, // iOS/Web toast duration
      );
      
    }
  }

}
