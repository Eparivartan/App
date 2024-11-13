import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:legala/screens/homepage/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/screens/loginscreen.dart';
import 'package:legala/sevices/tokenprovider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  FlutterSizer(
       builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Legala',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      );
       }
    );
  }
}

