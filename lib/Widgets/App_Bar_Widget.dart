import 'package:careercoach/Home%20Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Config.dart';

class App_Bar_widget extends StatelessWidget {
  const App_Bar_widget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Config.containerColor,
      leadingWidth: 85,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: InkWell(
          child: Image.asset('assets/images/pg12-1.png',height: 6.1.h,width: 22.6.w,),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()));
          },),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Text(title ?? '',textAlign: TextAlign.end,
                style:TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Config.primaryTextColor
                ))),
          ),
      ],
    );
  }
}


class App_Bar_widget1 extends StatefulWidget {
  final String title;
  const App_Bar_widget1({Key? key, required this.title}) : super(key: key);

  @override
  State<App_Bar_widget1> createState() => _App_Bar_widget1State();
}

class _App_Bar_widget1State extends State<App_Bar_widget1> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Config.containerColor,
      leadingWidth: 85,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          child: Image.asset('assets/images/logo.png',height: 6.1.h,
            width: 22.6.w,),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()));
          },),
      ),
      actions: [
        Center(
          child: Text(widget.title ?? '',
            textAlign: TextAlign.end,
            style:TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: Config.primaryTextColor
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10,right: 17),
          child: Icon(Icons.star_border,
// weight: 9.sp,
            color: Color(0xff000000),
          ),
        ),
      ],
    );
  }
}


class App_Bar_widget2 extends StatefulWidget {
  final String title;
  // final String function;
  const App_Bar_widget2({Key? key, required this.title}) : super(key: key);

  @override
  State<App_Bar_widget2> createState() => _App_Bar_widget2State();
}

class _App_Bar_widget2State extends State<App_Bar_widget2> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Config.containerColor,
      leadingWidth: 85,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          child: Image.asset('assets/images/logo.png',height: 6.1.h,
            width: 22.6.w,),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()));
          },),
      ),
      actions: [
        Center(
          child: Text(widget.title ?? '',
            textAlign: TextAlign.end,
            style:TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: Config.primaryTextColor
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // widget.function;
          },
          child: Padding(
            padding: EdgeInsets.only(left: 10,right: 17),
            child: InkWell(
              child: Icon(Icons.star_outline_rounded,
                color: Color(0xff000000),
              ),
              onTap: () {
                setState(() {
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}


class App_Bar_Widget2_1 extends StatefulWidget {
  final String title;
  var function;
  App_Bar_Widget2_1({Key? key, required this.title, required this.function}) : super(key: key);

  @override
  State<App_Bar_Widget2_1> createState() => _App_Bar_Widget2_1State();
}

class _App_Bar_Widget2_1State extends State<App_Bar_Widget2_1> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Config.containerColor,
      leadingWidth: 85,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          child: Image.asset('assets/images/logo.png',height: 6.1.h,
            width: 22.6.w,),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()));
          },),
      ),
      actions: [
        Center(
          child: Text(widget.title ?? '',
            textAlign: TextAlign.end,
            style:TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: Config.primaryTextColor
            ),
          ),
        ),
        InkWell(
          onTap: () {
            widget.function;
          },
          child: Padding(
            padding: EdgeInsets.only(left: 10,right: 17),
            child: InkWell(
              child: Icon(Icons.star_outline_rounded,
                color: Config.goldColor,
              ),
              onTap: () {
                setState(() {
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}



class App_Bar_widget3 extends StatefulWidget {
  final String image;
  const App_Bar_widget3({Key? key, required this.image}) : super(key: key);

  @override
  State<App_Bar_widget3> createState() => _App_Bar_widget3State();
}

class _App_Bar_widget3State extends State<App_Bar_widget3> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Config.containerColor,
      leadingWidth: 85,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          child: Image.asset('assets/images/logo.png',height: 6.1.h,
            width: 22.6.w,),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()));
          },),
      ),
      actions: [
        Center(
          child: Image.asset('assets/images/dhyanacademy-logo.png',
            height: 6.h,
            width: 30.w,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10,right: 17),
          child: InkWell(
            onTap: (){},
            child: Icon(Icons.star_border,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    );
  }
}


class App_Bar_widget_2 extends StatefulWidget {
  final String image;
  const App_Bar_widget_2({Key? key, required this.image}) : super(key: key);

  @override
  State<App_Bar_widget_2> createState() => _App_Bar_widget_2State();
}

class _App_Bar_widget_2State extends State<App_Bar_widget_2> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Config.containerColor,
      leadingWidth: 85,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          child: Image.asset('assets/images/logo.png',height: 6.1.h,
            width: 22.6.w,),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()));
          },),
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset('assets/images/dhyanacademy-logo.png',
              height: 6.h,
              width: 30.w,
            ),
          ),
        ),
      ],
    );
  }
}