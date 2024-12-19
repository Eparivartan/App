import 'package:flutter/material.dart';

class PropertyTypeProvider with ChangeNotifier {
  String? _selectedType;
  String? _selectedId;

  String? get selectedType => _selectedType;
  String? get selectedId => _selectedId;

  void setPropertyType(String? type, String? id) {
    _selectedType = type;
    _selectedId = id;
    notifyListeners();
  }
}
