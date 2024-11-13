import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart' as ca;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';
import 'package:commercilapp/homepage/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

//model of  carousel sliuders

class Property {
  final String imageAsset;
  final String value;
  final String label;
  final Color color;

  Property({
    required this.imageAsset,
    required this.value,
    required this.label,
    required this.color,
  });
}

// Import the html parser

class PropertyView extends StatefulWidget {
  

  @override
  State<PropertyView> createState() => _PropertyViewState();
}

class _PropertyViewState extends State<PropertyView> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.77483, -122.41942);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // final CarouselController _controller = CarouselController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _yournameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailidController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  int _current = 0;
  Dummy? dummy;
  String? jsonOutput;
  String? jsonOutputSpaceoffered;
  String? imglst;
  List<Map<String, String>> propertyDetails = [];
  List<Map<String, String>> spaceoffered = [];
  double? latitude;
  double? longitude;
  String? areaoffered;
  String? floorsoffered;
  String? status;
  String? power;
  String? poserbackup;
  String? carparking;
  String? timeline;

  @override
  void initState() {
    super.initState();
    fetchDummyData();
  }

  void convertHtmlToJsonCombined() {
    // Convert commercialDetails HTML to JSON
    String htmlContent = '${dummy?.commercialDetails ?? ''}';
    var document = parse(htmlContent);

    List<Map<String, String>> tempPropertyDetails = [];
    var aboutProperties = document.getElementsByClassName('about-property');
    for (var aboutProperty in aboutProperties) {
      var sections = aboutProperty.getElementsByClassName('abt-p-sec');
      for (var section in sections) {
        var title = section.getElementsByTagName('h3')[0].text;
        var value = section.getElementsByTagName('h2')[0].text;
        tempPropertyDetails.add({title: value});
      }
    }

    String jsonOutputCommercial = jsonEncode(tempPropertyDetails);

    // Convert spaceOffered HTML to JSON
    String htmlContentSpaceOffered = '${dummy?.spaceOffered ?? ''}';
    var documentSpaceOffered = parse(htmlContentSpaceOffered);

    List<Map<String, String>> spaceOfferedDetails = [];
    var aboutPropertySpace =
        documentSpaceOffered.getElementsByClassName('about-property');
    for (var aboutProperty in aboutPropertySpace) {
      var sections = aboutProperty.getElementsByClassName('abt-p-sec');
      for (var section in sections) {
        var title = section.getElementsByTagName('h3')[0].text;
        var value = section.getElementsByTagName('h2')[0].text;
        spaceOfferedDetails.add({title: value});
      }
    }

    String jsonOutputSpaceOffered = jsonEncode(spaceOfferedDetails);

    // Update state with both results
    setState(() {
      propertyDetails = tempPropertyDetails;
      jsonOutput = jsonOutputCommercial;
      spaceoffered = spaceOfferedDetails;
      jsonOutputSpaceoffered = jsonOutputSpaceOffered;
    });

    print(propertyDetails.toString() + '>>>>>>>>>>>>>>>>');
    print(jsonOutput.toString() + '>>>>>>>');
    print(spaceoffered.toString() + '>>>>>>>');
    print(jsonOutputSpaceoffered.toString() + '>>>>>>>');
    print('${dummy?.locationset ?? ''}' + ' have a nice day');
  }

  void fetchDummyData() async {
    final url = 'https://mycommercialpal.com/api-detail-page.php?id=1';
    print(url.toString());
    final response = await http.get(Uri.parse(
        url));
        print(response.statusCode);
        print(response.request);
        print(response.toString());
        print(response.body.toString());
      

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final decodedJsonData = decodeHtmlEntities(jsonData);

      print(decodedJsonData.toString()+';;;;;;;;;;;;;>>>>>>>>>>>>>>>>>>>>>>>>');
      setState(() {
        dummy = Dummy.fromJson(decodedJsonData);
        imglst = 'https://vevarealty.com/images_uploades/${dummy?.image}';
        areaoffered = '${dummy?.areaoffered ?? ''}';
        floorsoffered = '${dummy?.floorsoffered ?? ''}';
        status = '${dummy?.status ?? ''}';
        power = '${dummy?.power ?? ''}';
        poserbackup = '${dummy?.powerbackup ?? ''}';
        carparking = '${dummy?.carparking ?? ''}';
        timeline = '${dummy?.timeline ?? ''}';
        print(imglst.toString());
        print(dummy.toString());
        print(dummy?.id.toString());
        print(dummy?.title.toString());
        print(dummy?.image.toString());
        print(dummy?.areaType.toString());
        print(dummy?.areaTitle.toString());

        // Split locationset into latitude and longitude
        if (dummy?.locationset != null) {
          var locationParts = dummy!.locationset!.split(',');
          if (locationParts.length == 2) {
            latitude = double.tryParse(locationParts[0].trim());
            longitude = double.tryParse(locationParts[1].trim());
          }
        }

        convertHtmlToJsonCombined();
        // covertHtnlToJsonSpaceOffered(); // Call the convertHtmlToJson function inside setState
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Map<String, dynamic> decodeHtmlEntities(Map<String, dynamic> jsonData) {
    final unescape = HtmlUnescape();
    return jsonData.map((key, value) {
      if (value is String) {
        return MapEntry(key, unescape.convert(value));
      } else if (value is Map) {
        return MapEntry(key, decodeHtmlEntities(value.cast<String, dynamic>()));
      } else if (value is List) {
        return MapEntry(
            key,
            value.map((item) {
              if (item is String) {
                return unescape.convert(item);
              } else if (item is Map) {
                return decodeHtmlEntities(item.cast<String, dynamic>());
              }
              return item;
            }).toList());
      }
      return MapEntry(key, value);
    });
  }

  // Scroll of distance
  final ScrollController _scrollController = ScrollController();
  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final List<String> imgList = [
    'https://vevarealty.com/images_uploades/1707832143Golf-Edge-Commercial-01.png',
    'https://vevarealty.com/images_uploades/1707832143Golf-Edge-Commercial-01.png',
    'https://vevarealty.com/images_uploades/1707832143Golf-Edge-Commercial-01.png',
  ];
  @override
  Widget build(BuildContext context) {
    final List<Property> properties = [
      Property(
        imageAsset: ImageConstants.DISTANCEBD,
        value: '${dummy?.distanceCbd ?? ''}',
        label: 'Distance CBD',
        color: Color(0xFFFFD6D6),
      ),
      Property(
        imageAsset: ImageConstants.DISTANCEFROMPLAIN,
        value: '${dummy?.distanceAirport ?? ''}',
        label: 'Distance from International Airport',
        color: Color(0xFFFFFDCC),
      ),
      Property(
        imageAsset: ImageConstants.AREADISTANCE,
        value: '${dummy?.builtUpArea ?? ''}',
        label: 'Super built up area in sq.ft',
        color: Color(0xFFB6E5FF),
      ),
      Property(
        imageAsset: ImageConstants.APPROXTIME,
        value: '${dummy?.floorPlateSize ?? ''}',
        label: 'Approx. Floor plate size in sq.ft',
        color: Color(0xFFCFFFE2),
      ),
      Property(
        imageAsset: ImageConstants.STLITDISTANCE,
        value: '${dummy?.building ?? ''}',
        label: 'Building',
        color: Color(0xFFFFD5D6),
      ),
      Property(
        imageAsset: ImageConstants.EFFECIENCY,
        value: '${dummy?.efficiency ?? ''}',
        label: 'Efficiency',
        color: Color(0xFFFFFDCC),
      ),
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 3 : 2;
    double childAspectRatio = 3 / 1.2;

    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //images sliders
            Stack(
              alignment: Alignment.center,
              children: [
                CarouselSlider(
                  items: imgList.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 8.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _current = (_current - 1) % imgList.length;
                      });
                    },
                  ),
                ),
                Positioned(
                  right: 8.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _current = (_current + 1) % imgList.length;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 8.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _current = entry.key;
                          });
                        },
                        child: Container(
                          width: 5.0,
                          height: 5.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == entry.key
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${dummy?.title ?? ''}',
                  style: GoogleFonts.plusJakartaSans(
                      color: ColorConstants.secondaryColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '₹' + '${dummy?.proPrice ?? ''}' + '${dummy?.areaType ?? ''}',
                  style: GoogleFonts.plusJakartaSans(
                      color: ColorConstants.secondaryColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Image.asset(
                    ImageConstants.LOCATION,
                    height: 15,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text('${dummy?.areaTitle ?? ''}',
                      style: GoogleFonts.plusJakartaSans(
                          color: ColorConstants.secondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),

            //distance slider
            Stack(
              children: [
                Container(
                  height: 150,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final property = properties[index];
                      return Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: index == 1
                                        ? 10
                                        : index == 3
                                            ? 10
                                            : index == 4
                                                ? 0
                                                : index == 5
                                                    ? 12
                                                    : 6),
                                decoration: BoxDecoration(
                                  color: property.color,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      property.imageAsset,
                                      height: 25,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      property.value,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  property.label,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 90,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: ColorConstants.secondaryColor,
                      size: 20,
                    ),
                    onPressed: _scrollLeft,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 90,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorConstants.secondaryColor,
                      size: 20,
                    ),
                    onPressed: _scrollRight,
                  ),
                ),
              ],
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

            //Details for sponsred
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
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Details of the Space Offered',
                    style: GoogleFonts.plusJakartaSans(
                      color:
                          Color(0xFF333333), // Replace with your color constant
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Add spacing between text and GridView
                  spaceoffered == null
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Area offered [in Sq.ft]',
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontSize: 7.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text('${dummy?.areaoffered.toString()}')
                                    ],
                                  ),
                                  Text(
                                    'Floors offered',
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.black,
                                        fontSize: 7.sp,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: spaceoffered.length,
                            itemBuilder: (context, index) {
                              var item = spaceoffered[index];
                              var title = item.keys.first;
                              var value = item[title];
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title.toString(),
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Color(0xFF333333),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    value.toString(),
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Add spacing between containers

            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Commercial Details',
                    style: GoogleFonts.plusJakartaSans(
                        color: ColorConstants.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 3 / 1.7,
                      ),
                      itemCount: propertyDetails.length,
                      itemBuilder: (context, index) {
                        var item = propertyDetails[index];
                        var title = item.keys.first;
                        var value = item[title];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title.toString(),
                              style: GoogleFonts.plusJakartaSans(
                                color: Color(0xFF333333),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Expanded(
                              child: Text(
                                value.toString(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  color: Color(0xFF333333),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),

            //Agent Name & Details
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
                      Text('+91${dummy?.snum ?? ''}',
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
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: '+91${dummy?.snum ?? ''}',
                      );
                     
                      try {
                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                        
                        }
                      } catch (e) {
                      
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
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
              height: 3.h,
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
                  Text(
                    'Drop an Enquiry',
                    style: GoogleFonts.plusJakartaSans(
                        color: ColorConstants.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Enquiry sending sucessfully')),
                        );
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

    print('Latitude: $latitude');
    print('Longitude: $longitude');

    // Construct Google Maps URL
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
