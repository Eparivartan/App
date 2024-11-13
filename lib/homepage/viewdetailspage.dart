import 'dart:convert';
import 'package:commercilapp/constant/apiconstant.dart';
import 'package:commercilapp/models/citymodellist.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart' as htmlParser; // Import the html parser

import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:commercilapp/models/viewpropertymodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewDetailsPage extends StatefulWidget {
  final id;
  const ViewDetailsPage({super.key, required this.id});

  @override
  State<ViewDetailsPage> createState() => _ViewDetailsPageState();
}

class _ViewDetailsPageState extends State<ViewDetailsPage> {
  String? img;
  bool isLoading = true;
  String? errorMessage;
  viewproperty? propertyDetails;
  List<Map<String, String>> additionalDetails = [];
  List<Map<String, String>> spacesofferedvalue = [];
  List<Map<String, String>> cemercialdetailvalue = [];
  String? areaTitle;
  String? proPrice;
  String? areaType;
  String? title; // Added for the title
  String? id;
  String? cityname;
   int _currentIndex = 0;
  final PageController _pageController = PageController();

  List<Map<String, String>> commercialDetails = []; // Store commercial details
  List<Map<String, String>> spaceOfferedDetails = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _yournameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailidController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController =
      ScrollController(); // ScrollController for ListView

  List<Color> colorList = [
    Color(0xffFFD6D6),
    Color(0xffFFFFFDCC),
    Color(0xffFFB6E5FF),
    Color(0xffCFFFE2),
    Color(0xffFFD5D6),
    Color(0xffFFFDCC)
  ];
  int currentimgindex = 0; // Track the current index

  @override
  void initState() {
    super.initState();
   
    fetchApiData();
  }

