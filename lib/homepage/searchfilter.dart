import 'dart:convert';
import 'package:commercilapp/homepage/searchfilterdetails.dart';
import 'package:http/http.dart' as http;
import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  List<dynamic> data = [];
  String? searchText;
  bool _isLoading = false;
  bool _isInitialLoad = true; // Track if it's the initial page load
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  bool _hasMore = true;
  Future<void> _fetchLocations(int page) async {
    if (searchText == null || searchText!.isEmpty) return;

    var url =
        "https://mycommercialpal.com/api-search-list-page.php?sval=${Uri.encodeComponent(searchText!)}&page=$page";
   

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        setState(() {
          // Check if responseData is a map or a list
          if (responseData is List) {
            data = responseData; // Directly assign if it's a list
          } else if (responseData is Map && responseData.containsKey('data')) {
            // Check for a 'data' key if the list is nested within a map
            data = responseData['data'] as List<dynamic>;
          } else {
            data = []; // Empty list if no relevant data is found
          }
          _isLoading = false;
          _hasMore = data.isNotEmpty;
        });
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
     
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Reset pagination and initiate a new search
  void _startSearch() {
    setState(() {
      _currentPage = 1;
      _isLoading = true;
      _isInitialLoad = false; // Mark that initial load is complete
      searchText = _searchController.text;
    });
    _fetchLocations(_currentPage);
  }

  // Load the previous page of results
  void _loadPrevious() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        _isLoading = true;
      });
      _fetchLocations(_currentPage);
    }
  }

  // Load the next page of results
  void _loadNext() {
    if (_hasMore) {
      setState(() {
        _currentPage++;
        _isLoading = true;
      });
      _fetchLocations(_currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _isLoading = true;
        });
        _fetchLocations(_currentPage);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                ),
                // Search Text Field
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _searchController,
                    keyboardType: TextInputType.name,
                    onEditingComplete: _startSearch, // Start search on Enter key
                    style: TextStyle(
                      color: ColorConstants.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      fillColor: ColorConstants.searchfield,
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      hintText: 'Search......',
                      suffixIcon: GestureDetector(
                        onTap: _startSearch,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: ColorConstants.primaryColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: Icon(Icons.search,
                                color: ColorConstants.whiteColor, size: 25),
                          ),
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                            color: ColorConstants.bordercolor, width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Divider(color: Color(0xff747474), thickness: 1, height: 2),
                SizedBox(height: 3.h),
          
                // List of Results or Loading Indicator
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : (!_isInitialLoad && data.isEmpty)
                        ? Center(
                            child: Lottie.asset(
                                'assets/lottie/nolocationfound.json',
                                height: 150),
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                 
                                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchFilterViewDetails(
                                          id: '${data[index]['id']}')),
                                );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstants.bgcolor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
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
                                                0.17,
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
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.network(
                                                            'https://vevarealty.com/images_uploades/${data[index]['image']}',
                                                            fit: BoxFit.cover,
                                                          ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${data[index]['title']}',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: ColorConstants
                                                      .secondaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                '${data[index]['proPrice']}${data[index]['areaType']}',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: ColorConstants
                                                      .secondaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
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
                                              SizedBox(width: 1.w),
                                              Text(
                                                '${data[index]['area_title']}, ${data[index]['city_name']}',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: ColorConstants
                                                      .secondaryColor,
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: _loadPrevious,
                      icon: Icon(Icons.arrow_left, color: Colors.black, size: 25),
                    ),
                    Text(
                      '${_currentPage.toString()}',
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorConstants.textcolor,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: _loadNext,
                      icon:
                          Icon(Icons.arrow_right, color: Colors.black, size: 25),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
