import 'dart:convert';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/models/tenantlistmodel.dart';
import 'package:legala/models/unitdropdown.dart';
import 'package:legala/screens/tenant/viewtenantprofile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TenazListScreen extends StatefulWidget {
  const TenazListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TenazListScreenState createState() => _TenazListScreenState();
}

class _TenazListScreenState extends State<TenazListScreen> {
  final String apiUrl =
      "https://www.eparivartan.co.in/rentalapp/public/user/gettenant";
  // Replace with your actual token.

  Tenazlist? _tenazlist;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
     final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _tenazlist = Tenazlist.fromJson(json.decode(response.body));
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _tenazlist != null && _tenazlist!.data != null
            ? ListView.builder(
                itemCount: _tenazlist!.data!.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = _tenazlist!.data![index];

                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        

                              Provider.of<TenantProvider>(context,
                                      listen: false)
                                  .setTenantId('${item.tenantId}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ViewTenantProfile()),
                              );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundImage: item.image != null
                                        ? NetworkImage(
                                            'https://www.eparivartan.co.in/rentalapp/public/${item.image}',
                                          )
                                        : const AssetImage('assets/icons/profile.png')
                                            as ImageProvider,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${item.tenantName}',
                                            style: GoogleFonts.urbanist(
                                              color:
                                                  ColorConstants.secondaryColor,
                                              // ignore: deprecated_member_use
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            '₹50,000/-',
                                            style: GoogleFonts.urbanist(
                                              color:
                                                  ColorConstants.secondaryColor,
                                              // ignore: deprecated_member_use
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '2BHK',
                                        style: GoogleFonts.urbanist(
                                          // ignore: deprecated_member_use
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstants.lighttext,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${item.cityName}',
                                        style: GoogleFonts.urbanist(
                                          // ignore: deprecated_member_use
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstants.lighttext,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 1.h),
                            const Divider(
                              color: ColorConstants.lighttext,
                              thickness: 0.5,
                            ),
                            // Add the CupertinoSwitch here, below the Divider
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Toggle Option",
                                  style: GoogleFonts.urbanist(
                                    // ignore: deprecated_member_use
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.lighttext,
                                  ),
                                ),
                              
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text('No data available'));
  }
}
