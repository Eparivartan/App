import 'package:flutter/foundation.dart';

class EditTenantProfile with ChangeNotifier {
  String image = '';
  String tenantFirstName = '';
  String tenantLastName = '';
  String tenantEmail = '';
  String tenantPhone = '';
  int totalMembers = 0;
  String address = '';
  String tenantId = '';
  String propertyName = '';
  String unitName = '';
  String leaseStartDate = '';
  String leaseEndDate = '';
  List<dynamic> list1Documents = [];
  List<dynamic> list2Documents = [];
  List<dynamic> list3Documents = [];
  String propertyId = '';
  String uitid = '';
  String cityName = '';
  String tenantCountry = '';
  String tenantState = '';
  String tenantZipCode = '';

  void setTenantData(Map<String, dynamic> tenantRecord, List<dynamic> list1, List<dynamic> list2, List<dynamic> list3) {
    image = tenantRecord['Image'] ?? '';
    tenantFirstName = tenantRecord['tenantFisrtName'] ?? '';
    tenantLastName = tenantRecord['tenantLastName'] ?? '';
    tenantEmail = tenantRecord['tenantEmail'] ?? '';
    tenantPhone = tenantRecord['tenantPhone'] ?? '';
    totalMembers = tenantRecord['totalMembers'] ?? 0;
    address = tenantRecord['address'] ?? '';
    tenantId = tenantRecord['tenantId'] ?? '';
    propertyName = tenantRecord['propertyName'] ?? '';
    unitName = tenantRecord['unitName'] ?? '';
    leaseStartDate = tenantRecord['leasestartdate'] ?? '';
    leaseEndDate = tenantRecord['leaseenddate'] ?? '';
    list1Documents = list1;
    list2Documents = list2;
    list3Documents = list3;
    propertyId = tenantRecord['propertyId'] ?? '';
    uitid = tenantRecord['uitid'] ?? '';
    cityName = tenantRecord['cityName'] ?? '';
    tenantCountry = tenantRecord['country'] ?? '';
    tenantState = tenantRecord['state'] ?? '';
    tenantZipCode = tenantRecord['zidcode'] ?? '';

    notifyListeners(); // Notify listeners about the change
  }
}
