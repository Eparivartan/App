import 'package:careercoach/Widgets/App_Bar_Widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Home Page.dart';
import '../config.dart';
import 'contact.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: App_Bar_widget2(title: ''),
      ),
      backgroundColor: Config.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView(
            children: [
              Image.asset(
                'assets/images/homedesign.png',
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Us',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'We at CAD Career Coach strive to provide continuous learning experience, '
                      'keep our users informed on the latest trends, job openings, academic courses, '
                      'internships, and workshops happening across the fields of Architecture, Civil, '
                      'and Mechanical engineering, with a focus on design and drafting - all about '
                      'providing the best possible information for those ACM seekers. \n\nInternships and '
                      'workshops happening across the fields of Architecture, Civil, and Mechanical engineering, '
                      'with a focus on design and drafting - all about providing the best possible information '
                      'for those ACM seekers.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Our partners in crime include:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              CarouselSlider(
                options: CarouselOptions(
                  enlargeFactor: 0.5,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  Row(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/images/grid1.png',
                          height: 8.h,
                          width: 22.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Container(
                        child: Image.asset(
                          'assets/images/grid2.png',
                          height: 8.h,
                          width: 22.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Container(
                        child: Image.asset(
                          'assets/images/grid3.png',
                          height: 8.h,
                          width: 22.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  // Additional slides go here...
                ],
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Want to collaborate? Need our services?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 2.2.h),
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 5.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Contact()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        minimumSize: Size.fromHeight(50),
                        backgroundColor: Config.containerGreenColor,
                      ),
                      child: Text(
                        'Reach Us',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 33),
            ],
          ),
        ),
      ),
    );
  }
}
