import 'dart:convert';

import 'package:commercilapp/constant/apiconstant.dart';
import 'package:commercilapp/constant/colorconstant.dart';

import 'package:commercilapp/homepage/searchfilter.dart';
import 'package:commercilapp/homepage/viewdetailspage.dart';
import 'package:commercilapp/homepage/filterbottomsheet.dart';
import 'package:commercilapp/providers/storage%20categoryprovider.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../constant/imageconstant.dart';

class SubCategory extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final listTitle;
  // ignore: prefer_typing_uninitialized_variables
  final catid;
  const SubCategory({super.key, required, this.listTitle, this.catid});
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  List<dynamic> data = []; // Store the fetched data
  bool _isLoading = true; // Loading state
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1; // Track the current page
  bool _hasMore = true; // Track if there's more data
  String? keyurl;
  String? selectedproptype;
  String? selectedcityid;
  String? selectedlocationid;
  String? selectedcategoryid;
  String? selectedgrade;
  String? selectedminimumbudget;
  String? selectedmaxbudget;
  String? selectedcattext;

  @override
  void initState() {
    super.initState();
    _fetchLocations(_currentPage);
    // Fetch locations when the widget is initialized
  }

  Future<void> _fetchLocations(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    keyurl = prefs.getString('filter_keys_url');
   

    setState(() {
      selectedproptype = prefs.getString('selectpropertytype');
      selectedcityid = prefs.getString('selectedcityid');
      selectedlocationid = prefs.getString('selectedlocationid');
      selectedcategoryid = prefs.getString('selectedcategoryid');
      selectedgrade = prefs.getString('selectedgrade');
      selectedminimumbudget = prefs.getString('selectedminimumbudget');
      selectedmaxbudget = prefs.getString('selectedmaxbudget');
      selectedcattext = prefs.getString('selectedcattext');
    });
  
    var url =
        "${BaseUrl}api-filter-list-page.php?procat=${selectedproptype}&scity=${selectedcityid}&sarea=${selectedlocationid}&sprop=${selectedcategoryid}&pgrade=${selectedgrade}&BudgetMin=${selectedminimumbudget}&BudgetMax=${selectedmaxbudget}&page=$page";
   
    try {
      final response = await http.get(Uri.parse(url.toString()));
    

      if (response.statusCode == 200) {
        setState(() {
          data = json
              .decode(response.body.toString()); // Decode and assign the data
          _isLoading = false; // Set loading to false after data is fetched
        });
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
    
      setState(() {
        _isLoading = false; // Stop loading on error
      });
    }
  }

  void _loadPrevious() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--; // Decrease the current page
        _isLoading = true; // Set loading to true
      });
      _fetchLocations(_currentPage); // Fetch the previous page
    }
  }

  void _loadNext() {
    if (_hasMore) {
      setState(() {
        _currentPage++; // Increase the current page
        _isLoading = true; // Set loading to true
      });
      _fetchLocations(_currentPage); // Fetch the next page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _isLoading = true;
          });
          _fetchLocations(_currentPage);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Place any widget you want at the top of the ListView here
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, child) {
                        return Text(
                          '${categoryProvider.selectedTitle}',
                          style: GoogleFonts.plusJakartaSans(
                              color: ColorConstants.secondaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 17.sp),
                        );
                      },
                    ),
                    
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          builder: (BuildContext context) {
                            return Container(child: ResponsiveBottomSheet());
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xff5078E1),
                            width: 1,
                          ),
                        ),
                        child: Image.asset(
                          'assets/icons/filter.png',
                          height: 20,
                        ),
                      ),
                    )
                  ],
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
                         border: Border.all(color: ColorConstants.bordercolor,width: 1)
                      ),
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
                           Icon(Icons.search,color: ColorConstants.black,size: 15,)
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
                    : data.isEmpty
                        ? Center(
                            child: Text(
                                'No locations found')) // Handle no data case
                        : ListView.builder(
                            itemCount: data.length,
                            shrinkWrap:
                                true, // This will ensure the ListView takes only the necessary space
                            physics:
                                NeverScrollableScrollPhysics(), // Prevent scrolling within the ListView if it's in a scrollable parent
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewDetailsPage(
                                            id: '${data[index]['id']}')),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstants.bgcolor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4),
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
                                                child:
                                                    data[index]['image'] == null
                                                        ? Image.network(
                                                            'https://img.freepik.com/premium-photo/modern-city-with-wireless-network-connection-generative-ai_887552-4865.jpg',
                                                            fit: BoxFit
                                                                .cover, // Fit image to container while keeping aspect ratio
                                                          )
                                                        : Image.network(
                                                            'https://vevarealty.com/images_uploades/${data[index]['image']}',
                                                            fit: BoxFit
                                                                .cover, // Ensures the image covers the available space
                                                          ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10), // Static spacing
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${data[index]['title']}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          color: ColorConstants
                                                              .secondaryColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                              Text(
                                                  '${data[index]['proPrice']}' +
                                                      '${data[index]['areaType']}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          color: ColorConstants
                                                              .secondaryColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                ImageConstants.LOCATION,
                                                height: 15,
                                                color:
                                                    ColorConstants.primaryColor,
                                              ),
                                              SizedBox(
                                                width: 1.w,
                                              ),
                                              Text(
                                                  '${data[index]['area_title']}' +
                                                      ',' +
                                                      '${data[index]['city_name']}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          color: ColorConstants
                                                              .secondaryColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: _loadPrevious,
                        icon: Icon(
                          Icons.arrow_left,
                          color: Colors.black,
                          size: 25,
                        )),
                    Text(
                      '${_currentPage.toString()}',
                      style: GoogleFonts.plusJakartaSans(
                          color: ColorConstants.textcolor,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        onPressed: _loadNext,
                        icon: Icon(
                          Icons.arrow_right,
                          color: Colors.black,
                          size: 25,
                        )),
                  ],
                ),

                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  color: Color(0xff747474),
                  thickness: 1,
                  height: 2,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Center(
                  child: Image.asset(
                    ImageConstants.COMMERCIALPAL,
                    height: 24,
                    width: 150,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Center(
                    child: Text(
                        'Still unable to find what you need? Our team will assist you.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400))),
                SizedBox(
                  height: 1.h,
                ),
                Center(
                    child: Text('Enquiry',
                        style: GoogleFonts.plusJakartaSans(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
