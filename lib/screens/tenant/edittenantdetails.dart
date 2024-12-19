// ignore_for_file: prefer_const_constructors, deprecated_member_use, duplicate_ignore, non_constant_identifier_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TenantEditPage extends StatefulWidget {
  
  final tenantresponse;
  const TenantEditPage({super.key, required this.tenantresponse});

  @override
  State<TenantEditPage> createState() => _TenantEditPageState();
}

class _TenantEditPageState extends State<TenantEditPage> {
  @override
  // ignore: override_on_non_overriding_member
  String? image;
  String? profileimage;
  String? tenantName;
  String? tenantEmail;
  String? tenantPhone;
  int? totalMembers;
  String? address;
  String? tenantId;
  String? propertyName;
  String? unitName;
  String? leaseStartDate;
  String? leaseEndDate;
  List<dynamic> list1Documents = [];
  List<dynamic> list2Documents = [];
  List<dynamic> list3Documents = [];
  String? propertyId;
  String? uitid;
  String? unitId;
  String? propid;
   bool _isLoading = false;
  List<dynamic> propertyTypes = [];
  List<dynamic> unitList = [];

  String? selectedPropertyId;
  String? selectedUnitValue; // Stores the selected propertyId
  bool isLoading = true;
  String? errorMessage;
  String? uniterror; //uploadeddocuments
  String? imgid;
  String? imgidstart;
  String? imgidend;

  List<String> uploadeddocs = [];
  List<String>  uploadstartimages = [];
  List<String> uploadendimageslist = [];

  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _emailtenant = TextEditingController();
  final TextEditingController _phonenumbertenant = TextEditingController();
  final TextEditingController _totalnumbers = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipcode = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource
          .gallery, // You can change it to ImageSource.camera for camera
    );

    if (pickedFile != null) {
      setState(() {
        profileimage = pickedFile.path; // Store the file path of the image
      });
    }
  }

  void remove(int index) {
    setState(() {
      uploadstartimages.removeAt(index); // Remove the file at the specified index
    });
  }

  void removeend(int index) {
    setState(() {
      uploadendimageslist.removeAt(index); // Remove the file at the specified index
    });
  }



  void removeFile(int index) {
    setState(() {
      uploadeddocs.removeAt(index); // Remove the file at the specified index
    });
  }

  Future<void> pickFileOption() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // You can use any file picker package

    if (pickedFile != null) {
      setState(() {
       
        uploadeddocs.add(pickedFile.path); // Add the file path to the list
      });
    
    }
  }


  Future<void> startimglist() async {
     final picker = ImagePicker();
       final pickedFile = await picker.pickImage(
        source: ImageSource.camera); // You can use any file picker package
         if (pickedFile != null) {
      setState(() {
       
        uploadstartimages.add(pickedFile.path); // Add the file path to the list
      });
    
    }

  }

  Future<void> endimglist() async{
      final picker = ImagePicker();
       final pickedFile = await picker.pickImage(
        source: ImageSource.camera);
        if(pickedFile != null){
          setState(() {
            
            uploadendimageslist.add(pickedFile.path);
          });
        }
  }

  String? validateEmail(String? value) {
    // Regular expression for validating email addresses
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null; // No error
  }
