import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:legala/screens/bottomnavigation.dart';
import 'package:legala/sevices/usedetailsprovider.dart';
import 'package:provider/provider.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sucesffuly extends StatefulWidget {
  const Sucesffuly({super.key});

  @override
  State<Sucesffuly> createState() => _SucesffulyState();
}

class _SucesffulyState extends State<Sucesffuly> {
  String? responseText;
  String? authtoken;
  @override
  void initState() {
    super.initState();
    // Start a timer to call the API after 5 seconds
    Timer(const Duration(seconds: 1), () {
      fetchApiData();
    });
  }

Future<void> fetchApiData() async {
  try {
    // Retrieve token from Provider and SharedPreferences
    final token = Provider.of<TokenProvider>(context, listen: false).accessToken;
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    
    // Check which token to use
    final effectiveToken = token;

   // Debugging log for token

    // Making the POST request
    final response = await http.post(
      Uri.parse('https://www.eparivartan.co.in/rentalapp/public/user/data'),
      headers: {
        'Authorization': 'Bearer $accessToken', // Bearer token in header
      },
    );



    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonResponse = jsonDecode(response.body);

      // Extract user details
      final user = jsonResponse['user'];
      if (user != null) {
        final userId = user['userId'];
        final userName = user['userName'];
        final userContact = user['userContact'];
        final userEmail = user['userEmailid'];
        final addedOn = user['addedOn'];

        

        // Update UserProvider
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false).updateUser(
          userId: userId.toString(),
          userName: userName,
          userContact: userContact,
          userEmail: userEmail,
          addedOn: addedOn,
        );

        // Navigate to the next screen
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()),
        );
        
      } else {
          Fluttertoast.showToast(
    msg: "User data is null in the response.", // Message to display
    toastLength: Toast.LENGTH_SHORT, // Duration of the toast (short or long)
    gravity: ToastGravity.BOTTOM, // Position of the toast (top, center, bottom)
    timeInSecForIosWeb: 1, // iOS/Web toast duration
    backgroundColor: Colors.black, // Background color
    textColor: Colors.white, // Text color
    fontSize: 16.0, // Text font size
  );
     
      }
    } else {
           Fluttertoast.showToast(
    msg: response.body, // Message to display
    toastLength: Toast.LENGTH_SHORT, // Duration of the toast (short or long)
    gravity: ToastGravity.BOTTOM, // Position of the toast (top, center, bottom)
    timeInSecForIosWeb: 1, // iOS/Web toast duration
    backgroundColor: Colors.black, // Background color
    textColor: Colors.white, // Text color
    fontSize: 16.0, // Text font size
  );
      
    }
    } catch (e) {
      Fluttertoast.showToast(
      msg: e.toString(), // Message to display
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast (short or long)
      gravity: ToastGravity.BOTTOM, // Position of the toast (top, center, bottom)
      timeInSecForIosWeb: 1, // iOS/Web toast duration
      backgroundColor: Colors.black, // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Text font size
    );
     
  
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 120.0,
              ),
              const SizedBox(height: 24),
              const Text(
                'Success!',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your data has been successfully posted.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
