
import 'package:commercilapp/providers/categoryprovider.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Categories> _categories = [];
  int? selectedIndex;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  // Fetch categories data and update the UI
  Future<void> _loadCategories() async {
    try {
      final categories = await CategoriesProvider().fetchCategories();
      setState(() {
        _categories = categories;
        isLoading = false; // Hide the loading indicator
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
       e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _categories.isEmpty
              ? Center(child: Text('No categories available'))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.0,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Card(
                        color: selectedIndex == index ? Colors.blue : Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.listTitle ?? 'No Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(category.pricetype ?? 'No Price Type'),
                              Text('Order: ${category.listOrder}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}