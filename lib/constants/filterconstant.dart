import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';

class FilterConstant extends StatefulWidget {
  const FilterConstant({super.key});

  @override
  State<FilterConstant> createState() => _FilterConstantState();
}

class _FilterConstantState extends State<FilterConstant> {
  List<String> propertyItems = ['Villa', 'Individual House', 'Outhouse'];
  List<String> categoryItems = ['Category 1', 'Category 2', 'Category 3'];
  List<String> locationItems = ['Location 1', 'Location 2', 'Location 3'];

  String? selectedPropertyValue;
  String? selectedCategoryValue;
  String? selectedLocationValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: ColorConstants.whiteColor,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Property Type Dropdown
            Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    decoration: BoxDecoration(
                      color: ColorConstants.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: ColorConstants.filterborderColor, width: 1),
                    ),
                    child: Center(
                        child: Image.asset(
                      ImageConstants.PROPERTYTYPE,
                      height: 25,
                    ))),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: ColorConstants.filterborderColor, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true, // Expands dropdown to full width
                        hint: Text('Select Property Type'),
                        value: selectedPropertyValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPropertyValue = newValue;
                          });
                        },
                        items: propertyItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Category Type Dropdown
            Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    decoration: BoxDecoration(
                      color: ColorConstants.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: ColorConstants.filterborderColor, width: 1),
                    ),
                    child: Center(
                        child: Image.asset(
                      ImageConstants.CATEGORYTYPE,
                      height: 25,
                    ))),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: ColorConstants.filterborderColor, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Select Category Type'),
                        value: selectedCategoryValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategoryValue = newValue;
                          });
                        },
                        items: categoryItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Location Type Dropdown
            Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    decoration: BoxDecoration(
                      color: ColorConstants.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: ColorConstants.filterborderColor, width: 1),
                    ),
                    child: Center(
                        child: Image.asset(
                      ImageConstants.LOCATIONTYPE,
                      height: 25,
                    ))),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: ColorConstants.filterborderColor, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Select Location Type'),
                        value: selectedLocationValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLocationValue = newValue;
                          });
                        },
                        items: locationItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('Search',
                      style: GoogleFonts.plusJakartaSans(
                          color: ColorConstants.whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
