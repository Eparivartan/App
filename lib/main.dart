import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:legala/screens/homepage/splashscreen.dart';
import 'package:legala/screens/tenant/tenantconnectionprovider.dart';
import 'package:legala/screens/tenant/viewtenatmodel.dart';
import 'package:legala/sevices/unitlistis.dart';
import 'package:legala/sevices/unitprovider.dart';
import 'package:legala/sevices/usedetailsprovider.dart';
import 'package:provider/provider.dart';

import 'package:legala/sevices/tokenprovider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app's orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider() ),
        ChangeNotifierProvider(create: (_) => TenantProvider(),),
        ChangeNotifierProvider(create: (_) => SelectionProvider(),),
     
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

