// import 'dart:convert';
// import 'package:commercilapp/constant/apiconstant.dart';
// import 'package:commercilapp/constant/citylocationservice.dart';
// import 'package:commercilapp/homepage/subcategory.dart';

// import 'package:commercilapp/models/locationlist.dart';
// import 'package:commercilapp/providers/categoryprovider.dart';
// import 'package:commercilapp/providers/storage%20categoryprovider.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import 'package:commercilapp/constant/colorconstant.dart';
// import 'package:commercilapp/homepage/model.dart';
// import 'package:commercilapp/models/citymodellist.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';

// // Categorylist model
// class Categorylist {
//   int? id;
//   String? listTitle;
//   String? pricetype;
//   int? listOrder;
//   int? statusAdd;
//   String? addDate;

//   Categorylist({
//     this.id,
//     this.listTitle,
//     this.pricetype,
//     this.listOrder,
//     this.statusAdd,
//     this.addDate,
//   });

//   Categorylist.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     listTitle = json['list_title'];
//     pricetype = json['pricetype'];
//     listOrder = json['list_order'];
//     statusAdd = json['status_add'];
//     addDate = json['add_date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['list_title'] = this.listTitle;
//     data['pricetype'] = this.pricetype;
//     data['list_order'] = this.listOrder;
//     data['status_add'] = this.statusAdd;
//     data['add_date'] = this.addDate;
//     return data;
//   }
// }

// class ResponsiveBottomSheet extends StatefulWidget {
//   @override
//   State<ResponsiveBottomSheet> createState() => _ResponsiveBottomSheetState();
// }

// class _ResponsiveBottomSheetState extends State<ResponsiveBottomSheet> {
//   int _selectedValue = 0;
//   String? _selectedCategory;

//   List<City> cityList = []; // Holds the fetched city list
//   City? selectedCity; // Holds the selected city
//   int? selectedCityId; // Holds the selected city ID
//   List<Locationlist> locationList = []; // Holds the fetched location list
//   Locationlist? selectedLocation; // Holds the selected location
//   int? selectedLocationId; // Holds the selected location ID
//   List<Categorylist> categoryList = []; // Holds the fetched category list
//   Categorylist? selectedCategory; // Holds the selected category
//   bool isLoading = false;
//   List<String> gradeList = [
//     "Grade A",
//     "Grade B",
//     "Grade C",
//     "Grade D",
//   ]; // Static grade list
//   String? selectedGrade; // Holds the selected grade

//   // Max and Min values lists
//   List<String> maxValues = [
//     "10",
//     "50",
//     "100",
//     "150",
//     "200",
//     "500",
//     "1000",
//     "5000",
//     "10000",
//     "15000"
//   ];
//   List<String> minValues = [
//     "10",
//     "50",
//     "100",
//     "150",
//     "200",
//     "500",
//     "1000",
//     "10000",
//     "15000",
//     "50000",
//     "85000",
//     "1+Lac"
//   ];

//   String? selectedMaxValue;
//   String? selectedMinValue;
//   var selectedcityvalue;
//   var selectedlocationvalue;
//   var selectedcatid;
//   var selectedcategorytext;

//   @override
//   void initState() {
//     _fetchCityList();
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Fetch the city list (assumes you have a CityProvider with fetchCityList())
//       context.read<CityProvider>().fetchCityList();

//       // Fetch the category list (CategoryProvider)
//       Provider.of<CategoryProvider>(context, listen: false).loadCategories();
//     }); // Fetch the category list
//   }

