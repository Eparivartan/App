import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:legala/sevices/tokenprovider.dart';

class Sucesffuly extends StatefulWidget {
  const Sucesffuly({super.key});

  @override
  State<Sucesffuly> createState() => _SucesffulyState();
}

class _SucesffulyState extends State<Sucesffuly> {
  

   String? responseText; 
  @override
  void initState() {
    super.initState();
    // Start a timer to call the API after 5 seconds
    Timer(Duration(seconds: 5), () {
      fetchApiData();
    });
  }
Future<void> fetchApiData() async {
  const url = 'http://localhost:8080/user/data';

  // Get the access token from TokenProvider
  final token = Provider.of<TokenProvider>(context, listen: false).accessToken;

  if (token.isEmpty) {
    print("No access token found!");
    return;
  }

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',  // Use the dynamic token here
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        responseText = response.body;
      });
      print(responseText);
      
    } else {
      setState(() {
        responseText = 'Failed to load data: ${response.statusCode}';
      });
    }
  } catch (e) {
    print(e.toString());
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
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Define an action for the button if needed
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
