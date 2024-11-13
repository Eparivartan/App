import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:commercilapp/constant/apiconstant.dart';
import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:commercilapp/homepage/searchfilter.dart';
import 'package:commercilapp/models/recentlyadedmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class RecomendedList extends StatefulWidget {
  const RecomendedList({super.key});

  @override
  State<RecomendedList> createState() => _RecomendedListState();
}

class _RecomendedListState extends State<RecomendedList> {
  bool _isLoading = true;
  List<RecentlyAded> _recentlyAddedList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Fetch data from the API
  void _fetchData() async {
    final response = await http.get(Uri.parse('${BaseUrl}api-list-page.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _recentlyAddedList =
            data.map((json) => RecentlyAded.fromJson(json)).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 55,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    ImageConstants.COMMERCIALPAL,
                    height: 24,
                    width: 150,
                  ),
                  Center(
                      child: GestureDetector(
                          onTap: (() {
                            Navigator.pop(context);
                          }),
                          child: Image.asset(
                            ImageConstants.ARROWBACK,
                            height: 30,
                          )))
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Recomended List',
                style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 17.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchFilter()),
                  );
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: ColorConstants.bordercolor, width: 1)),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Search',
                            style: TextStyle(
                              color: ColorConstants.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: ColorConstants.black,
                            size: 15,
                          )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 3.h,
              ),
              Divider(
                color: Color(0xff747474),
                thickness: 1,
                height: 2,
              ),
              SizedBox(
                height: 3.h,
              ),
              _isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Show loading indicator
                  : _recentlyAddedList.isEmpty
                      ? Center(
                          child:
                              Text('No locations found')) // Handle no data case
                      : ListView.builder(
                          itemCount: _recentlyAddedList.length,
                          shrinkWrap:
                              true, // Ensures the ListView takes only the necessary space
                          physics:
                              NeverScrollableScrollPhysics(), // Prevent scrolling within the ListView if it's in a scrollable parent
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                               
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 7),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorConstants.bgcolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Container(
                                          padding: EdgeInsets.only(top: 7),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.17, // 22% of the screen height
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              width: double.infinity,
                                              child: _recentlyAddedList[index]
                                                          .image ==
                                                      null
                                                  ? Image.network(
                                                      'https://img.freepik.com/premium-photo/modern-city-with-wireless-network-connection-generative-ai_887552-4865.jpg',
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      'https://vevarealty.com/images_uploades/${_recentlyAddedList[index].image}',
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10), // Static spacing
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${_recentlyAddedList[index].title}',
                                              style: GoogleFonts.plusJakartaSans(
                                                color:
                                                    ColorConstants.secondaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              '${_recentlyAddedList[index].proPrice}' +
                                                  '${_recentlyAddedList[index].areaType}',
                                              style: GoogleFonts.plusJakartaSans(
                                                color:
                                                    ColorConstants.secondaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 12),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              ImageConstants.LOCATION,
                                              height: 15,
                                              color: ColorConstants.primaryColor,
                                            ),
                                            SizedBox(width: 1.w),
                                            Text(
                                              '${_recentlyAddedList[index].areaTitle}' +
                                                  ',' +
                                                  '${_recentlyAddedList[index].cityName}',
                                              style: GoogleFonts.plusJakartaSans(
                                                color:
                                                    ColorConstants.secondaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              Divider(color: Color(0xff747474), thickness: 1, height: 2),
              SizedBox(height: 4.h),
              Center(
                child: Image.asset(
                  ImageConstants.COMMERCIALPAL,
                  height: 24,
                  width: 150,
                ),
              ),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  'Still unable to find what you need? Our team will assist you.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  'Enquiry',
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
