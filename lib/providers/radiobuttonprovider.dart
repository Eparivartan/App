import 'package:flutter/material.dart';

class TypeSelectionProvider with ChangeNotifier {
  int _selectedValue = -1; // Default unselected value
  String get selectedType => _selectedValue == 0 ? 'B' : _selectedValue == 1 ? 'R' : '';

  int get selectedValue => _selectedValue;

  void selectType(int value) {
    _selectedValue = value;
    notifyListeners();
  }

  void setSelectedValue(int i) {}
}
