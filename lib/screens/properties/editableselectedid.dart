import 'package:flutter/material.dart';
import 'package:legala/models/uermodel.dart';

class SelectedPropertyProvider with ChangeNotifier {
  Allproperties? _selectedProperty;

  Allproperties? get selectedProperty => _selectedProperty;

  void setSelectedProperty(Allproperties property) {
    _selectedProperty = property;
    notifyListeners(); // Notify listeners when a new property is selected
  }
}
