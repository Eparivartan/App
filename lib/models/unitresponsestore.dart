import 'package:flutter/material.dart';

class UnitProvider extends ChangeNotifier {
  Map<String, dynamic>? _selectedUnit;

  Map<String, dynamic>? get selectedUnit => _selectedUnit;

  void setSelectedUnit(Map<String, dynamic> unit) {
    _selectedUnit = unit;
    notifyListeners();
  }
}
