import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DWGViewver extends StatefulWidget {
  const DWGViewver({super.key});

  @override
  State<DWGViewver> createState() => _DWGViewverState();
}

class _DWGViewverState extends State<DWGViewver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Example: Open a DWG file from device storage
            String filePath = await _getLocalDWGFilePath();
            if (filePath != null) {
              try {
                await _openDWG(filePath); // Call local method to open DWG
                // Handle successful opening
              } catch (e) {
                // Handle error
                print('Error opening DWG file: $e');
              }
            } else {
              // Handle file not found or user canceled file picker
              print('DWG file path is null');
            }
          },
          child: Text('Open DWG File'),
        ),
      ),
    );
  }

  Future<String> _getLocalDWGFilePath() async {
    // Example: Use file picker or fetch from local storage
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String dwgFileName = 'example.dwg'; // Replace with actual file name
    return '$appDocPath/$dwgFileName';
  }

  Future<void> _openDWG(String filePath) async {
    // Example: Implement your logic to open DWG file
    File file = File(filePath);
    if (await file.exists()) {
      // Example: Open file using platform channels (for native integration)
      // Replace with your actual implementation based on your needs
      try {
        final String result = await MethodChannel('your_channel_name').invokeMethod('openDWG', {'filePath': filePath});
        print('Opened DWG file: $result');
      } on PlatformException catch (e) {
        print('Error opening DWG file: ${e.message}');
      }
    } else {
      throw Exception('File not found');
    }
  }
}
