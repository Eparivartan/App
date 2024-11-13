import 'package:sizer/sizer.dart';

import 'keyboard_rows.dart';
import 'package:flutter/material.dart';
import 'keyboard_buttons.dart';

class Keyboard extends StatelessWidget {
  Keyboard({required this.onTap, required this.keyboardSigns});

  final CallbackButtonTap onTap;
  final List keyboardSigns;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     
      child: Column(
        children: keyboardSigns.map((signs) {
          return KeyboardRows(
            rowsButtons: signs,
            onTap: onTap,
          );
        }).toList(),
      ),
    );
  }
}
