import 'package:flutter/material.dart';

class TenantProvider with ChangeNotifier {
  String _tenantId = '';

  String get tenantId => _tenantId;

  set tenantId(String value) {
    _tenantId = value;
    notifyListeners();
  }
}
