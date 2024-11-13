import 'dart:convert';

import 'package:commercilapp/Authenticationscreens/loginscreen.dart';
import 'package:commercilapp/constant/apiconstant.dart';
import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:commercilapp/homepage/model.dart';
import 'package:commercilapp/homepage/recomendedlist.dart';
import 'package:commercilapp/homepage/subcategory.dart';
import 'package:commercilapp/models/recomendedmodel.dart';
import 'package:commercilapp/profile/profile.dart';
import 'package:commercilapp/providers/categoryprovider.dart';
import 'package:commercilapp/providers/storage%20categoryprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../models/categorylistmodel.dart';
import '../models/recentlyadedmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  List<RecentlyAded>? _recentlyAddedList;

  List<Categories> _categories = [];
  List<dynamic> recommendedProperties = [];
  bool _isLoading = true;
  bool isloader = true;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> fetchRecommendedProperties() async {
    final url = "${BaseUrl}api-recommended-prop-list.php";
   

    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      // Print each property from the API response
      for (var property in data) {
      
      }

      setState(() {
        recommendedProperties = data;
      });
 
    } else {
      throw Exception('Failed to load properties');
    }
  }

  // Fetch categories data and update the UI
  Future<void> _loadCategories() async {
    try {
      final categories = await CategoriesProvider().fetchCategories();
      setState(() {
        _categories = categories;
        _isLoading = false; // Hide the loading indicator
      });
     
      _fetchData();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
   
    }
  }

  void _fetchData() async {
    final response = await http.get(Uri.parse('${BaseUrl}api-list-page.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _recentlyAddedList =
            data.map((json) => RecentlyAded.fromJson(json)).toList();
        _isLoading = false;
      });
      fetchRecommendedProperties();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: ColorConstants.whiteColor,
            title: Text('Are you sure?',
                style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            content: Text('Do you want to quit the app?',
                style: GoogleFonts.plusJakartaSans(
                    color: ColorConstants.secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No',
                    style: GoogleFonts.plusJakartaSans(
                        color: ColorConstants.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  ); // Replace with your actual login page route
                },
                child: Text('Yes',
                    style: GoogleFonts.plusJakartaSans(
                        color: ColorConstants.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ) ??
        false;
  }

  List<String> categiries = [
    'Office Space',
    'Rental Space',
    'Coworking Space',
    'Work Space',
    'Industrial Park'
  ];
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_recentlyAddedList == null || _recentlyAddedList!.isEmpty) {
      return Center(child: Text('No data found'));
    }

    final RecentlyAded recentlyAdded = _recentlyAddedList![0];

    var image = recentlyAdded.image.toString();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _isLoading = true;
            });
            _loadCategories();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        ImageConstants.COMMERCIALPAL,
                        height: 24,
                        width: 150,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFf4f4f4),
                          radius: 15,
                          backgroundImage: AssetImage(ImageConstants.PERSON),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('What are you',
                          style: GoogleFonts.plusJakartaSans(
                              color: ColorConstants.secondaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                            color: ColorConstants.redcolor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text('Looking',
                            style: GoogleFonts.plusJakartaSans(
                                color: ColorConstants.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text('for',
                          style: GoogleFonts.plusJakartaSans(
                              color: ColorConstants.secondaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 300,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3,
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 4.0, // Spacing between columns
                          mainAxisSpacing: 4.0, // Spacing between rows
                        ),
                        itemCount:
                            _categories.length, // Number of items in the grid

                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                           
                              String title =
                                  _categories[index].listTitle.toString() ?? '';
                              String id =
                                  _categories[index].id.toString() ?? '';

                              // Update the provider with selected data
                              Provider.of<CategoryProvider>(context,
                                      listen: false)
                                  .setSelectedCategory(title, id);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubCategory(
                                    listTitle: title,
                                    catid: id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: _selectedIndex == index
                                      ? ColorConstants.primaryColor
                                      : ColorConstants.whiteColor,
                                  border: Border.all(
                                      color: _selectedIndex == index
                                          ? ColorConstants.primaryColor
                                          : ColorConstants.bordercolor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                    _categories[index].listTitle.toString() ??
                                        '',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.plusJakartaSans(
                                        color: _selectedIndex == index
                                            ? ColorConstants.whiteColor
                                            : ColorConstants.secondaryColor,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ColorConstants.bordercolor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorConstants.bordercolor, width: 1)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Recently Added',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: ColorConstants.secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecomendedList()),
                                  );
                                }),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: ColorConstants.primaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text('See All',
                                      style: GoogleFonts.plusJakartaSans(
                                          color: ColorConstants.whiteColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              width: double.infinity,
                              child: recentlyAdded.image == null
                                  ? Image.network(
                                      'https://img.freepik.com/premium-photo/modern-city-with-wireless-network-connection-generative-ai_887552-4865.jpg',
                                    )
                                  : Image.network(
                                      'https://vevarealty.com/images_uploades/$image'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(recentlyAdded.title ?? 'No Title',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: ColorConstants.secondaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                              Text(
                                  '${recentlyAdded.proPrice ?? ''}' +
                                      '${recentlyAdded.areaType ?? ''}',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: ColorConstants.secondaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Image.asset(
                                ImageConstants.LOCATION,
                                height: 15,
                                color: ColorConstants.primaryColor,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recommended',
                            style: GoogleFonts.plusJakartaSans(
                                color: ColorConstants.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          decoration: BoxDecoration(
                              color: ColorConstants.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text('See All',
                              style: GoogleFonts.plusJakartaSans(
                                  color: ColorConstants.whiteColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      height: MediaQuery.of(context).size.height *
                          0.27, // 35% of the screen height
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        itemCount: recommendedProperties?.length,
                        itemBuilder: (BuildContext context, int index) {
                          var recommended = recommendedProperties![index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width *
                                  0.62, // 62% of the screen width
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorConstants.bgcolor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.17, // 22% of the screen height
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Container(
                                          width: double.infinity,
                                          child: recommended['image'] == null
                                              ? Image.network(
                                                  'https://img.freepik.com/premium-photo/modern-city-with-wireless-network-connection-generative-ai_887552-4865.jpg',
                                                  fit: BoxFit
                                                      .cover, // Fit image to container while keeping aspect ratio
                                                )
                                              : Image.network(
                                                  'https://vevarealty.com/images_uploades/${recommended['image']}',
                                                  fit: BoxFit
                                                      .cover, // Ensures the image covers the available space
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10), // Static spacing
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      '${recommended['title']}',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: ColorConstants.secondaryColor,
                                        fontSize: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.03, // 3% of the screen width for responsive text size
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5), // Static spacing
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageConstants.LOCATION,
                                          height:
                                              15, // Static size for the icon
                                          color: ColorConstants.primaryColor,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01), // 1% of the screen width for responsive spacing
                                        Text(
                                          '${recommended['area_title']}, ${recommended['cyti']}',
                                          style: GoogleFonts.plusJakartaSans(
                                            color:
                                                ColorConstants.secondaryColor,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.025, // 2.5% of the screen width for responsive text size
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5), // Static spacing
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
                              color: ColorConstants.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400))),
                  SizedBox(
                    height: 3.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
