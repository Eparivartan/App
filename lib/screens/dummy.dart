import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:legala/models/unitdropdown.dart';
import 'package:legala/models/unitview.dart';
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
    Timer(Duration(seconds: 1), () {
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
    final effectiveToken = token ?? accessToken;

    if (effectiveToken != null) {
      print('$effectiveToken >>>>>>>>>>>>>>>>>>>>>>'); // Debugging log for token

      // Making the POST request
      final response = await http.post(
        Uri.parse('https://www.eparivartan.co.in/rentalapp/public/user/data'),
        headers: {
          'Authorization': 'Bearer $effectiveToken', // Bearer token in header
        },
      );

      print('Response: ${response.statusCode}'); // Debugging log for status code

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

          // Debugging logs for user details
          print('User ID: $userId');
          print('User Name: $userName');
          print('User Contact: $userContact');
          print('User Email ID: $userEmail');
          print('Added On: $addedOn');

          // Update UserProvider
          Provider.of<UserProvider>(context, listen: false).updateUser(
            userId: userId.toString(),
            userName: userName,
            userContact: userContact,
            userEmail: userEmail,
            addedOn: addedOn,
          );

          // Navigate to the next screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          );
          print('User details updated in UserProvider.');
        } else {
          print('User data is null in the response.');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } else {
      print("No access token found!");
    }
  } catch (e) {
    print('Error occurred: $e');
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
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 120.0,
              ),
              SizedBox(height: 24),
              Text(
                'Success!',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
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
