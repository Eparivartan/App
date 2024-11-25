import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/screens/dummy.dart';
import 'package:legala/screens/loginscreen.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late Widget nextScreen;

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeNextScreen();
  // }

  // Future<void> _initializeNextScreen() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accessToken = prefs.getString('access_token');
  //   final refreshToken = prefs.getString('refresh_token');

  //   if (accessToken == null || isTokenExpired(accessToken)) {
  //     // Set LoginScreen as next screen
  //     setState(() {
  //       nextScreen = LoginScreen();
  //     });
  //   } else {
  //     // Store tokens in Provider
  //     Provider.of<TokenProvider>(context, listen: false).setTokens(
  //       accessToken,
  //       refreshToken!,
  //     );

  //     // Set BottomNavigation as next screen
  //     setState(() {
  //       nextScreen = Sucesffuly();
  //     });
  //   }
  // }

  // bool isTokenExpired(String token) {
  //   // Add logic to check if the token is expired
  //   // Example: decode token, check expiration timestamp
  //   return false;
  // }

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
        nextScreen: LoginScreen(), // Fallback while determining
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
      ),
    );
  }
}
