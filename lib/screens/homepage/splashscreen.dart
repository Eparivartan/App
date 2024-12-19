import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:legala/screens/dummy.dart';
import 'package:legala/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   Future<Widget> _checkUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (token == null) {
      // If token is null, navigate to LoginScreen
      return const LoginScreen();
    } else {
      // If token exists, navigate to HomePage
      return const Sucesffuly();
    }
  }


  @override
  void initState() {
    super.initState();
    
  }

  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body:  FutureBuilder<Widget>(
        future: _checkUserStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return AnimatedSplashScreen(
              duration: 3000,
              splash: Image.asset(
                ImageConstants.LOGO,
                height: 150,
              ),
              nextScreen: snapshot.data!,
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.white,
            );
          } else {
            return const Center(
              child: Text(
                'Something went wrong! Please try again later.',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        },
      ),
    );
  }
}
