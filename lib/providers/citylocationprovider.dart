import 'package:flutter/material.dart';

class ProviderState with ChangeNotifier {
  String? _selectedId;
  String? _selectedTitle;

  String? get selectedId => _selectedId;
  String? get selectedTitle => _selectedTitle;

  // Update the selected provider
  void updateProvider(String id, String title) {
    _selectedId = id;
    _selectedTitle = title;
    notifyListeners();  // Notify listeners when the state changes
  }
}
