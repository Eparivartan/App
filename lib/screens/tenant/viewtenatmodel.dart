import 'package:flutter/material.dart';
import 'package:legala/screens/tenant/tenantmodel.dart';


class TenantProvider with ChangeNotifier {
  Alltenants? _selectedTenant;

  Alltenants? get selectedTenant => _selectedTenant;

  void setSelectedTenant(Alltenants tenant) {
    _selectedTenant = tenant;
    notifyListeners();
  }
}
