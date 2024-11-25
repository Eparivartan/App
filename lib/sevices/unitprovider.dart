import 'package:flutter/material.dart';

class PropertyProvider extends ChangeNotifier {
  String? _selectedPropertyId;
  String? _selectedPropertyName;

  String? get selectedPropertyId => _selectedPropertyId;
  String? get selectedPropertyName => _selectedPropertyName;

  void setProperty(String? id, String? name) {
    _selectedPropertyId = id;
    _selectedPropertyName = name;
    notifyListeners();
  }
}
