import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:commercilapp/constant/apiconstant.dart';
import 'package:commercilapp/models/citymodellist.dart';
import 'package:commercilapp/models/locationlist.dart';
import 'package:flutter/material.dart';

class CityProvider with ChangeNotifier {
  List<City> _cityList = [];
  List<Locationlist> _locationList = [];

  List<City> get cityList => _cityList;
  List<Locationlist> get locationList => _locationList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Fetch city list from API
  Future<void> fetchCityList() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('${BaseUrl}api-city-list.php'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        _cityList = jsonResponse.map((city) => City.fromJson(city)).toList();
      } else {
        throw Exception('Failed to load city list');
      }
    } catch (error) {
      throw Exception('Failed to load city list: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch location list from API based on selected city
  Future<void> fetchLocationList(int cityId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('${BaseUrl}api-locations-list.php?id=$cityId'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        _locationList = jsonResponse.map((data) => Locationlist.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (error) {
      throw Exception('Failed to load locations: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
