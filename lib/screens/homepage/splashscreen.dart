import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/screens/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Widget nextScreen;

  @override
  void initState() {
    super.initState();
  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: AnimatedSplashScreen(
              duration: 3000,
              splash: Image.asset(
                ImageConstants.LOGO,
                height: 150,
              ),
              nextScreen: LoginScreen(),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.white,
            ),
    );
  }
}
