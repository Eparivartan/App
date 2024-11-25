import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/screens/tenant/tenantmodel.dart';
import 'package:legala/screens/tenant/viewtenantprofile.dart';
import 'package:legala/screens/tenant/viewtenatmodel.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TenantListPage extends StatefulWidget {
  @override
  _TenantListPageState createState() => _TenantListPageState();
}

class _TenantListPageState extends State<TenantListPage> {
  late Future<TenantModel> tenantData;

  Future<TenantModel> fetchTenants() async {
    final token = Provider.of<TokenProvider>(context, listen: false)
        .accessToken; // Replace with your token
         final tenantProvider = Provider.of<TenantProvider>(context, listen: false);
    final response = await http.get(
      Uri.parse(
          'https://www.eparivartan.co.in/rentalapp/public/user/gettenant'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return TenantModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load tenant data');
    }
  }

  List<bool> switchValues = List.generate(15, (index) => false);

  @override
  void initState() {
    super.initState();
    tenantData = fetchTenants();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TenantModel>(
        future: tenantData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.alltenants == null) {
            return Center(child: Text('No tenants found.'));
          } else {
            final tenants = snapshot.data!.alltenants!;
            return ListView.builder(
              itemCount: tenants.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                final tenant = tenants[index];
                return GestureDetector(
                  onTap: () {
                       Provider.of<TenantProvider>(context, listen: false)
                  .setSelectedTenant(tenant);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewTenantProfile()),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CircleAvatar(
                                  radius:
                                      24, // Adjust the size of the profile picture
                                  backgroundImage: AssetImage(
                                      'assets/icons/profile.png'), // Replace with your profile image
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${tenant.tenantFirstName}${tenant.tenantLastName}',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.urbanist(
                                              color:
                                                  ColorConstants.secondaryColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '₹' + '50,000' + '/-',
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.urbanist(
                                                color: ColorConstants
                                                    .secondaryColor,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '2BHK',
                                      style: GoogleFonts.urbanist(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstants.lighttext),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${tenant.tenantCity}',
                                          style: GoogleFonts.urbanist(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstants.lighttext),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: () async {
                                              final Uri phoneUri = Uri(
                                                  scheme: 'tel', path: '+91 ${tenant.tenantPhoneNumber}');
                                              if (await canLaunchUrl(
                                                  phoneUri)) {
                                                await launchUrl(phoneUri);
                                              } else {
                                                throw 'Could not launch ${tenant.tenantPhoneNumber}';
                                              }
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF2F4FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Icon(
                                                  Icons.phone,
                                                  color: Color(0xff526bf1),
                                                  size: 2.5.h,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Divider(
                            color: ColorConstants.lighttext,
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Due Date: 26Aug,2024',
                                style: GoogleFonts.urbanist(
                                    color: switchValues[index] == false
                                        ? ColorConstants.textcolor
                                        : ColorConstants.dueconstantcolor,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.scale(
                                    scale:
                                        0.8, // Adjust the scale to control the size
                                    child: CupertinoSwitch(
                                      value: switchValues[index],
                                      onChanged: (value) {
                                        setState(() {
                                          switchValues[index] = value;
                                          print(value.toString());
                                        });
                                      },
                                      thumbColor: ColorConstants.whiteColor,
                                      activeColor: Color(
                                          0xff68CC58), // Thumb color when active
                                      trackColor: Color(
                                          0xffF0F0F2), // Track color when inactive
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    switchValues[index] == false
                                        ? 'Make as paid'
                                        : 'Paid',
                                    style: GoogleFonts.urbanist(
                                        color: ColorConstants.lighttext,
                                        fontSize: 5.sp,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
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
      );
  }
}
