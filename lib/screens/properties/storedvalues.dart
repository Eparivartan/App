import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:legala/sevices/tokenprovider.dart';
import 'package:provider/provider.dart'; // Assuming you are using Provider to manage the token
import 'package:http_parser/http_parser.dart'; // Import for MediaType

class PropertyFormPage extends StatefulWidget {
  @override
  _PropertyFormPageState createState() => _PropertyFormPageState();
}

class _PropertyFormPageState extends State<PropertyFormPage> {
  final TextEditingController _propertytype = TextEditingController();
  final TextEditingController _propertname = TextEditingController();
  final TextEditingController _propertysize = TextEditingController();
  final TextEditingController _yearlytax = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipcode = TextEditingController();
  final TextEditingController _address = TextEditingController();

  File? selectedImg;
  String selectedImgName = 'default_image.jpg'; // default image name if no image selected

  Future<void> sendProperties() async {
    // Get Bearer Token from Provider
    final token = Provider.of<TokenProvider>(context, listen: false).accessToken;

    // Use the selected image name if available, else fallback to the default
    String selectedImage = selectedImg != null ? selectedImg!.path : selectedImgName;

    // API Endpoint
    const String apiUrl = "https://www.eparivartan.co.in/rentalapp/public/user/properties";

    // Property Data
    final Map<String, String> propertyData = {
      'propertyType': _propertytype.text,
      'propertyName': _propertname.text,
      'propertySize': "${_propertysize.text}.0",
      '_yearlytax': _yearlytax.text,
      'propertyCountry': 'India',
      'propertyState': _state.text,
      'propertyCity': _city.text,
      'propertyZipcode': _zipcode.text,
      'propertyAddress': _address.text,
      'propertyStatus': '1',
      'propertyThumbnail': selectedImage,
    };

    try {
      // If an image is selected, we need to send it as part of a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..headers['Authorization'] = 'Bearer $token'
        ..fields.addAll(propertyData);

      // If an image is selected, add it as a file in the request
      if (selectedImg != null) {
        String mimeType = 'image/jpeg'; // Default MIME type
        String? extension = selectedImg!.path.split('.').last;
        mimeType = 'image/$extension';

        // Use MediaType from the http_parser package to specify the content type of the image
        request.files.add(await http.MultipartFile.fromPath(
          'propertyThumbnail',
          selectedImg!.path,
          contentType: MediaType('image', extension),  // Correct usage of MediaType
        ));
      }

      // Send the request
      var response = await request.send();
      print(response.statusCode);
      print(response.stream);

      // Handling the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Property data sent successfully!");
        print("Response: ${response.persistentConnection}");
        print(response);
      } else {
        print("Failed to send property data. Status Code: ${response.statusCode}");
        print("Error: ${response}");
      }
    } catch (e) {
      // Error Handling
      print("An error occurred: $e");
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    
    if (image != null) {
      setState(() {
        selectedImg = File(image.path);
        selectedImgName = image.name;  // Get the image name
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Property Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              TextField(controller: _propertytype, decoration: InputDecoration(labelText: 'Property Type')),
              TextField(controller: _propertname, decoration: InputDecoration(labelText: 'Property Name')),
              TextField(controller: _propertysize, decoration: InputDecoration(labelText: 'Property Size')),
              TextField(controller: _yearlytax, decoration: InputDecoration(labelText: 'Yearly Tax')),
              TextField(controller: _state, decoration: InputDecoration(labelText: 'State')),
              TextField(controller: _city, decoration: InputDecoration(labelText: 'City')),
              TextField(controller: _zipcode, decoration: InputDecoration(labelText: 'Zipcode')),
              TextField(controller: _address, decoration: InputDecoration(labelText: 'Address')),
              SizedBox(height: 16),

              selectedImg == null
                  ? ElevatedButton(onPressed: _pickImage, child: Text('Capture Image'))
                  : Column(
                      children: [
                        Image.file(selectedImg!, height: 150, width: 150, fit: BoxFit.cover),
                        SizedBox(height: 10),
                        ElevatedButton(onPressed: _pickImage, child: Text('Change Image')),
                      ],
                    ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendProperties,
                child: Text('Submit Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
