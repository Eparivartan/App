import 'package:flutter/material.dart';

class CodeProvider with ChangeNotifier {
  String _code = ''; // Private variable to store the code

  // Getter to retrieve the code
  String get code => _code;

  // Setter to update the code and notify listeners
  void setCode(String newCode) {
    _code = newCode;
    notifyListeners(); // Notify the listeners when the code changes
  }
}
