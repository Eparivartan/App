
// API Service
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:commercilapp/models/googlemapscontroller.dart';

class ApiService {
  static const String baseUrl = 'https://mycommercialpal.com/api-list-page.php';

  // Fetch data from the API
  Future<List<Filterlist>> fetchData(int page) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['data'] != null) {
        List<dynamic> dataList = jsonData['data'];
        return dataList.map((data) => Filterlist.fromJson(data)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
