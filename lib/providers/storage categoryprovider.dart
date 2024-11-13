import 'package:commercilapp/providers/categoryprovider.dart';
import 'package:flutter/material.dart';
// The CategoriesProvider from earlier

class CategoryProvider with ChangeNotifier {
  String _selectedTitle = '';
  String _selectedId = '';
  List<Categories> _categories = [];

  List<Categories> get categories => _categories;
  String get selectedTitle => _selectedTitle;
  String get selectedId => _selectedId;

  // Load categories and notify listeners when data is fetched
  Future<void> loadCategories() async {
    CategoriesProvider categoriesProvider = CategoriesProvider();
    try {
      _categories = await categoriesProvider.fetchCategories();
      notifyListeners();  // Notify listeners when categories are loaded
    } catch (e) {
      // Handle error (optional)
      e.toString();
    }
  }

  void setSelectedCategory(String title, String id) {
    _selectedTitle = title;
    _selectedId = id;
    notifyListeners();  // Notify listeners when the selected category changes
  }
}