//removedoclistpopup
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            GestureDetector(
                    onTap: () {
                      // createtenant();
                      deleteTenantImage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 16),
                      decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'ok',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.whiteColor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }

  //removestartimglistpopup

  void _showDeleteStartimgDialog(BuildContext context) {
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            GestureDetector(
                    onTap: () {
                 
                      deleteTenantstartImagelist();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 16),
                      decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'ok',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.whiteColor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }


  //removeendimglistpopup
  void _showDeleteEndimgDialog(BuildContext context) {
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            GestureDetector(
                    onTap: () {
                 
                     deleteTenantendImagelist();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 16),
                      decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'ok',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.whiteColor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    loadTenantData();
    super.initState();
  }

  Future<void> loadTenantData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      image = widget.tenantresponse?['Image'];
      _firstname.text = widget.tenantresponse?['tenantFisrtName'];
      _lastname.text = widget.tenantresponse?['tenantLastName'];
      _emailtenant.text = widget.tenantresponse?['tenantEmail'];
      _phonenumbertenant.text = widget.tenantresponse?['tenantPhone'];
      _totalnumbers.text = widget.tenantresponse?['totalMembers'];
      _address.text = widget.tenantresponse?['address'];
      _city.text = widget.tenantresponse?['cityName'];
      _country.text = widget.tenantresponse?['country'];
      _state.text = widget.tenantresponse?['state'];
      _zipcode.text = widget.tenantresponse?['zidcode'];
      tenantId = widget.tenantresponse?['tenantId'];
      propertyName = widget.tenantresponse?['propertyName'];
      unitName = widget.tenantresponse?['unitName'];
      _startDateController.text = widget.tenantresponse?['leasestartdate'];
      _endDateController.text = widget.tenantresponse?['leaseenddate'];
      // list1Documents = jsonDecode(prefs.getString('list1Documents') ?? '[]');
      // list2Documents = jsonDecode(prefs.getString('list2Documents') ?? '[]');
      // list3Documents = jsonDecode(prefs.getString('list3Documents') ?? '[]');
      propertyId = widget.tenantresponse?['propertyId'];
      uitid = widget.tenantresponse?['uitid'];
    });

    final documents =
        widget.tenantresponse?['documents'] as Map<String, dynamic>?;

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
    fetchProperties();
  }

  Future<void> fetchProperties() async {
    final token =
        Provider.of<TokenProvider>(context, listen: false).accessToken;
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/getproperties/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['allproperties'] != null && data['allproperties'] is List) {
          setState(() {
            propertyTypes = data['allproperties'];
            selectedPropertyId = propertyTypes.isNotEmpty
                ? propertyTypes[0]['propertyId'].toString()
                : null; // Default selection
            isLoading = false;
          });
          selectedPropertyId == null
              ? fetchUnitsForSelectedProperty()
              : Container();
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'No properties found';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load properties: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred: $e';
      });
    }
  }

  Future<void> fetchUnitsForSelectedProperty() async {
    final token =
        Provider.of<TokenProvider>(context, listen: false).accessToken;
    propid = selectedPropertyId ?? propertyId;

    setState(() {
      isLoading = true;
    });

    // const propid = selectedPropertyId != null ? selectedPropertyId :propertyId;

    try {
      final response = await http.get(
        Uri.parse(
            'https://www.eparivartan.co.in/rentalapp/public/user/getunitsforproperties/$propid'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          unitList = data['allunits'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load units: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred: $e';
      });
    }
  }


  //doclistdeleteapi cal
  Future<void> deleteTenantImage() async {
  setState(() {
    isLoading = true;
  });

  final token = Provider.of<TokenProvider>(context, listen: false).accessToken;
  final url =
      'https://www.eparivartan.co.in/rentalapp/public/user/deletetenantimages/$imgid/$tenantId';

  try {
    final dio = Dio();
    final response = await dio.delete(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = response.data;
     

      // Remove the deleted image from the list
      setState(() {
        list1Documents.removeWhere((doc) => doc['docId'] == imgid);
      });

      Fluttertoast.showToast(
        msg: data.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstants.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Close the dialog
    } else {
      Fluttertoast.showToast(
        msg: "Failed to delete image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });

    Fluttertoast.showToast(
      msg: 'An error occurred: $e',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

//removerstartimglistapi

 Future<void> deleteTenantstartImagelist() async {
  setState(() {
    isLoading = true;
  });

  final token = Provider.of<TokenProvider>(context, listen: false).accessToken;
  final url =
      'https://www.eparivartan.co.in/rentalapp/public/user/deletetenantimages/$imgidstart/$tenantId';

  try {
    final dio = Dio();
    final response = await dio.delete(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = response.data;
      

      // Remove the deleted image from the list
      setState(() {
        list2Documents.removeWhere((doc) => doc['docId'] == imgidstart);
      });

      Fluttertoast.showToast(
        msg: data.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstants.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Close the dialog
    } else {
      Fluttertoast.showToast(
        msg: "Failed to delete image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });

    Fluttertoast.showToast(
      msg: 'An error occurred: $e',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

//removeendimalistapicall

 Future<void> deleteTenantendImagelist() async {
  setState(() {
    isLoading = true;
  });

  final token = Provider.of<TokenProvider>(context, listen: false).accessToken;
  final url =
      'https://www.eparivartan.co.in/rentalapp/public/user/deletetenantimages/$imgidend/$tenantId';

  try {
    final dio = Dio();
    final response = await dio.delete(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = response.data;
      
      // Remove the deleted image from the list
      setState(() {
        list3Documents.removeWhere((doc) => doc['docId'] == imgidend);
      });

      Fluttertoast.showToast(
        msg: data.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstants.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Close the dialog
    } else {
      Fluttertoast.showToast(
        msg: "Failed to delete image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });

    Fluttertoast.showToast(
      msg: 'An error occurred: $e',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}





  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: loadTenantData,
      child: Scaffold(
        backgroundColor: ColorConstants.searchfield,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.6.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Edit Unit',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.urbanist(
                          color: ColorConstants.secondaryColor,
                          // ignore: deprecated_member_use
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'First Name',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _firstName(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Last Name',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _lastName(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Email',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _tenantemail(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Phone Number',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _phonenumber(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Total Members',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _totalmembers(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Profile',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        _chhosefile(),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Native Address Details',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.secondaryColor,
                              // ignore: deprecated_member_use
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Country',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        country(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'State',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        state(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'City',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        City(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Zipcode',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        zipcode(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Address',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Address(),
                        SizedBox(
                          height: 1.h,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Property Details',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.secondaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
      
                        Text(
                          'Property',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        // getproperty(),
                        DropdownButton<String>(
                          value: selectedPropertyId,
                          hint: const Text(
                            'Select a property',
                            style: TextStyle(
                              color: Colors.grey, // Hint text color
                              fontSize: 16, // Hint text size
                            ),
                          ),
                          isExpanded:
                              true, // Makes the dropdown button take full width
                          icon: const Icon(
                            Icons.arrow_drop_down, // Custom dropdown arrow icon
                            color: Colors.blue, // Icon color
                            size: 24, // Icon size
                          ),
                          dropdownColor: Colors
                              .white, // Background color of the dropdown menu
                          items: propertyTypes
                              .map<DropdownMenuItem<String>>((property) {
                            return DropdownMenuItem<String>(
                              value: property['propertyId'].toString(),
                              child: Text(
                                property['propertyName'] ?? 'Unnamed Property',
                                style: const TextStyle(
                                  fontSize: 16, // Text size for dropdown items
                                  color: Colors
                                      .black, // Text color for dropdown items
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedPropertyId =
                                  value; // Update selected property
                            });
      
                            selectedPropertyId != null
                                ? fetchUnitsForSelectedProperty()
                                : Container();
                          },
                          style: const TextStyle(
                            color: Colors.black, // Selected text color
                            fontSize: 16, // Selected text size
                          ),
                          underline: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xffdadada), // Custom underline color
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded border
                            ),
                          ),
                        ),
      
                        // TwoDropdowns(),
      
                        Text(
                          'Unit',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              // ignore: deprecated_member_use
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
      
                        DropdownButtonFormField<String>(
                          value: unitList.any(
                                  (unit) => unit['unitName'] == selectedUnitValue)
                              ? selectedUnitValue
                              : null,
                          items: unitList.map<DropdownMenuItem<String>>((unit) {
                            final unitName = unit['unitName'] ?? 'Unknown Unit';
                            return DropdownMenuItem<String>(
                              value: unitName,
                              child: Text(unitName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedUnitValue = value;
                            });
      
                            // Find the selected unit ID based on the unitName (value).
                            final selectedUnit = unitList.firstWhere(
                              (unit) => unit['unitName'] == value,
                              orElse: () => null, // Optional fallback
                            );
      
                            // Ensure the unit exists before setting the unit ID
                            if (selectedUnit != null) {
                              unitId = selectedUnit[
                                  'unitId']; // Assuming 'unitId' is the key
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(0xffDADADA), width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(0xffdadada), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(0xffdadada), width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(0xffdadada), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color(0xffdadada), width: 1)),
                          ),
                        ),
      
                        SizedBox(height: 16),
      
                        // Error Message
                        if (uniterror != null)
                          Text(
                            uniterror.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
      
                        // Loading Indicator
                        if (isLoading) CircularProgressIndicator(),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Start Date',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        startdate(),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'End Date',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        enddate(),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Documents',
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.blackcolor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Documents(),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Start Conditions',
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.blackcolor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                startcondation(),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'End Conditions',
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.blackcolor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
               endcondition(),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                      decoration: BoxDecoration(
                          color: const Color(0xffdadada),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'Close',
                          style: GoogleFonts.urbanist(
                              color: ColorConstants.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                     _isLoading
            ? const CircularProgressIndicator() // Show loader when _isLoading is true
            : GestureDetector(
                      onTap: () async{
                        // createtenant();
                        await updatetenant();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 16),
                        decoration: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            'Update',
                            style: GoogleFonts.urbanist(
                                color: ColorConstants.whiteColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //tenantfirstname

  Widget _firstName() {
    return TextFormField(
      controller: _firstname,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null; // Return null if validation is successful
      },
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'select property',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
      ),
    );
  }

  //tenantlastname

  Widget _lastName() {
    return TextFormField(
      controller: _lastname,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null; // Return null if validation is successful
      },
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'select property',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
      ),
    );
  }

  //tenantemail

  Widget _tenantemail() {
    return TextFormField(
      controller: _emailtenant,
      keyboardType: TextInputType.name,
      validator: validateEmail,
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Email Address',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff192252), width: 1)),
      ),
    );
  }

  //tenantphonenumber

  Widget _phonenumber() {
    return TextFormField(
      controller: _phonenumbertenant,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10), // Limit input to 10 characters
        FilteringTextInputFormatter.digitsOnly, // Only allow numeric input
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null; // Return null if validation is successful
      },
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Enter Phone number',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
      ),
    );
  }

  //tenanttotalnumbers

  Widget _totalmembers() {
    return TextFormField(
      controller: _totalnumbers,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10), // Limit input to 10 characters
        FilteringTextInputFormatter.digitsOnly, // Only allow numeric input
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null; // Return null if validation is successful
      },
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Enter Phone number',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
      ),
    );
  }

  //tenantprofileimage

  Widget _chhosefile() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffDADADA), width: 1),
        ),
        child: Row(
          children: [
            GestureDetector(
                onTap: (){

                },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffE9E9E9),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Choose File',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                      color: ColorConstants.blackcolor,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              width: 1.w,
            ),
            SizedBox(
              width: 100,
              child: Text(
                image != null ? 'File Path: $image' : 'No file selected',
                style: GoogleFonts.urbanist(
                    color: const Color(0xffABABAB),
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }

  //tenantcountry
  Widget country() {
    return TextFormField(
      controller: _country,
      readOnly: true, // Makes the field read-only
      enabled: false, // Disables the text field, preventing any input
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: const Color(0xffdadada),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText:
            'India', // Optional, since 'India' is already the default value
        hintStyle: GoogleFonts.urbanist(
          color: ColorConstants.blackcolor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffdadada), width: 1),
        ),
      ),
    );
  }

//tenantState

  Widget state() {
    return TextFormField(
      controller: _state,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null; // Return null if validation is successful
      },
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Enter State',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
      ),
    );
  }

  //tenantcity

  // ignore: non_constant_identifier_names
  Widget City() {
    return TextFormField(
      controller: _city,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null; // Return null if validation is successful
      },
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Enter City',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
      ),
    );
  }

  //tenantzipcode

  Widget zipcode() {
    return TextFormField(
      controller: _zipcode,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null; // Return null if validation is successful
      },
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Enter Zipcode',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
      ),
    );
  }

  //tenantaddress

  Widget Address() {
    return TextFormField(
      controller: _address,
      keyboardType: TextInputType.multiline,
      minLines: 3, // Start with 3 lines
      maxLines: 5, // Allow up to 5 lines

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null; // Return null if validation is successful
      },
      style: const TextStyle(
        color: ColorConstants.textcolor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: 'Enter Property Address',
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
      ),
    );
  }

  //tenantstartdate

  Widget startdate() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Spacing between fields
      child: TextFormField(
        controller: _startDateController,
        readOnly: true, // Prevent manual typing
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            setState(() {
              _startDateController.text =
                  pickedDate.toString().split(' ')[0]; // Format date
            });
          }
        },
        decoration: InputDecoration(
          fillColor: ColorConstants.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintText: _startDateController.text,
          hintStyle: const TextStyle(
              color: ColorConstants.textcolor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
          suffixIcon: GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  _startDateController.text =
                      pickedDate.toString().split(' ')[0];
                });
              }
            },
            child: const Icon(Icons.calendar_today,
                color: ColorConstants.textcolor),
          ),
        ),
      ),
    );
  }

  //enddate

  Widget enddate() {
    return TextFormField(
      controller: _endDateController,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _endDateController.text = pickedDate.toString().split(' ')[0];
          });
        }
      },
      decoration: InputDecoration(
        fillColor: ColorConstants.whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        hintText: _endDateController.text,
        hintStyle: const TextStyle(
            color: ColorConstants.textcolor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffdadada), width: 1)),
        suffixIcon: GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                _endDateController.text = pickedDate.toString().split(' ')[0];
              });
            }
          },
          child:
              const Icon(Icons.calendar_today, color: ColorConstants.textcolor),
        ),
      ),
    );
  }

  //documents

  
  Widget Documents() {
    return Column(
      children: [
        GestureDetector(
          onTap: pickFileOption, // Trigger file pick on tap
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DottedBorder(
              color: Colors.black,
              strokeWidth: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Image.asset(
                    'assets/icons/upload.png',
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Display the selected documents (images) in a horizontal list
        list1Documents.isEmpty
            ? const Text(
                'No files selected') // Show a message if no files are selected
            : SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list1Documents.length,
                  itemBuilder: (context, index) {
                    final documentslist = list1Documents[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: documentslist != null
                              ? Image.network(
                                  'https://www.eparivartan.co.in/rentalapp/public/${documentslist?['docPath']}')
                              : Text('No Files Found'),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.remove_circle),
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  imgid = documentslist?['docId'];
                                });
                                _showDeleteDialog(context);
                                // Remove file when button is tapped
                              },
                            ))
                      ],
                    );
                  },
                ),
              ),

        const SizedBox(height: 20),
        uploadeddocs.isNotEmpty
            // ignore: sized_box_for_whitespace
            ? Container(
                height: 100, // Set height for horizontal ListView
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: uploadeddocs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        children: [
                          // Display the image (could be any widget to represent the file)
                          Image.file(
                            File(uploadeddocs[index]),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.remove_circle),
                              color: Colors.red,
                              onPressed: () {
                                removeFile(
                                    index); // Remove file when button is tapped
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : Center(child: Text('No files uploaded')),
      ],
    );
  }

  Widget startcondation() {
    return Column(
      children:  [

        GestureDetector(
          onTap: (){
            startimglist();  
          },
          child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DottedBorder(
                color: Colors.black,
                strokeWidth: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/upload.png',
                      height: 40,
                    ),
                  ),
                ),
              ),
            ),
        ),

        list2Documents.isEmpty
            ? const Text(
                'No files selected') // Show a message if no files are selected
            : SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list2Documents.length,
                  itemBuilder: (context, index) {
                    final documentslist = list2Documents[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: documentslist != null
                              ? Image.network(
                                  'https://www.eparivartan.co.in/rentalapp/public/${documentslist?['docPath']}')
                              : Text('No Files Found'),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.remove_circle),
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  imgidstart = documentslist?['docId'];
                                });
                              _showDeleteStartimgDialog(context);
                                // Remove file when button is tapped
                              },
                            ))
                      ],
                    );
                  },
                ),
              ),
  const SizedBox(height: 20),
        uploadstartimages.isNotEmpty
            // ignore: sized_box_for_whitespace
            ? Container(
                height: 100, // Set height for horizontal ListView
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: uploadstartimages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        children: [
                          // Display the image (could be any widget to represent the file)
                          Image.file(
                            File(uploadstartimages[index]),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.remove_circle),
                              color: Colors.red,
                              onPressed: () {
                                remove(
                                    index); // Remove file when button is tapped
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : Center(child: Text('No files uploaded')),
        


      ],
    );
  }

  Widget endcondition() {
    return Column(
      children: [
         GestureDetector(
          onTap: (){
            endimglist();  
          },
          child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DottedBorder(
                color: Colors.black,
                strokeWidth: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/upload.png',
                      height: 40,
                    ),
                  ),
                ),
              ),
            ),
        ),

        list3Documents.isEmpty
            ? const Text(
                'No files selected') // Show a message if no files are selected
            : SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list3Documents.length,
                  itemBuilder: (context, index) {
                    final documentslist = list3Documents[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: documentslist != null
                              ? Image.network(
                                  'https://www.eparivartan.co.in/rentalapp/public/${documentslist?['docPath']}')
                              : Text('No Files Found'),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.remove_circle),
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  imgidend = documentslist?['docId'];
                                });
                             _showDeleteEndimgDialog(context);
                                // Remove file when button is tapped
                              },
                            ))
                      ],
                    );
                  },
                ),
              ),
  const SizedBox(height: 20),
        uploadendimageslist.isNotEmpty
            // ignore: sized_box_for_whitespace
            ? Container(
                height: 100, // Set height for horizontal ListView
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: uploadendimageslist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        children: [
                          // Display the image (could be any widget to represent the file)
                          Image.file(
                            File(uploadendimageslist[index]),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.remove_circle),
                              color: Colors.red,
                              onPressed: () {
                                removeend(
                                    index); // Remove file when button is tapped
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : Center(child: Text('No files uploaded')),
      ],
    );
  }


  Future<void> updatetenant() async {
    setState(() {
      _isLoading = true; // Show the loader
    });

    try {
final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
      final url = Uri.parse(
          'https://www.eparivartan.co.in/rentalapp/public/user/updatetenant/$tenantId');

      var request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'multipart/form-data',
      });

      // Add fields
      request.fields['propertyId'] = propid.toString();
      request.fields['unitId'] = unitId.toString();
      request.fields['tenantFirstName'] = _firstname.text;
      request.fields['tenantLastName'] = _lastname.text;
      request.fields['tenantEmail'] = _emailtenant.text;
      request.fields['tenantPhoneNumber'] = _phonenumbertenant.text;
      request.fields['tenantNumbers'] = _totalnumbers.text;
      request.fields['tenantCountry'] = 'India';
      request.fields['tenantStateList'] = _state.text;
      request.fields['tenantCity'] = _city.text;
      request.fields['tenantZipCode'] = _zipcode.text;
      request.fields['tenantAddress'] = _address.text;
      request.fields['startDate'] = _startDateController.text;
      request.fields['endDate'] = _endDateController.text;

      // Process files
      for (var filePath in uploadeddocs) {
        request.files.add(await http.MultipartFile.fromPath(
          'fileDco[]',
          filePath,
        ));
      }
      for (var filePath in uploadstartimages) {
        request.files.add(await http.MultipartFile.fromPath(
          'startcondation[]',
          filePath,
        ));
      }
      for (var filePath in uploadendimageslist) {
        request.files.add(await http.MultipartFile.fromPath(
          'endcondation[]',
          filePath,
        ));
      }
      if (profileimage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'tenantProfileImage',
          profileimage.toString(),
        ));
      }

      var response = await request.send();
     
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
       
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()),
          
        );
          Fluttertoast.showToast(
          msg: responseBody.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstants.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        var responseBody = await response.stream.bytesToString();
      
        Fluttertoast.showToast(
          msg: responseBody.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstants.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
    
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstants.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide the loader
      });
    }
  }


}
