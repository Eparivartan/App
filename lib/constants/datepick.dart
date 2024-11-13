import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:legala/constants/coloconstant.dart';
import 'package:legala/constants/imageconstant.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerDemo extends StatefulWidget {
  @override
  _DatePickerDemoState createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  DateTime? selectedDate;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedDate = args.value;
    });
    Navigator.of(context).pop(); // Close the dialog after selection
  }

  void _showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Date'),
          content: Container(
            width: double.maxFinite,
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              initialDisplayDate: DateTime.now(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 0),
             
                 decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showDatePickerDialog(context);
                          },
                          child: Container(
                              height: 40,
                              padding:
                                  EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                        ),
                        // Display selected date or message,
                        SizedBox(
                          width: 5..w,
                        ),
                        Container(
                          height: 40,
                          width: 50.w,
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          decoration: BoxDecoration(
                              color: ColorConstants.whiteColor,
                              borderRadius: BorderRadius.circular(5.3),
                              border: Border.all(
                                  color: ColorConstants.filterborderColor, width: 1)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              selectedDate == null
                                  ? 'Select date'
                                  : ' ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.urbanist(
                                  color: ColorConstants.secondaryColor,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                
                        // Button to open the date picker dialog
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text('Mark as Paid',
                              style: GoogleFonts.plusJakartaSans(
                                  color: ColorConstants.whiteColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      );
  }
}
