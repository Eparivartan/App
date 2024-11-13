import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Categories {
  int? id;
  String? listTitle;
  String? pricetype;
  int? listOrder;
  int? statusAdd;
  String? addDate;

  Categories({
    this.id,
    this.listTitle,
    this.pricetype,
    this.listOrder,
    this.statusAdd,
    this.addDate,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listTitle = json['list_title'];
    pricetype = json['pricetype'];
    listOrder = json['list_order'];
    statusAdd = json['status_add'];
    addDate = json['add_date'];
  }
}

class CategoriesProvider {
  final String apiUrl = 'https://mycommercialpal.com/api-cat-list-page.php';

  Future<List<Categories>> fetchCategories() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Categories.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}