//   // Fetch city data from the API
//   Future<void> _fetchCityList() async {
//     final response = await http.get(Uri.parse('${BaseUrl}api-city-list.php'));

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       setState(() {
//         cityList = jsonResponse.map((city) => City.fromJson(city)).toList();
//         isLoading = false; // Data is fetched, loading is complete
//       });
//     } else {
//       throw Exception('Failed to load city list');
//     }
//   }

//   Future<void> _fetchLocationList(int? cityId) async {
//     if (cityId == null) return; // Exit if no city ID is selected

//     final response = await http
//         .get(Uri.parse('${BaseUrl}api-locations-list.php?id=$cityId'));

//     if (response.statusCode == 200) {
//       List jsonResponse = jsonDecode(response.body);
//       setState(() {
//         locationList =
//             jsonResponse.map((data) => Locationlist.fromJson(data)).toList();
//       });
//     } else {
//       throw Exception('Failed to load locations');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildClearFilterButton(),
//             _buildRadioButtons(),
//             SizedBox(height: 3.h),

//             _buildCityDropdown(),
//             SizedBox(height: 3.h),
//             _buildLocationDropdown(),
//             SizedBox(height: 3.h),
//             _buildCategoryDropdown(),
//             SizedBox(height: 3.h),
//             _buildGradeDropdown(),
//             SizedBox(height: 3.h),
//             _buildMaxMinDropdownRow(), // Add Max and Min dropdowns in a row
//             SizedBox(height: 16),
//             _buildApplyFilterButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget for Clear Filter Button
//   Widget _buildClearFilterButton() {
//     return Row(
//       children: [
//         Spacer(),
//         GestureDetector(
//           onTap: () async {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             await prefs.remove('filter_keys_url');
//             await prefs.remove('selectpropertytype');
//             await prefs.remove('selectedcityid');
//             await prefs.remove('selectedlocationid');
//             await prefs.remove('selectedcategoryid');
//             await prefs.remove('selectedgrade');
//             await prefs.remove('selectedminimumbudget');
//             await prefs.remove('selectedmaxbudget');
//             print('Preferences cleared!');

//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => SubCategory()),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: ColorConstants.textcolor,
//                   width: 1.0,
//                 ),
//               ),
//             ),
//             child: Text(
//               'Clear Filter',
//               style: GoogleFonts.plusJakartaSans(
//                 color: ColorConstants.lightblue,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Widget for Radio Buttons (Buy or Rent)
//   Widget _buildRadioButtons() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Type',
//           style: GoogleFonts.plusJakartaSans(
//             color: Color(0xFF2B395F),
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         Row(
//           children: [
//             Radio(
//               value: 0,
//               groupValue: _selectedValue,
//               onChanged: (int? value) {
//                 setState(() {
//                   _selectedValue = value!;
//                 });
//               },
//             ),
//             Text(
//               'Buy',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Color(0xFF2B395F),
//                 fontSize: 11.sp,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             SizedBox(width: 10),
//             Radio(
//               value: 1,
//               groupValue: _selectedValue,
//               onChanged: (int? value) {
//                 setState(() {
//                   _selectedValue = value!;
//                 });
//               },
//             ),
//             Text(
//               'Rent',
//               style: GoogleFonts.plusJakartaSans(
//                 color: Color(0xFF2B395F),
//                 fontSize: 11.sp,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   // Widget for City Dropdown
//   Widget _buildCityDropdown() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'City',
//           style: GoogleFonts.plusJakartaSans(
//             color: Color(0xFF2B395F),
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         SizedBox(height: 1.h),
//         DropdownButtonFormField<City>(
//           value: selectedCity,
//           hint: Align(
//             alignment: Alignment.centerRight,
//             child: Text(
//               'Select a City',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           onChanged: (City? newValue) {
//             setState(() {
//               selectedCity = newValue;
//               selectedCityId = newValue?.id;
//               _fetchLocationList(
//                   selectedCityId); // Fetch locations when city is selected
//             });
//             // Print the selected city name and ID
//             if (newValue != null) {
//               print("Selected City: ${newValue.listTitle}");
//               print("Selected City ID: ${newValue.id}");
//               setState(() {
//                 selectedcityvalue = " ${newValue.listTitle}";
//                 print(selectedcityvalue.toString());
//               });
//             }
//           },
//           items: cityList.map((City city) {
//             return DropdownMenuItem<City>(
//               value: city,
//               child: Text(city.listTitle.toString()),
//             );
//           }).toList(),
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide(color: Colors.black, width: 1.5),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide(color: Colors.black, width: 2),
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//           ),
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//           icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//           dropdownColor: Colors.white,
//         ),
//       ],
//     );
//   }

//   // Widget for Location Dropdown
//   Widget _buildLocationDropdown() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Location',
//           style: GoogleFonts.plusJakartaSans(
//             color: Color(0xFF2B395F),
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         SizedBox(height: 1.h),
//         DropdownButtonFormField<Locationlist>(
//           value: selectedLocation,
//           hint: Align(
//             alignment: Alignment.centerRight,
//             child: Text(
//               'Select a Location',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           onChanged: (Locationlist? newValue) {
//             setState(() {
//               selectedLocation = newValue;
//               selectedLocationId = newValue?.id;
//             });

//             // Print selected location details
//             if (selectedLocation != null) {
//               print('Selected Location: ${selectedLocation!.areaTitle}');
//               print(
//                   'Status: ${selectedLocation!.statusAdd == 1 ? "Active" : "Inactive"}');
//               setState(() {
//                 selectedlocationvalue = '${selectedLocation!.areaTitle}';
//               });
//             }
//           },
//           items: locationList.map((Locationlist location) {
//             return DropdownMenuItem<Locationlist>(
//               value: location,
//               child: Row(
//                 children: [
//                   Text(
//                     location.areaTitle.toString(),
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   SizedBox(width: 10),
//                   location.statusAdd == 1
//                       ? Icon(Icons.check_circle, color: Colors.green, size: 16)
//                       : Icon(Icons.cancel, color: Colors.red, size: 16),
//                 ],
//               ),
//             );
//           }).toList(),
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide(color: Colors.black, width: 1.5),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide(color: Colors.black, width: 2),
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//           ),
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//           icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//           dropdownColor: Colors.white,
//         ),
//       ],
//     );
//   }

//   // Widget for Category Dropdown
//   Widget _buildCategoryDropdown() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Category',
//           style: GoogleFonts.plusJakartaSans(
//             color: Color(0xFF2B395F),
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         SizedBox(height: 1.h),
//         Consumer<CategoryProvider>(
//           builder: (context, categoryProvider, child) {
//             // Check if the categories are loaded
//           return  DropdownButtonFormField<String>(
//                 value: categoryProvider.selectedTitle.isEmpty
//                     ? null
//                     : categoryProvider.selectedTitle,
//                 hint: Text("Select a category"),
//                 onChanged: (String? newValue) {
//                   // Find the selected category based on title
//                   final selectedCategory = categoryProvider.categories
//                       .firstWhere((category) => category.listTitle == newValue);
//                   categoryProvider.setSelectedCategory(
//                       selectedCategory.listTitle!,
//                       selectedCategory.id.toString());
//                   setState(() {
//                     selectedcatid = selectedCategory.id.toString();
//                     selectedcategorytext = selectedCategory.listTitle!;
//                   });
//                   print('${selectedcatid}${selectedcategorytext}');
//                 },
//                 items:
//                     categoryProvider.categories.map<DropdownMenuItem<String>>(
//                   (Categories category) {
//                     return DropdownMenuItem<String>(
//                       value: category.listTitle,
//                       child: Text(category.listTitle ?? 'Unknown'),
//                     );
//                   },
//                 ).toList(),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide(color: Colors.black, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                 ),
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//                 dropdownColor: Colors.white,
//               );
//           },
//         )
//       ],
//     );
//   }

//   // Widget for Grade Dropdown
//   Widget _buildGradeDropdown() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Grade',
//           style: GoogleFonts.plusJakartaSans(
//             color: Color(0xFF2B395F),
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         SizedBox(height: 1.h),
//         DropdownButtonFormField<String>(
//           value: selectedGrade,
//           hint: Align(
//             alignment: Alignment.centerRight,
//             child: Text(
//               'Select a Grade',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           onChanged: (String? newValue) {
//             setState(() {
//               selectedGrade = newValue;
//             });
//           },
//           items: gradeList.map((String grade) {
//             return DropdownMenuItem<String>(
//               value: grade,
//               child: Text(grade),
//             );
//           }).toList(),
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide(color: Colors.black, width: 1.5),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide(color: Colors.black, width: 2),
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//           ),
//           style: GoogleFonts.plusJakartaSans(
//             color: Colors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//           icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//           dropdownColor: Colors.white,
//         ),
//       ],
//     );
//   }

//   // Row Widget for Max and Min Value Dropdowns
//   Widget _buildMaxMinDropdownRow() {
//     return Row(
//       children: [
//         // Max Value Dropdown
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 'Max',
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFF2B395F),
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(height: 1.h),
//               DropdownButtonFormField<String>(
//                 value: selectedMaxValue,
//                 hint: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'Select Max Value',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedMaxValue = newValue;
//                   });
//                 },
//                 items: maxValues.map((String max) {
//                   return DropdownMenuItem<String>(
//                     value: max,
//                     child: Text(max),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide(color: Colors.black, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                 ),
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//                 dropdownColor: Colors.white,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(width: 10),
//         // Min Value Dropdown
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 'Min',
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Color(0xFF2B395F),
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(height: 1.h),
//               DropdownButtonFormField<String>(
//                 value: selectedMinValue,
//                 hint: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'Select Min Value',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedMinValue = newValue;
//                   });
//                 },
//                 items: minValues.map((String min) {
//                   return DropdownMenuItem<String>(
//                     value: min,
//                     child: Text(min),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide(color: Colors.black, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                 ),
//                 style: GoogleFonts.plusJakartaSans(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//                 dropdownColor: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

// // Widget for Apply Filter Button
//   Widget _buildApplyFilterButton(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           onPressed: () async {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             setState(() {
//               // Determine "Buy" or "Rent" based on _selectedValue
//               String propertyType = _selectedValue.toString() == '0'
//                   ? 'B'
//                   : _selectedValue.toString() == '1'
//                       ? 'R'
//                       : '';

//               // Extract grade letter from selectedGrade
//               List<String> parts = selectedGrade.toString().split("Grade ");
//               String gradeLetter = parts.length > 1 ? parts[1] : '';

//               // Debug print statements
//               print('procat=${selectedcatid}${selectedcategorytext}');

//               print('scity=${selectedCityId}');
//               print('sarea=${selectedLocationId}');
//               print('pgrade=${gradeLetter}');
//               print('BudgetMin=${selectedMaxValue.toString()}');
//               print('BudgetMax=${selectedMinValue.toString()}');

//               var keysurl =
//                   "procat=${propertyType}&scity=${selectedCityId}&sarea=${selectedLocationId}&sprop=${selectedcatid}&pgrade=${gradeLetter}&BudgetMin=${selectedMaxValue.toString()}&BudgetMax=${selectedMinValue.toString()}";

//               print(keysurl.toString() + 'keysurlwith stringlist');
//               prefs.setString('filter_keys_url', keysurl);
//               prefs.setString('selectpropertytype', propertyType);
//               prefs.setString('selectedcityid', selectedCityId.toString());
//               prefs.setString(
//                   'selectedlocationid', selectedLocationId.toString());
//               prefs.setString('selectedcategoryid', '${selectedcatid}');
//               prefs.setString('selectedgrade', gradeLetter.toString());
//               prefs.setString(
//                   'selectedminimumbudget', selectedMinValue.toString());
//               prefs.setString('selectedmaxbudget', selectedMaxValue.toString());
//               prefs.setString('selectedcattex', selectedcategorytext);

//               // Confirm saving with a debug print statementselectedcategorytext
//               print(
//                   "keysurl saved in SharedPreferences: ${prefs.getString('filter_keys_url')}");
//               print('${prefs.getString('selectpropertytype')}');
//               print('${prefs.getString('selectedcityid')}');
//               print('${prefs.getString('selectedlocationid')}');
//               print('${prefs.getString('selectedcategoryid')}');
//               print('${prefs.getString('selectedgrade')}');
//               print('${prefs.getString('selectedminimumbudget')}');
//               print('${prefs.getString('selectedmaxbudget')}');
//               Navigator.of(context).pop();
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => SubCategory()),
//               // );
//             });
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: ColorConstants.lightblue,
//             padding: EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//           child: Text(
//             'Apply Filter',
//             style: GoogleFonts.plusJakartaSans(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
