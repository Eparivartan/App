import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:commercilapp/Authenticationscreens/loginscreen.dart';

import 'package:commercilapp/constant/colorconstant.dart';
import 'package:commercilapp/constant/imageconstant.dart';

import 'package:commercilapp/homepage/home.dart';
import 'package:commercilapp/providers/storage%20categoryprovider.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
       
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Commercial_App',
          theme: ThemeData.dark(),
          home:  SplashScreen(),
        );
      },
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<Widget> _checkUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (token == null) {
      // If token is null, navigate to LoginScreen
      return const LoginScreen();
    } else {
      // If token exists, navigate to HomePage
      return const HomePage();
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
      body: FutureBuilder<Widget>(
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
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
