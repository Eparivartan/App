import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class CCButton extends StatefulWidget {
  final String? buttonText;
  final double? buttonWidth;
  final double? buttonHeight;

  const CCButton(
      {Key? key, this.buttonText, this.buttonWidth, this.buttonHeight})
      : super(key: key);

  @override
  State<CCButton> createState() => _CCButtonState();
}

class _CCButtonState extends State<CCButton> {
  String? get buttonText => widget.buttonText;

  double? get buttonWidth => widget.buttonWidth;

  double? get buttonHeight => widget.buttonHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight,
      width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const (),
          //   ),
          // );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xfff1f1f1),
          // padding: EdgeInsets.symmetric(
          //     horizontal: 30.w, vertical: 2.h),
          elevation: 0,
        ),
        child: Text(
          buttonText ?? '',
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            color: const Color(0xff333333),
          ),
        ),
      ),
    );
  }
}
