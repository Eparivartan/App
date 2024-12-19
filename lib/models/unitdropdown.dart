


import 'package:flutter/material.dart';

class TenantProvider with ChangeNotifier {
  String _tenantId = '';

  String get tenantId => _tenantId;

  void setTenantId(String tenantId) {
    _tenantId = tenantId;
    notifyListeners();  // Notify listeners when the value changes
  }
}




