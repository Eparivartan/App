import 'package:flutter/material.dart';

class SelectionProvider extends ChangeNotifier {
  String? _selectedPropertyId;
  String? _selectedUnitId;

  String? get selectedPropertyId => _selectedPropertyId;
  String? get selectedUnitId => _selectedUnitId;

  void setSelectedPropertyId(String? propertyId) {
    _selectedPropertyId = propertyId;
    notifyListeners();
  }

  void setSelectedUnitId(String? unitId) {
    _selectedUnitId = unitId;
    notifyListeners();
  }
}