  Future<void> fetchApiData() async {
    try {
      final response = await http.get(Uri.parse(
          '${BaseUrl}api-detail-page.php?id=${widget.id.toString()}'));
    

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        

        setState(() {
          img = data['image'];
          id = data['id'];

          proPrice = data['proPrice'] ?? 'No data available';
          areaType = data['areaType'] ?? 'No data available';
          title = data['title'] ?? 'No data available'; // Assign title value
          areaTitle = data['area_title'] ?? 'No area_title available';
          cityname = data['city_name'] ?? 'No city_name available';

         
          final commercialDetailsHtml = data['CommercialDetails'];
          final documentCommercial = htmlParser.parse(commercialDetailsHtml);
          final elementsCommercial =
              documentCommercial.getElementsByClassName('abt-p-sec');

          // Extract the details from the parsed HTML and store in the commercialDetails list
          commercialDetails = elementsCommercial.map((element) {
            final h3 = element.getElementsByTagName('h3').first.text.trim();
            final h2 = element.getElementsByTagName('h2').first.text.trim();
            return {'label': h3, 'value': h2};
          }).toList();

          // Parse SpaceOffered HTML
          final spaceOfferedHtml = data['SpaceOffered'];
          final documentSpaceOffered = htmlParser.parse(spaceOfferedHtml);
          final elementsSpaceOffered =
              documentSpaceOffered.getElementsByClassName('abt-p-sec');

          // Extract the details from the parsed HTML and store in the spaceOfferedDetails list
          spaceOfferedDetails = elementsSpaceOffered.map((element) {
            final h3 = element.getElementsByTagName('h3').first.text.trim();
            final h2 = element.getElementsByTagName('h2').first.text.trim();
            return {'label': h3, 'value': h2};
          }).toList();

          // Populate additional details
          additionalDetails = [
            {'label': 'Distance CBD', 'value': data['distance_cbd'] ?? ''},
            {
              'label': 'Distance from International Airport ',
              'value': data['distance_airport'] ?? ''
            },
            {
              'label': 'Super built up area in sq.ft',
              'value': data['built_up_area'] ?? ''
            },
            {
              'label': 'Approx.Floor plate size in sq.ft',
              'value': data['floor_plate_size'] ?? ''
            },
            {'label': 'Building', 'value': data['building'] ?? ''},
            {'label': 'Efficiency', 'value': data['efficiency'] ?? ''},
          ];

          // space offered list
          spacesofferedvalue = [
            {
              'label': 'Area offered [in Sq.ft]',
              'value': data['areaoffered'] ?? ''
            },
            {'label': 'Floors offered', 'value': data['floorsoffered'] ?? ''},
            {'label': 'status', 'value': data['offeredstatus'] ?? ''},
            {'label': 'Power', 'value': data['power'] ?? ''},
            {'label': 'Power back up', 'value': data['powerbackup'] ?? ''},
            {'label': 'Car parking', 'value': data['carparking'] ?? ''},
            {
              'label': 'Timeline [For occupation / \nCommencement of fit outs]',
              'value': data['timeline'] ?? ''
            },
          ];

        
          cemercialdetailvalue = [
            {'label': 'Lease tenure', 'value': data['leaseltenure'] ?? ''},
            {'label': 'Lock in Period', 'value': data['lockPeriod'] ?? ''},
            {
              'label': 'Notice period for termination',
              'value': data['noticeperiod'] ?? ''
            },
            {
              'label': 'Quoted rental rates',
              'value':
                  '${data['quotedrentalratesINR'] ?? ''}${data['quotedrentalratesSF'] ?? ''}'
            },
            {
              'label': 'Car parking',
              'value':
                  '${data['carparkchargesINR'] ?? ''}${data['carparkchargesSlot'] ?? ''}'
            },
            {'label': 'Rent escalation', 'value': data['rentescalation'] ?? ''},
            {
              'label': 'Security deposit [IFRSD]',
              'value': data['securitydeposit'] ?? ''
            },
            {'label': 'Taxes', 'value': data['taxes'] ?? ''},
            {'label': 'Other charges', 'value': data['othercharges'] ?? ''},
          ];
        

          propertyDetails = data;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset -
          200, // Adjust the value to control the scroll distance
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset +
          200, // Adjust the value to control the scroll distance
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // property detail viewlist images
  List<String> imglstfor = [
    ImageConstants.DISTANCEBD,
    ImageConstants.DISTANCEFROMPLAIN,
    ImageConstants.AREADISTANCE,
    ImageConstants.APPROXTIME,
    ImageConstants.STLITDISTANCE,
    ImageConstants.EFFECIENCY
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'https://vevarealty.com/images_uploades/${img.toString()}',
      'https://vevarealty.com/images_uploades/${img.toString()}',
      'https://vevarealty.com/images_uploades/${img.toString()}',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Carousel for images
              
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                  ),
                  items: imageList.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(item,
                            fit: BoxFit.cover, width: double.infinity);
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 0.5.h),

              // Property title and price
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title ?? 'No title available', // Displaying the title
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${proPrice ?? 'No area type available'}${areaType ?? 'No area type available'}', // Displaying the area type
                          style: GoogleFonts.plusJakartaSans(
                            color: Color(0xff000000),
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      '${areaTitle ?? 'No title available'}${cityname ?? 'No title available'}', // Displaying the title
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorConstants.secondaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),

              // Horizontal ListView for additional details
              Container(
                height: MediaQuery.of(context).size.height *
                    0.12, // Adjusted height based on screen height
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Left arrow button
                    IconButton(
                      onPressed: scrollLeft, // Scroll left
                      icon: Icon(Icons.arrow_back),
                    ),

                    // Horizontal list
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          controller:
                              _scrollController, // Attach controller to ListView
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: additionalDetails.length,
                          itemBuilder: (context, index) {
                            final item = additionalDetails[index];

                            // Get screen width for responsiveness
                            double screenWidth =
                                MediaQuery.of(context).size.width;

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screenWidth *
                                        0.20, // 20% of the screen width
                                    decoration: BoxDecoration(
                                      color: colorList[index],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01, // Responsive height
                                        ),
                                        Image.asset(
                                          imglstfor[index],
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03, // Adjusted image height
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02, // Responsive height for spacing
                                        ),
                                        Text(
                                          item['value']!,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: GoogleFonts.plusJakartaSans(
                                            color:
                                                ColorConstants.secondaryColor,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03, // Responsive font size
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        )
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.height *
                                  //       0.01, // Spacing between container and label
                                  // ),
                                  Container(
                                    width: screenWidth *
                                        0.25, // Ensure same width for label
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          item['label']!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.plusJakartaSans(
                                            color:
                                                ColorConstants.secondaryColor,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.020, // Responsive font size
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Right arrow button
                    IconButton(
                      onPressed: scrollRight, // Scroll right
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: _launchURL,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageConstants.MAP),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              //Card for google maps

              SizedBox(
                height: 1.5.h,
              ),

              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.7.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Space Offered',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.black),
                      ),
                    ),
                    spaceOfferedDetails.isEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  3 / 1.4, // Adjust to your design

                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: spacesofferedvalue.length,
                            itemBuilder: (context, index) {
                              final item = spacesofferedvalue[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        item['label']!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      item['value']!,
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.grey[700],
                                          fontSize: 7.sp),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  3 / 1.4, // Adjust to your design

                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: spaceOfferedDetails.length,
                            itemBuilder: (context, index) {
                              final item = spaceOfferedDetails[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        item['label']!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      item['value']!,
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.grey[700],
                                          fontSize: 7.sp),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.7.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Commercial Details',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.black),
                      ),
                    ),
                    commercialDetails.isEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  3 / 1.4, // Adjust to your design

                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: cemercialdetailvalue.length,
                            itemBuilder: (context, index) {
                              final item = cemercialdetailvalue[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        item['label']!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Expanded(
                                      child: Text(
                                        item['value']!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.grey[700],
                                            fontSize: 7.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  3 / 1.4, // Adjust to your design

                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: commercialDetails.length,
                            itemBuilder: (context, index) {
                              final item = commercialDetails[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        item['label']!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Expanded(
                                      child: Text(
                                        item['value']!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.grey[700],
                                            fontSize: 7.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                    SizedBox(
                      height: 2.h,
                    ),

                    //Agent Name & Details
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('Agent Name',
                            style: GoogleFonts.plusJakartaSans(
                                color: ColorConstants.secondaryColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        propertyDetails?.snum == ''
                            ? Container()
                            : Text(
                                '+91${propertyDetails?.snum ?? '919831501086'}',
                                style: GoogleFonts.plusJakartaSans(
                                    color: ColorConstants.secondaryColor,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        const phoneNumber =
                            'tel:+919831501086'; // Replace with the phone number you want to call
                        if (await canLaunch(phoneNumber)) {
                          await launch(
                              phoneNumber); // Opens the dialer with the phone number
                            
                        } else {
                          throw 'Could not launch $phoneNumber';
                        }
                      },
                    
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Contact Now',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              color: ColorConstants.whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Drop an Enquiry',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.plusJakartaSans(
                            color: ColorConstants.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    yourname(),
                    SizedBox(
                      height: 2.h,
                    ),
                    phonenumber(),
                    SizedBox(
                      height: 2.h,
                    ),
                    emailtextfield(),
                    SizedBox(
                      height: 2.h,
                    ),
                    message(),
                    SizedBox(
                      height: .2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //       content: Text('Enquiry sending sucessfully')),
                          // );
                        
                          _enquiryform();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text('Submit',
                              style: GoogleFonts.plusJakartaSans(
                                  color: ColorConstants.whiteColor,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: .2.h,
                    ),
                  ],
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
                          decoration: TextDecoration.underline,
                          color: ColorConstants.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700))),

              SizedBox(
                height: 3.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget message() {
    return Container(
      child: SizedBox(
        height: 100,
        child: TextFormField(
          controller: _messageController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Message';
            } else {
              return null;
            }
          },
          style: TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            fillColor: ColorConstants.whiteColor,
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            hintText: 'Message',
            hintStyle: TextStyle(
                color: ColorConstants.textcolor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide:
                    BorderSide(color: ColorConstants.bordercolor, width: 1)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide:
                    BorderSide(color: ColorConstants.bordercolor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide:
                    BorderSide(color: ColorConstants.bordercolor, width: 1)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide:
                    BorderSide(color: ColorConstants.bordercolor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide:
                    BorderSide(color: ColorConstants.bordercolor, width: 1)),
          ),
        ),
      ),
    );
  }

  Widget emailtextfield() {
    return Container(
      child: TextFormField(
        controller: _emailidController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          // Define a regular expression for validating an email
          String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Email ID',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
        ),
      ),
    );
  }

  Widget phonenumber() {
    return Container(
      child: TextFormField(
        controller: _phonenumberController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your phone number';
          }
          if (value.length != 10) {
            return 'Phone number must be 10 digits';
          }
          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
          return null;
        },
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Phone No.',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
        ),
      ),
    );
  }

  Widget yourname() {
    return Container(
      child: TextFormField(
        controller: _yournameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your name';
          } else {
            return null;
          }
        },
        style: TextStyle(
          color: ColorConstants.textcolor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: 'Your Name',
          hintStyle: TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide:
                  BorderSide(color: ColorConstants.bordercolor, width: 1)),
        ),
      ),
    );
  }

  void _launchURL() async {
    const iframeUrl =
        'https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d861.2265615621785!2d78.3463395!3d17.4240057!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bcb913572d58f8b%3A0xa6b7828ea4641aa2!2sGolf%20Edge%20Residence!5e1!3m2!1sen!2sin!4v1707392437308!5m2!1sen!2sin';

    // Extract latitude and longitude
    Uri uri = Uri.parse(iframeUrl);
    String params = uri.queryParameters['pb'] ?? '';
    List<String> paramsList = params.split('!');
    String latitude = paramsList
        .firstWhere((element) => element.startsWith('3d'))
        .substring(2);
    String longitude = paramsList
        .firstWhere((element) => element.startsWith('2d'))
        .substring(2);


    // Construct Google Maps URL
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  Future<void> _enquiryform() async {
    final dio = Dio();

    final String url = 'https://mycommercialpal.com/api-enquiry.php';

  

    final Map<String, dynamic> requestData = {
      "name": _yournameController.text,
      "email": _emailidController.text,
      "phone": _phonenumberController.text,
      "msg": _messageController.text,
      "getpropid": id.toString()
    };

    try {
      final response = await dio.post(url, data: requestData);
    
      if (response.statusCode == 200) {
        final data = response.data;
      
        Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        _yournameController.clear();
        _emailidController.clear();
        _phonenumberController.clear();
        _messageController.clear();
      } else {
        Fluttertoast.showToast(
          msg: 'Enquiry not send sucessfully !',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
     e.toString();
    }
  }
}
